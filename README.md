# imap.nim

A small **synchronous** IMAP4rev1 / IMAP4rev2 client library for Nim,
built on the standard `net` module. It uses implicit TLS (port 993) by
default, so applications must be compiled with `-d:ssl`.

## Example

```nim
import imap

let client = newImapClient()
client.connect("mail.example.org", imapPort, "user", "password")

let info = client.select("INBOX")
echo info.exists, " messages, ", info.recent, " recent"

for n in client.search("ALL"):
  echo client.fetch(n, "ENVELOPE")

client.close()
```

## API overview

- Connection: `connect`, `login` / `authenticate`, `logout` / `close`
- Mailboxes: `select`, `examine`, `create`, `delete`, `rename`,
  `subscribe`, `unsubscribe`, `list`, `status`, `capability`, `noop`
- Messages: `search`, `uidSearch`, `fetch`, `uidFetch`, `store`,
  `uidStore`, `copy`, `uidCopy`, `move`, `uidMove`, `expunge`, `append`

Commands that fail with a tagged `NO` or `BAD` response raise
`ReplyError`.
