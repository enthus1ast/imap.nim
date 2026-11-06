## Synchronous IMAP4rev1 / IMAP4rev2 client library.
##
## This is a small, blocking IMAP client built on top of the standard `net`
## module.  It speaks implicit TLS by default (port 993), so it must be
## compiled with `-d:ssl`:
##
##   nim c -d:ssl your_program.nim
##
## Minimal example:
##
##   import imap
##
##   let client = newImapClient()
##   client.connect("mail.example.org", imapPort, "user", "password")
##   let info = client.select("INBOX")
##   echo "messages: ", info.exists
##   for n in client.search("ALL"):
##     echo client.fetch(n, "ENVELOPE")
##   client.close()

import net, strutils, strscans, strformat, parseutils

when not defined(ssl):
  {.error: "IMAP client requires -d:ssl".}

const
  imapPort* = 993.Port
  CRLF* = "\r\n"

type
  Status* = object
    ## Mailbox size summary reported through `StatusCallback`.
    exists*: int
    recent*: int

  StatusCallback* = proc (st: Status)

  SelectInfo* = object
    ## Result of a successful SELECT or EXAMINE command.
    exists*: int
    recent*: int
    flags*: seq[string]
    permanentFlags*: seq[string]
    uidValidity*: int
    uidNext*: int
    unseen*: int
    readWrite*: bool

  Mailbox* = object
    ## A single mailbox returned by `list`.
    attributes*: seq[string]
    delim*: string
    name*: string

  MailboxStatus* = object
    ## Result of a STATUS command.
    name*: string
    messages*: int
    recent*: int
    uidNext*: int
    uidValidity*: int
    unseen*: int

  TaggedReply* = object
    ## A tagged server completion response.
    tag*: string
    condition*: string          ## "OK", "NO", or "BAD"
    text*: string
    untagged*: seq[string]

  ReplyError* = object of IOError
    ## Raised when a command completes with NO or BAD.
    tag*: string
    condition*: string
    text*: string

  LineHandler = proc (line: string) {.closure.}

  ImapClient* = ref object
    sock: Socket
    sslContext: SslContext
    tagAlloc: int
    status: Status
    statCb: StatusCallback
    greeting: string

# ---------------------------------------------------------------------------
# String helpers
# ---------------------------------------------------------------------------

proc quoteAstring(s: string): string =
  ## Quote `s` as an IMAP astring, escaping backslashes and double quotes.
  result = "\""
  for c in s:
    if c == '\\' or c == '"':
      result.add '\\'
    result.add c
  result.add '"'

proc quoteMailbox(name: string): string =
  ## Mailbox names are astrings.  Leave an already quoted name alone.
  if name.len >= 2 and name[0] == '"' and name[^1] == '"':
    return name
  quoteAstring(name)

proc skipSpaces(s: string; i: var int) =
  while i < s.len and s[i] == ' ':
    inc i

proc parseQuoted(s: string; i: var int): string =
  ## Parse a quoted string starting at s[i] == '"'.  Advances `i`.
  inc i
  result = ""
  while i < s.len:
    case s[i]
    of '\\':
      if i + 1 < s.len:
        inc i
        result.add s[i]
        inc i
      else:
        inc i
    of '"':
      inc i
      return
    else:
      result.add s[i]
      inc i

proc parseAstring(s: string; i: var int): string =
  ## Parse an astring (quoted string or atom).  Advances `i`.
  if i < s.len and s[i] == '"':
    result = parseQuoted(s, i)
  else:
    let start = i
    while i < s.len and s[i] != ' ' and s[i] != ')':
      inc i
    result = s[start ..< i]

proc parenTokens(s: string): seq[string] =
  ## Return the whitespace-separated tokens inside the first (...) group.
  let start = s.find('(')
  if start < 0:
    return @[]
  let close = s.find(')', start + 1)
  if close < 0:
    return @[]
  result = s[start + 1 ..< close].splitWhitespace()

proc literalLengthAtEnd(s: string): int =
  ## If `s` ends with an IMAP literal marker "{n}", return n; otherwise -1.
  if s.len < 3 or s[^1] != '}':
    return -1
  var open = s.len - 2
  while open >= 0 and s[open] in {'0'..'9'}:
    dec open
  if open < 0 or s[open] != '{' or open == s.len - 2:
    return -1
  result = parseInt(s[open + 1 .. s.len - 2])

# ---------------------------------------------------------------------------
# Core protocol helpers
# ---------------------------------------------------------------------------

proc newImapClient*(cb: StatusCallback = nil): ImapClient =
  ## Create a new IMAP client.  `cb` (optional) is called whenever both a
  ## message count (EXISTS) and a recent count (RECENT) have been observed.
  result = ImapClient(
    sock: newSocket(),
    sslContext: net.newContext(verifyMode = CVerifyNone),
    statCb: cb)
  wrapSocket(result.sslContext, result.sock)
  result.status = Status(exists: -1, recent: -1)

proc nextTag(imap: ImapClient): string =
  inc imap.tagAlloc
  "A" & $imap.tagAlloc

proc sendLine(imap: ImapClient; line: string) =
  imap.sock.send(line & CRLF)

proc statusFromUntagged(imap: ImapClient; line: string) =
  var n: int
  if line.scanf("* $i EXISTS", n):
    imap.status.exists = n
  elif line.scanf("* $i RECENT", n):
    imap.status.recent = n
  if imap.status.exists >= 0 and imap.status.recent >= 0:
    if imap.statCb != nil:
      imap.statCb(imap.status)
    imap.status.exists = -1
    imap.status.recent = -1

proc readReply(imap: ImapClient; tag: string; onUntagged: LineHandler = nil): TaggedReply =
  ## Read server responses until the tagged completion line for `tag`.
  ## Each untagged "*" line is passed to `onUntagged` and remembered in
  ## `result.untagged`.
  result.tag = tag
  result.untagged = @[]
  while true:
    let line = imap.sock.recvLine()
    if line.len == 0:
      imap.sock.close()
      raise newException(IOError, "Connection closed while awaiting " & tag & " reply")
    if line[0] == '*':
      result.untagged.add line
      if onUntagged != nil:
        onUntagged(line)
      imap.statusFromUntagged(line)
    elif line[0] == '+':
      # Command continuation request.  Normal commands do not expect these;
      # APPEND handles them separately.
      discard
    else:
      var rtag = ""
      let n = line.parseUntil(rtag, ' ')
      if n > 0 and rtag == tag:
        let rest = line.substr(n + 1)
        let sp = rest.find(' ')
        if sp < 0:
          result.condition = rest
          result.text = ""
        else:
          result.condition = rest[0 ..< sp]
          result.text = rest[sp + 1 .. ^1]
        return
      # A tagged reply for another tag; ignore it.

proc command(imap: ImapClient; cmd: string; args = ""; onUntagged: LineHandler = nil): TaggedReply =
  let tag = imap.nextTag()
  if args.len == 0:
    imap.sendLine(fmt"{tag} {cmd}")
  else:
    imap.sendLine(fmt"{tag} {cmd} {args}")
  result = imap.readReply(tag, onUntagged)

proc checkOk*(reply: TaggedReply) =
  ## Raise `ReplyError` unless `reply.condition == "OK"`.
  if reply.condition != "OK":
    var e = newException(ReplyError, reply.condition & " " & reply.text)
    e.tag = reply.tag
    e.condition = reply.condition
    e.text = reply.text
    raise e

# ---------------------------------------------------------------------------
# Connection and authentication
# ---------------------------------------------------------------------------

proc connect*(imap: ImapClient; host: string; port = imapPort; timeout = -1) =
  ## Connect to an IMAP server and read its greeting.
  if timeout >= 0:
    imap.sock.connect(host, port, timeout)
  else:
    imap.sock.connect(host, port)
  imap.greeting = imap.sock.recvLine()
  if imap.greeting.len == 0:
    imap.sock.close()
    raise newException(IOError, "No greeting from IMAP server")
  if not (imap.greeting.startsWith("* OK") or imap.greeting.startsWith("* PREAUTH")):
    raise newException(ReplyError, "Unexpected server greeting: " & imap.greeting)

proc login*(imap: ImapClient; user, pass: string) =
  ## Authenticate using the LOGIN command.  Prefer TLS (the default port 993).
  let reply = imap.command("LOGIN", quoteAstring(user) & " " & quoteAstring(pass))
  checkOk(reply)

proc authenticate*(imap: ImapClient; user, pass: string) =
  ## Alias for `login`.
  imap.login(user, pass)

proc connect*(imap: ImapClient; host: string; port: Port; user, pass: string) =
  ## Connect and authenticate in one step.
  imap.connect(host, port)
  imap.login(user, pass)

proc logout*(imap: ImapClient) =
  ## Send LOGOUT and close the connection.  Errors are ignored so this is
  ## safe to call from a `finally`-like cleanup path.
  try:
    discard imap.command("LOGOUT")
  except:
    discard
  imap.sock.close()
  imap.sslContext.destroyContext()

proc close*(imap: ImapClient) =
  ## Alias for `logout`.
  imap.logout()

# ---------------------------------------------------------------------------
# Mailboxes
# ---------------------------------------------------------------------------

proc capability*(imap: ImapClient): seq[string] =
  var caps = newSeq[string]()
  let onUntagged = proc (line: string) =
    if line.startsWith("* CAPABILITY"):
      let rest = line.substr("* CAPABILITY".len).strip()
      for cap in rest.splitWhitespace():
        caps.add cap
  let reply = imap.command("CAPABILITY", "", onUntagged)
  checkOk(reply)
  result = caps

proc noop*(imap: ImapClient) =
  checkOk(imap.command("NOOP"))

proc select*(imap: ImapClient; name: string): SelectInfo =
  ## Select a mailbox and return its current state.
  var info = SelectInfo(
    exists: -1, recent: -1, uidValidity: -1, uidNext: -1, unseen: -1)
  let onUntagged = proc (line: string) =
    var n: int
    if line.scanf("* $i EXISTS", n):
      info.exists = n
    elif line.scanf("* $i RECENT", n):
      info.recent = n
    elif line.startsWith("* FLAGS"):
      info.flags = parenTokens(line)
    elif line.startsWith("* OK [PERMANENTFLAGS"):
      info.permanentFlags = parenTokens(line)
    elif line.scanf("* OK [UIDVALIDITY $i]", n):
      info.uidValidity = n
    elif line.scanf("* OK [UIDNEXT $i]", n):
      info.uidNext = n
    elif line.scanf("* OK [UNSEEN $i]", n):
      info.unseen = n
  let reply = imap.command("SELECT", quoteMailbox(name), onUntagged)
  checkOk(reply)
  info.readWrite = reply.text.startsWith("[READ-WRITE]")
  result = info

proc examine*(imap: ImapClient; name: string): SelectInfo =
  ## Select a mailbox read-only.
  var info = SelectInfo(
    exists: -1, recent: -1, uidValidity: -1, uidNext: -1, unseen: -1)
  let onUntagged = proc (line: string) =
    var n: int
    if line.scanf("* $i EXISTS", n):
      info.exists = n
    elif line.scanf("* $i RECENT", n):
      info.recent = n
    elif line.startsWith("* FLAGS"):
      info.flags = parenTokens(line)
    elif line.startsWith("* OK [PERMANENTFLAGS"):
      info.permanentFlags = parenTokens(line)
    elif line.scanf("* OK [UIDVALIDITY $i]", n):
      info.uidValidity = n
    elif line.scanf("* OK [UIDNEXT $i]", n):
      info.uidNext = n
    elif line.scanf("* OK [UNSEEN $i]", n):
      info.unseen = n
  let reply = imap.command("EXAMINE", quoteMailbox(name), onUntagged)
  checkOk(reply)
  info.readWrite = false
  result = info

proc create*(imap: ImapClient; name: string) =
  checkOk(imap.command("CREATE", quoteMailbox(name)))

proc delete*(imap: ImapClient; name: string) =
  checkOk(imap.command("DELETE", quoteMailbox(name)))

proc rename*(imap: ImapClient; oldName, newName: string) =
  checkOk(imap.command("RENAME", quoteMailbox(oldName) & " " & quoteMailbox(newName)))

proc subscribe*(imap: ImapClient; name: string) =
  checkOk(imap.command("SUBSCRIBE", quoteMailbox(name)))

proc unsubscribe*(imap: ImapClient; name: string) =
  checkOk(imap.command("UNSUBSCRIBE", quoteMailbox(name)))

proc list*(imap: ImapClient; refName = ""; pattern = "*"): seq[Mailbox] =
  ## Return mailboxes matching `pattern` (LIST command).
  var boxes = newSeq[Mailbox]()
  let onUntagged = proc (line: string) =
    if line.startsWith("* LIST"):
      var box = Mailbox()
      var i = "* LIST".len
      skipSpaces(line, i)
      if i < line.len and line[i] == '(':
        box.attributes = parenTokens(line[i .. ^1])
        let close = line.find(')', i)
        if close >= 0:
          i = close + 1
      skipSpaces(line, i)
      box.delim = parseAstring(line, i)
      if box.delim == "NIL":
        box.delim = ""
      skipSpaces(line, i)
      box.name = parseAstring(line, i)
      boxes.add box
  let reply = imap.command("LIST", quoteMailbox(refName) & " " & quoteMailbox(pattern), onUntagged)
  checkOk(reply)
  result = boxes

proc status*(imap: ImapClient; name: string;
             items = "(MESSAGES RECENT UIDNEXT UIDVALIDITY UNSEEN)"): MailboxStatus =
  ## Query mailbox status without selecting it.
  var st = MailboxStatus(
    name: name, messages: -1, recent: -1, uidNext: -1, uidValidity: -1, unseen: -1)
  let onUntagged = proc (line: string) =
    if line.startsWith("* STATUS"):
      var i = "* STATUS".len
      skipSpaces(line, i)
      let mailboxName = parseAstring(line, i)
      if mailboxName.len > 0:
        st.name = mailboxName
      skipSpaces(line, i)
      if i < line.len and line[i] == '(':
        let toks = parenTokens(line[i .. ^1])
        var j = 0
        while j + 1 < toks.len:
          let key = toks[j].toUpperAscii()
          let value = try: parseInt(toks[j + 1]) except ValueError: -1
          case key
          of "MESSAGES": st.messages = value
          of "RECENT": st.recent = value
          of "UIDNEXT": st.uidNext = value
          of "UIDVALIDITY": st.uidValidity = value
          of "UNSEEN": st.unseen = value
          else: discard
          j += 2
  let reply = imap.command("STATUS", quoteMailbox(name) & " " & items, onUntagged)
  checkOk(reply)
  result = st

# ---------------------------------------------------------------------------
# Messages
# ---------------------------------------------------------------------------

proc parseFetchLine(line: string; seqNum: var int; rest: var string): bool =
  ## Parse "* <n> FETCH <rest>".  Returns false on mismatch.
  if not line.startsWith("* "):
    return false
  var i = 2
  while i < line.len and line[i] in {'0'..'9'}:
    inc i
  if i == 2:
    return false
  seqNum = parseInt(line[2 ..< i])
  const prefix = " FETCH "
  if i + prefix.len > line.len or line.substr(i, i + prefix.len - 1) != prefix:
    return false
  rest = line.substr(i + prefix.len)
  result = true

proc readLiteralBytes(imap: ImapClient; n: int): string =
  result = newStringOfCap(n)
  var left = n
  while left > 0:
    let chunk = imap.sock.recv(left)
    if chunk.len == 0:
      raise newException(IOError, "Connection closed while reading literal")
    result.add chunk
    left -= chunk.len

proc readFetchPayload(imap: ImapClient; payload: string): string =
  ## Given the text after "FETCH " in an untagged FETCH line, inline any
  ## trailing literal and its closing line.
  result = payload
  let lit = literalLengthAtEnd(payload)
  if lit >= 0:
    result.add imap.readLiteralBytes(lit)
    result.add imap.sock.recvLine()

proc fetch*(imap: ImapClient; seqNum: int; items: string): string =
  ## FETCH `items` for the message with sequence number `seqNum` and return
  ## the reconstructed untagged FETCH payload.
  var data = ""
  let onUntagged = proc (line: string) =
    var seq: int
    var rest: string
    if parseFetchLine(line, seq, rest) and seq == seqNum:
      data.add imap.readFetchPayload(rest)
  let reply = imap.command("FETCH", $seqNum & " " & items, onUntagged)
  checkOk(reply)
  result = data

proc payloadUid(payload: string): int =
  ## Extract the first "UID <n>" value from a FETCH payload, or -1.
  let idx = payload.find("UID ")
  if idx < 0:
    return -1
  var i = idx + 4
  while i < payload.len and payload[i] in {'0'..'9'}:
    inc i
  if i == idx + 4:
    return -1
  result = parseInt(payload[idx + 4 ..< i])

proc uidFetch*(imap: ImapClient; uid: int; items: string): string =
  ## `UID FETCH` for the message with the given unique identifier.
  var data = ""
  let onUntagged = proc (line: string) =
    var seq: int
    var rest: string
    if parseFetchLine(line, seq, rest) and payloadUid(rest) == uid:
      data.add imap.readFetchPayload(rest)
  let reply = imap.command("UID", "FETCH " & $uid & " " & items, onUntagged)
  checkOk(reply)
  result = data

proc expandEsearchAll(line: string): seq[int] =
  ## Best-effort parse of an ESEARCH "ALL ..." result (rev2 servers).
  result = @[]
  let idx = line.find(" ALL ")
  if idx < 0:
    return
  let rest = line.substr(idx + " ALL ".len).strip()
  if rest.len == 0:
    return
  for part in rest.split(','):
    let bounds = part.split(':')
    if bounds.len == 1:
      try:
        result.add parseInt(bounds[0])
      except ValueError:
        discard
    elif bounds.len == 2:
      try:
        let a = parseInt(bounds[0])
        let b = parseInt(bounds[1])
        for n in a .. b:
          result.add n
      except ValueError:
        discard

proc search*(imap: ImapClient; spec: string): seq[int] =
  ## Search the selected mailbox and return matching message sequence numbers.
  ## Handles both rev1 `* SEARCH` and rev2 `* ESEARCH ... ALL` responses.
  var nums = newSeq[int]()
  let onUntagged = proc (line: string) =
    if line.startsWith("* SEARCH"):
      for tok in line.substr("* SEARCH".len).splitWhitespace():
        try:
          nums.add parseInt(tok)
        except ValueError:
          discard
    elif line.startsWith("* ESEARCH"):
      for n in expandEsearchAll(line):
        nums.add n
  let reply = imap.command("SEARCH", spec, onUntagged)
  checkOk(reply)
  result = nums

proc uidSearch*(imap: ImapClient; spec: string): seq[int] =
  ## UID SEARCH variant of `search`.
  var nums = newSeq[int]()
  let onUntagged = proc (line: string) =
    if line.startsWith("* SEARCH"):
      for tok in line.substr("* SEARCH".len).splitWhitespace():
        try:
          nums.add parseInt(tok)
        except ValueError:
          discard
    elif line.startsWith("* ESEARCH"):
      for n in expandEsearchAll(line):
        nums.add n
  let reply = imap.command("UID", "SEARCH " & spec, onUntagged)
  checkOk(reply)
  result = nums

proc store*(imap: ImapClient; seqSet: string; data: string) =
  checkOk(imap.command("STORE", seqSet & " " & data))

proc uidStore*(imap: ImapClient; uidSet: string; data: string) =
  checkOk(imap.command("UID", "STORE " & uidSet & " " & data))

proc copy*(imap: ImapClient; seqSet: string; mailbox: string) =
  checkOk(imap.command("COPY", seqSet & " " & quoteMailbox(mailbox)))

proc uidCopy*(imap: ImapClient; uidSet: string; mailbox: string) =
  checkOk(imap.command("UID", "COPY " & uidSet & " " & quoteMailbox(mailbox)))

proc move*(imap: ImapClient; seqSet: string; mailbox: string) =
  checkOk(imap.command("MOVE", seqSet & " " & quoteMailbox(mailbox)))

proc uidMove*(imap: ImapClient; uidSet: string; mailbox: string) =
  checkOk(imap.command("UID", "MOVE " & uidSet & " " & quoteMailbox(mailbox)))

proc expunge*(imap: ImapClient) =
  checkOk(imap.command("EXPUNGE"))

proc append*(imap: ImapClient; mailbox, msg: string; flags = "") =
  ## Append `msg` (a complete RFC 5322 message) to `mailbox`.
  let tag = imap.nextTag()
  var args = quoteMailbox(mailbox)
  if flags.len > 0:
    args.add " " & flags
  args.add " {" & $msg.len & "}"
  imap.sendLine(fmt"{tag} APPEND {args}")
  let cont = imap.sock.recvLine()
  if cont.len == 0 or cont[0] != '+':
    raise newException(ReplyError, "APPEND continuation expected, got: " & cont)
  imap.sock.send(msg & CRLF)
  checkOk(imap.readReply(tag))
