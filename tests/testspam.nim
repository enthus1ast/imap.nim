import imap

const
  hostname = "imap.spam.works"
  user = "test@spam.works"
  pass = "Abcd1234."

proc main() =
  proc reportStatus(stat: Status) =
    echo "--- exists=", stat.exists, " recent=", stat.recent, " ---"

  let imap = newImapClient(reportStatus)
  imap.connect(hostname, imapPort, user, pass)
  let info = imap.select("inbox")
  echo "inbox: ", info.exists, " messages"
  imap.close()

main()
