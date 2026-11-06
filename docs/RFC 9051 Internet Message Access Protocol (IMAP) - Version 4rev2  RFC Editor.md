## [Abstract](https://www.rfc-editor.org/info/rfc9051/#abstract)

The Internet Message Access Protocol Version 4rev2 (IMAP4rev2) allows a client to access and manipulate electronic mail messages on a server. IMAP4rev2 permits manipulation of mailboxes (remote message folders) in a way that is functionally equivalent to local folders. IMAP4rev2 also provides the capability for an offline client to resynchronize with the server.[¶](https://www.rfc-editor.org/info/rfc9051/#section-abstract-1)

IMAP4rev2 includes operations for creating, deleting, and renaming mailboxes; checking for new messages; removing messages permanently; setting and clearing flags; parsing per RFCs 5322, 2045, and 2231; searching; and selective fetching of message attributes, texts, and portions thereof. Messages in IMAP4rev2 are accessed by the use of numbers. These numbers are either message sequence numbers or unique identifiers.[¶](https://www.rfc-editor.org/info/rfc9051/#section-abstract-2)

IMAP4rev2 does not specify a means of posting mail; this function is handled by a mail submission protocol such as the one specified in RFC 6409.[¶](https://www.rfc-editor.org/info/rfc9051/#section-abstract-3)

## [Status of This Memo](https://www.rfc-editor.org/info/rfc9051/#name-status-of-this-memo)

This is an Internet Standards Track document.[¶](https://www.rfc-editor.org/info/rfc9051/#section-boilerplate.1-1)

This document is a product of the Internet Engineering Task Force (IETF). It represents the consensus of the IETF community. It has received public review and has been approved for publication by the Internet Engineering Steering Group (IESG). Further information on Internet Standards is available in Section 2 of RFC 7841.[¶](https://www.rfc-editor.org/info/rfc9051/#section-boilerplate.1-2)

Information about the current status of this document, any errata, and how to provide feedback on it may be obtained at [https://www.rfc-editor.org/info/rfc9051](https://www.rfc-editor.org/info/rfc9051).[¶](https://www.rfc-editor.org/info/rfc9051/#section-boilerplate.1-3)

## [Copyright Notice](https://www.rfc-editor.org/info/rfc9051/#name-copyright-notice)

Copyright (c) 2021 IETF Trust and the persons identified as the document authors. All rights reserved.[¶](https://www.rfc-editor.org/info/rfc9051/#section-boilerplate.2-1)

This document is subject to BCP 78 and the IETF Trust's Legal Provisions Relating to IETF Documents ([https://trustee.ietf.org/license-info](https://trustee.ietf.org/license-info)) in effect on the date of publication of this document. Please review these documents carefully, as they describe your rights and restrictions with respect to this document. Code Components extracted from this document must include Simplified BSD License text as described in Section 4.e of the Trust Legal Provisions and are provided without warranty as described in the Simplified BSD License.[¶](https://www.rfc-editor.org/info/rfc9051/#section-boilerplate.2-2)

This document may contain material from IETF Documents or IETF Contributions published or made publicly available before November 10, 2008. The person(s) controlling the copyright in some of this material may not have granted the IETF Trust the right to allow modifications of such material outside the IETF Standards Process. Without obtaining an adequate license from the person(s) controlling the copyright in such materials, this document may not be modified outside the IETF Standards Process, and derivative works of it may not be created outside the IETF Standards Process, except to format it for publication as an RFC or to translate it into languages other than English.[¶](https://www.rfc-editor.org/info/rfc9051/#section-boilerplate.2-3)

## [1\.](https://www.rfc-editor.org/info/rfc9051/#section-1) [How to Read This Document](https://www.rfc-editor.org/info/rfc9051/#name-how-to-read-this-document) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-1)

### [1.1.](https://www.rfc-editor.org/info/rfc9051/#section-1.1) [Organization of This Document](https://www.rfc-editor.org/info/rfc9051/#name-organization-of-this-docume) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-1.1)

This document is written from the point of view of the implementor of an IMAP4rev2 client or server. Beyond the protocol overview in [Section 2](https://www.rfc-editor.org/info/rfc9051/#protocol_overview), it is not optimized for someone trying to understand the operation of the protocol. The material in Sections [3](https://www.rfc-editor.org/info/rfc9051/#state_and_flow), [4](https://www.rfc-editor.org/info/rfc9051/#data_formats), and [5](https://www.rfc-editor.org/info/rfc9051/#operational_considerations) provides the general context and definitions with which IMAP4rev2 operates.[¶](https://www.rfc-editor.org/info/rfc9051/#section-1.1-1)

Sections [6](https://www.rfc-editor.org/info/rfc9051/#client_commands), [7](https://www.rfc-editor.org/info/rfc9051/#server-responses), and [9](https://www.rfc-editor.org/info/rfc9051/#IMAP-ABNF) describe the IMAP commands, responses, and syntax, respectively. The relationships among these are such that it is almost impossible to understand any of them separately. In particular, do not attempt to deduce command syntax from the command section alone; instead, refer to "Formal Syntax" ([Section 9](https://www.rfc-editor.org/info/rfc9051/#IMAP-ABNF)).[¶](https://www.rfc-editor.org/info/rfc9051/#section-1.1-2)

### [1.2.](https://www.rfc-editor.org/info/rfc9051/#section-1.2) [Conventions Used in This Document](https://www.rfc-editor.org/info/rfc9051/#name-conventions-used-in-this-do) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-1.2)

"Conventions" are basic principles or procedures. Document conventions are noted in this section.[¶](https://www.rfc-editor.org/info/rfc9051/#section-1.2-1)

In examples, "C:" and "S:" indicate lines sent by the client and server, respectively. Note that each line includes the terminating CRLF.[¶](https://www.rfc-editor.org/info/rfc9051/#section-1.2-2)

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in BCP 14 \[[RFC2119](https://www.rfc-editor.org/info/rfc9051/#RFC2119)\] \[[RFC8174](https://www.rfc-editor.org/info/rfc9051/#RFC8174)\] when, and only when, they appear in all capitals, as shown here.[¶](https://www.rfc-editor.org/info/rfc9051/#section-1.2-3)

The word "can" (not "may") is used to refer to a possible circumstance or situation, as opposed to an optional facility of the protocol.[¶](https://www.rfc-editor.org/info/rfc9051/#section-1.2-4)

"User" is used to refer to a human user, whereas "client" refers to the software being run by the user.[¶](https://www.rfc-editor.org/info/rfc9051/#section-1.2-5)

"Connection" refers to the entire sequence of client/server interaction from the initial establishment of the network connection until its termination.[¶](https://www.rfc-editor.org/info/rfc9051/#section-1.2-6)

"Session" refers to the sequence of client/server interaction from the time that a mailbox is selected (SELECT or EXAMINE command) until the time that selection ends (SELECT or EXAMINE of another mailbox, CLOSE command, UNSELECT command, or connection termination).[¶](https://www.rfc-editor.org/info/rfc9051/#section-1.2-7)

The term "Implicit TLS" refers to the automatic negotiation of TLS whenever a TCP connection is made on a particular TCP port that is used exclusively by that server for TLS connections. The term "Implicit TLS" is intended to contrast with the use of the STARTTLS command in IMAP that is used by the client and the server to explicitly negotiate TLS on an established cleartext TCP connection.[¶](https://www.rfc-editor.org/info/rfc9051/#section-1.2-8)

Characters are 8-bit UTF-8 (of which 7-bit US-ASCII is a subset), unless otherwise specified. Other character sets are indicated using a "CHARSET", as described in \[[MIME-IMT](https://www.rfc-editor.org/info/rfc9051/#RFC2046)\] and defined in \[[CHARSET](https://www.rfc-editor.org/info/rfc9051/#RFC2978)\]. CHARSETs have important additional semantics in addition to defining a character set; refer to these documents for more detail.[¶](https://www.rfc-editor.org/info/rfc9051/#section-1.2-9)

There are several protocol conventions in IMAP. These refer to aspects of the specification that are not strictly part of the IMAP protocol but reflect generally accepted practice. Implementations need to be aware of these conventions, and avoid conflicts whether or not they implement the convention. For example, "&" may not be used as a hierarchy delimiter since it conflicts with the Mailbox International Naming Convention, and other uses of "&" in mailbox names are impacted as well.[¶](https://www.rfc-editor.org/info/rfc9051/#section-1.2-10)

### [1.3.](https://www.rfc-editor.org/info/rfc9051/#section-1.3) [Special Notes to Implementors](https://www.rfc-editor.org/info/rfc9051/#name-special-notes-to-implemento) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-1.3)

Implementors of the IMAP protocol are strongly encouraged to read the IMAP implementation recommendations document \[[IMAP-IMPLEMENTATION](https://www.rfc-editor.org/info/rfc9051/#RFC2683)\] in conjunction with this document, to help understand the intricacies of this protocol and how best to build an interoperable product.[¶](https://www.rfc-editor.org/info/rfc9051/#section-1.3-1)

IMAP4rev2 is designed to be upwards compatible from the IMAP4rev1 \[[RFC3501](https://www.rfc-editor.org/info/rfc9051/#RFC3501)\], IMAP2 \[[IMAP2](https://www.rfc-editor.org/info/rfc9051/#RFC1176)\], and unpublished IMAP2bis \[[IMAP2BIS](https://www.rfc-editor.org/info/rfc9051/#I-D.ietf-imap-imap2bis)\] protocols. IMAP4rev2 is largely compatible with the IMAP4rev1 protocol described in RFC 3501 and the IMAP4 protocol described in \[[RFC1730](https://www.rfc-editor.org/info/rfc9051/#RFC1730)\]; the exception being in certain facilities added in \[[RFC1730](https://www.rfc-editor.org/info/rfc9051/#RFC1730)\] and \[[RFC3501](https://www.rfc-editor.org/info/rfc9051/#RFC3501)\] that proved problematic and were subsequently removed or replaced by better alternatives. In the course of the evolution of IMAP4rev2, some aspects in the earlier protocols have become obsolete. Obsolete commands, responses, and data formats that an IMAP4rev2 implementation can encounter when used with an earlier implementation are described in Appendices [A](https://www.rfc-editor.org/info/rfc9051/#IMAP4rev1-compat) and [E](https://www.rfc-editor.org/info/rfc9051/#changesFromIMAP4rev1) and \[[IMAP-OBSOLETE](https://www.rfc-editor.org/info/rfc9051/#RFC2062)\]. IMAP4rev2 supports 63-bit body parts and message sizes. IMAP4rev2 compatibility with BINARY and LIST-EXTENDED IMAP extensions are described in Appendices [B](https://www.rfc-editor.org/info/rfc9051/#BINARY-compat) and [C](https://www.rfc-editor.org/info/rfc9051/#LIST-EXTENDED-compat), respectively.[¶](https://www.rfc-editor.org/info/rfc9051/#section-1.3-2)

Other compatibility issues with IMAP2bis, the most common variant of the earlier protocol, are discussed in \[[IMAP-COMPAT](https://www.rfc-editor.org/info/rfc9051/#RFC2061)\]. A full discussion of compatibility issues with rare (and presumed extinct) variants of \[[IMAP2](https://www.rfc-editor.org/info/rfc9051/#RFC1176)\] is in \[[IMAP-HISTORICAL](https://www.rfc-editor.org/info/rfc9051/#RFC1732)\]; this document is primarily of historical interest.[¶](https://www.rfc-editor.org/info/rfc9051/#section-1.3-3)

IMAP was originally developed for the older \[[RFC822](https://www.rfc-editor.org/info/rfc9051/#RFC0822)\] standard, and as a consequence, the "RFC822.SIZE" fetch item in IMAP incorporates "RFC822" in its name. "RFC822" should be interpreted as a reference to the updated \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] standard.[¶](https://www.rfc-editor.org/info/rfc9051/#section-1.3-4)

IMAP4rev2 does not specify a means of posting mail; this function is handled by a mail submission protocol such as the one specified in \[[RFC6409](https://www.rfc-editor.org/info/rfc9051/#RFC6409)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-1.3-5)

## [2\.](https://www.rfc-editor.org/info/rfc9051/#section-2) [Protocol Overview](https://www.rfc-editor.org/info/rfc9051/#name-protocol-overview) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-2)

### [2.1.](https://www.rfc-editor.org/info/rfc9051/#section-2.1) [Link Level](https://www.rfc-editor.org/info/rfc9051/#name-link-level) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-2.1)

The IMAP4rev2 protocol assumes a reliable data stream such as that provided by TCP. When TCP is used, an IMAP4rev2 server listens on port 143 (cleartext port) or port 993 (Implicit TLS port).[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.1-1)

### [2.2.](https://www.rfc-editor.org/info/rfc9051/#section-2.2) [Commands and Responses](https://www.rfc-editor.org/info/rfc9051/#name-commands-and-responses) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-2.2)

An IMAP4rev2 connection consists of the establishment of a client/server network connection, an initial greeting from the server, and client/server interactions. These client/server interactions consist of a client command, server data, and a server completion result response.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.2-1)

All interactions transmitted by client and server are in the form of lines, that is, strings that end with a CRLF. The protocol receiver of an IMAP4rev2 client or server is reading either a line or a sequence of octets with a known count followed by a line.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.2-2)

#### [2.2.1.](https://www.rfc-editor.org/info/rfc9051/#section-2.2.1) [Client Protocol Sender and Server Protocol Receiver](https://www.rfc-editor.org/info/rfc9051/#name-client-protocol-sender-and-) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-2.2.1)

The client command begins an operation. Each client command is prefixed with an identifier (typically a short alphanumeric string, e.g., A0001, A0002, etc.) called a "tag". A different tag is generated by the client for each command. More formally: the client SHOULD generate a unique tag for every command, but a server MUST accept tag reuse.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.2.1-1)

Clients MUST follow the syntax outlined in this specification strictly. It is a syntax error to send a command with missing or extraneous spaces or arguments.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.2.1-2)

There are two cases in which a line from the client does not represent a complete command. In one case, a command argument is quoted with an octet count (see the description of literal in [Section 4.3](https://www.rfc-editor.org/info/rfc9051/#data-string)); in the other case, the command arguments require server feedback (see the AUTHENTICATE command in [Section 6.2.2](https://www.rfc-editor.org/info/rfc9051/#authenticate)). In either case, the server sends a command continuation request response if it is ready for the octets (if appropriate) and the remainder of the command. This response is prefixed with the token "+".[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.2.1-3)

Note: If, instead, the server detected an error in the command, it sends a BAD completion response with a tag matching the command (as described below) to reject the command and prevent the client from sending any more of the command.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.2.1-4)

It is also possible for the server to send a completion response for some other command (if multiple commands are in progress) or untagged data. In either case, the command continuation request is still pending; the client takes the appropriate action for the response and reads another response from the server. In all cases, the client MUST send a complete command (including receiving all command continuation request responses and sending command continuations for the command) before initiating a new command.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.2.1-5)

The protocol receiver of an IMAP4rev2 server reads a command line from the client, parses the command and its arguments, and transmits server data and a server command completion result response.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.2.1-6)

#### [2.2.2.](https://www.rfc-editor.org/info/rfc9051/#section-2.2.2) [Server Protocol Sender and Client Protocol Receiver](https://www.rfc-editor.org/info/rfc9051/#name-server-protocol-sender-and-) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-2.2.2)

Data transmitted by the server to the client and status responses that do not indicate command completion are prefixed with the token "\*" and are called untagged responses.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.2.2-1)

Server data MAY be sent as a result of a client command or MAY be sent unilaterally by the server. There is no syntactic difference between server data that resulted from a specific command and server data that were sent unilaterally.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.2.2-2)

The server completion result response indicates the success or failure of the operation. It is tagged with the same tag as the client command that began the operation. Thus, if more than one command is in progress, the tag in a server completion response identifies the command to which the response applies. There are three possible server completion responses: OK (indicating success), NO (indicating failure), or BAD (indicating a protocol error such as unrecognized command or command syntax error).[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.2.2-3)

Servers SHOULD strictly enforce the syntax outlined in this specification. Any client command with a protocol syntax error, including (but not limited to) missing or extraneous spaces or arguments, SHOULD be rejected and the client given a BAD server completion response.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.2.2-4)

The protocol receiver of an IMAP4rev2 client reads a response line from the server. It then takes action on the response based upon the first token of the response, which can be a tag, a "\*", or a "+".[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.2.2-5)

A client MUST be prepared to accept any server response at all times. This includes server data that was not requested. Server data SHOULD be remembered (cached), so that the client can reference its remembered copy rather than sending a command to the server to request the data. In the case of certain server data, the data MUST be remembered, as specified elsewhere in this document.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.2.2-6)

This topic is discussed in greater detail in "Server Responses" (see [Section 7](https://www.rfc-editor.org/info/rfc9051/#server-responses)).[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.2.2-7)

### [2.3.](https://www.rfc-editor.org/info/rfc9051/#section-2.3) [Message Attributes](https://www.rfc-editor.org/info/rfc9051/#name-message-attributes) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-2.3)

In addition to message text, each message has several attributes associated with it. These attributes can be retrieved individually or in conjunction with other attributes or message texts.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3-1)

#### [2.3.1.](https://www.rfc-editor.org/info/rfc9051/#section-2.3.1) [Message Numbers](https://www.rfc-editor.org/info/rfc9051/#name-message-numbers) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-2.3.1)

Messages in IMAP4rev2 are accessed by one of two numbers: the Unique Identifier (UID) or the message sequence number.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.1-1)

##### [2.3.1.1.](https://www.rfc-editor.org/info/rfc9051/#section-2.3.1.1) [Unique Identifier (UID) Message Attribute](https://www.rfc-editor.org/info/rfc9051/#name-unique-identifier-uid-messa)

A UID is an unsigned non-zero 32-bit value assigned to each message, which when used with the unique identifier validity value (see below) forms a 64-bit value that MUST NOT refer to any other message in the mailbox or any subsequent mailbox with the same name forever. Unique identifiers are assigned in a strictly ascending fashion in the mailbox; as each message is added to the mailbox, it is assigned a higher UID than those of all message(s) that are already in the mailbox. Unlike message sequence numbers, unique identifiers are not necessarily contiguous.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.1.1-1)

The unique identifier of a message MUST NOT change during the session and SHOULD NOT change between sessions. Any change of unique identifiers between sessions MUST be detectable using the UIDVALIDITY mechanism discussed below. Persistent unique identifiers are required for a client to resynchronize its state from a previous session with the server (e.g., disconnected or offline access clients \[[IMAP-MODEL](https://www.rfc-editor.org/info/rfc9051/#RFC1733)\]); this is discussed further in \[[IMAP-DISC](https://www.rfc-editor.org/info/rfc9051/#RFC4549)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.1.1-2)

Associated with every mailbox are two 32-bit unsigned non-zero values that aid in unique identifier handling: the next unique identifier value (UIDNEXT) and the unique identifier validity value (UIDVALIDITY).[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.1.1-3)

The next unique identifier value is the predicted value that will be assigned to a new message in the mailbox. Unless the unique identifier validity also changes (see below), the next unique identifier value MUST have the following two characteristics. First, the next unique identifier value MUST NOT change unless new messages are added to the mailbox; and second, the next unique identifier value MUST change whenever new messages are added to the mailbox, even if those new messages are subsequently expunged.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.1.1-4)

The unique identifier validity value is sent in a UIDVALIDITY response code in an OK untagged response at mailbox selection time. If unique identifiers from an earlier session fail to persist in this session, the unique identifier validity value MUST be greater than the one used in the earlier session. A good UIDVALIDITY value to use is a 32-bit representation of the current date/time when the value is assigned: this ensures that the value is unique and always increases. Another possible alternative is a global counter that gets incremented every time a mailbox is created.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.1.1-6)

Note: Ideally, unique identifiers SHOULD persist at all times. Although this specification recognizes that failure to persist can be unavoidable in certain server environments, it strongly encourages message store implementation techniques that avoid this problem. For example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.1.1-7)

1.  Unique identifiers MUST be strictly ascending in the mailbox at all times. If the physical message store is reordered by a non-IMAP agent, the unique identifiers in the mailbox MUST be regenerated, since the former unique identifiers are no longer strictly ascending as a result of the reordering.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.1.1-8.1)
2.  If the message store has no mechanism to store unique identifiers, it must regenerate unique identifiers at each session, and each session must have a unique UIDVALIDITY value. Note that this situation can be very disruptive to client message caching.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.1.1-8.2)
3.  If the mailbox is deleted/renamed and a new mailbox with the same name is created at a later date, the server must either keep track of unique identifiers from the previous instance of the mailbox or assign a new UIDVALIDITY value to the new instance of the mailbox.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.1.1-8.3)
4.  The combination of mailbox name, UIDVALIDITY, and UID must refer to a single, immutable (or expunged) message on that server forever. In particular, the internal date, RFC822.SIZE, envelope, body structure, and message texts (all BODY\[...\] fetch data items) MUST never change. This does not include message numbers, nor does it include attributes that can be set by a STORE command (such as FLAGS). When a message is expunged, its UID MUST NOT be reused under the same UIDVALIDITY value.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.1.1-8.4)

##### [2.3.1.2.](https://www.rfc-editor.org/info/rfc9051/#section-2.3.1.2) [Message Sequence Number Message Attribute](https://www.rfc-editor.org/info/rfc9051/#name-message-sequence-number-mes)

A message sequence number is a relative position from 1 to the number of messages in the mailbox. This position MUST be ordered by ascending unique identifiers. As each new message is added, it is assigned a message sequence number that is 1 higher than the number of messages in the mailbox before that new message was added.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.1.2-1)

Message sequence numbers can be reassigned during the session. For example, when a message is permanently removed (expunged) from the mailbox, the message sequence number for all subsequent messages is decremented. The number of messages in the mailbox is also decremented. Similarly, a new message can be assigned a message sequence number that was once held by some other message prior to an expunge.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.1.2-2)

In addition to accessing messages by relative position in the mailbox, message sequence numbers can be used in mathematical calculations. For example, if an untagged "11 EXISTS" is received, and previously an untagged "8 EXISTS" was received, three new messages have arrived with message sequence numbers of 9, 10, and 11. As another example, if message 287 in a 523-message mailbox has UID 12345, there are exactly 286 messages that have lesser UIDs and 236 messages that have greater UIDs.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.1.2-3)

#### [2.3.2.](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2) [Flags Message Attribute](https://www.rfc-editor.org/info/rfc9051/#name-flags-message-attribute) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-2.3.2)

A message has a list of zero or more named tokens, known as "flags", associated with it. A flag is set by its addition to this list and is cleared by its removal. There are two types of flags in IMAP4rev2: system flags and keywords. A flag of either type can be permanent or session-only.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-1)

A system flag is a flag name that is predefined in this specification and begins with "\\". Certain system flags (\\Deleted and \\Seen) have special semantics described elsewhere in this document. The currently defined system flags are:[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-2)

\\Seen

Message has been read[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-3.2)

\\Answered

Message has been answered[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-3.4)

\\Flagged

Message is "flagged" for urgent/special attention[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-3.6)

\\Deleted

Message is "deleted" for removal by later EXPUNGE[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-3.8)

\\Draft

Message has not completed composition (marked as a draft).[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-3.10)

\\Recent

This flag was in use in IMAP4rev1 and is now deprecated.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-3.12)

A keyword is defined by the server implementation. Keywords do not begin with "\\". Servers MAY permit the client to define new keywords in the mailbox (see the description of the PERMANENTFLAGS response code for more information). Some keywords that start with "$" are also defined in this specification.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-4)

This document defines several keywords that were not originally defined in \[[RFC3501](https://www.rfc-editor.org/info/rfc9051/#RFC3501)\] but were found to be useful by client implementations. These keywords SHOULD be supported (allowed in SEARCH and allowed and preserved in APPEND, COPY, and MOVE commands) by server implementations:[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-5)

$Forwarded

Message has been forwarded to another email address by being embedded within, or attached to a new message. An email client sets this keyword when it successfully forwards the message to another email address. Typical usage of this keyword is to show a different (or additional) icon for a message that has been forwarded. Once set, the flag SHOULD NOT be cleared.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-6.2)

$MDNSent

Message Disposition Notification \[[RFC8098](https://www.rfc-editor.org/info/rfc9051/#RFC8098)\] was generated and sent for this message. See \[[RFC3503](https://www.rfc-editor.org/info/rfc9051/#RFC3503)\] for more details on how this keyword is used and for requirements on clients and servers.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-6.4)

$Junk

The user (or a delivery agent on behalf of the user) may choose to mark a message as definitely containing junk ($Junk; see also the related keyword $NotJunk). The $Junk keyword can be used to mark, group, or hide undesirable messages (and such messages might be moved or deleted later). See \[[IMAP-KEYWORDS-REG](https://www.rfc-editor.org/info/rfc9051/#IMAP-KEYWORDS-REG)\] for more information.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-6.6)

$NotJunk

The user (or a delivery agent on behalf of the user) may choose to mark a message as definitely not containing junk ($NotJunk; see also the related keyword $Junk). The $NotJunk keyword can be used to mark, group, or show messages that the user wants to see. See \[[IMAP-KEYWORDS-REG](https://www.rfc-editor.org/info/rfc9051/#IMAP-KEYWORDS-REG)\] for more information.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-6.8)

$Phishing

The $Phishing keyword can be used by a delivery agent to mark a message as highly likely to be a phishing email. A message that's determined to be a phishing email by the delivery agent should also be considered a junk email and have the appropriate junk filtering applied, including setting the $Junk flag and placing the message in the \\Junk special-use mailbox (see [Section 7.3.1](https://www.rfc-editor.org/info/rfc9051/#list-resp)), if available.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-6.10.1)

If both the $Phishing flag and the $Junk flag are set, the user agent should display an additional warning message to the user. Additionally, the user agent might display a warning, such as something of the form, "This message may be trying to steal your personal information," when the user clicks on any hyperlinks within the message.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-6.10.2)

The requirement for both $Phishing and $Junk to be set before a user agent displays a warning is for better backwards compatibility with existing clients that understand the $Junk flag but not the $Phishing flag. This is so that when an unextended client removes the $Junk flag, an extended client will also show the correct state. See \[[IMAP-KEYWORDS-REG](https://www.rfc-editor.org/info/rfc9051/#IMAP-KEYWORDS-REG)\] for more information.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-6.10.3)

$Junk and $NotJunk are mutually exclusive. If more than one of these is set for a message, the client MUST treat it as if none are set, and it SHOULD unset both of them on the IMAP server.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-7)

Other registered keywords can be found in the "IMAP and JMAP Keywords" registry \[[IMAP-KEYWORDS-REG](https://www.rfc-editor.org/info/rfc9051/#IMAP-KEYWORDS-REG)\]. New keywords SHOULD be registered in this registry using the procedure specified in \[[RFC5788](https://www.rfc-editor.org/info/rfc9051/#RFC5788)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-8)

A flag can be permanent or session-only on a per-flag basis. Permanent flags are those that the client can add or remove from the message flags permanently; that is, concurrent and subsequent sessions will see any change in permanent flags. Changes to session flags are valid only in that session.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-9)

#### [2.3.3.](https://www.rfc-editor.org/info/rfc9051/#section-2.3.3) [Internal Date Message Attribute](https://www.rfc-editor.org/info/rfc9051/#name-internal-date-message-attri) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-2.3.3)

An Internal Date message attribute is the internal date and time of the message on the server. This is not the date and time in the \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] header but rather a date and time that reflects when the message was received. In the case of messages delivered via \[[SMTP](https://www.rfc-editor.org/info/rfc9051/#RFC5321)\], this is the date and time of final delivery of the message as defined by \[[SMTP](https://www.rfc-editor.org/info/rfc9051/#RFC5321)\]. In the case of messages created by the IMAP4rev2 COPY or MOVE command, this SHOULD be the same as the Internal Date attribute of the source message. In the case of messages created by the IMAP4rev2 APPEND command, this SHOULD be the date and time as specified in the APPEND command description. All other cases are implementation defined.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.3-1)

#### [2.3.4.](https://www.rfc-editor.org/info/rfc9051/#section-2.3.4) [RFC822.SIZE Message Attribute](https://www.rfc-editor.org/info/rfc9051/#name-rfc822size-message-attribut) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-2.3.4)

RFC822.SIZE is the number of octets in the message when the message is expressed in \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] format. This size SHOULD match the result of a "FETCH BODY\[\]" command. If the message is internally stored in some other format, the server calculates the size and often stores it for later use to avoid the need for recalculation.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.4-1)

#### [2.3.5.](https://www.rfc-editor.org/info/rfc9051/#section-2.3.5) [Envelope Structure Message Attribute](https://www.rfc-editor.org/info/rfc9051/#name-envelope-structure-message-) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-2.3.5)

An envelope structure is a parsed representation of the \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] header of the message. Note that the IMAP envelope structure is not the same as an \[[SMTP](https://www.rfc-editor.org/info/rfc9051/#RFC5321)\] envelope.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.5-1)

#### [2.3.6.](https://www.rfc-editor.org/info/rfc9051/#section-2.3.6) [Body Structure Message Attribute](https://www.rfc-editor.org/info/rfc9051/#name-body-structure-message-attr) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-2.3.6)

A body structure is a parsed representation of the \[[MIME-IMB](https://www.rfc-editor.org/info/rfc9051/#RFC2045)\] body structure information of the message.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.3.6-1)

### [2.4.](https://www.rfc-editor.org/info/rfc9051/#section-2.4) [Message Texts](https://www.rfc-editor.org/info/rfc9051/#name-message-texts) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-2.4)

In addition to being able to fetch the full \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] text of a message, IMAP4rev2 permits the fetching of portions of the full message text. Specifically, it is possible to fetch the \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] message header, the \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] message body, a \[[MIME-IMB](https://www.rfc-editor.org/info/rfc9051/#RFC2045)\] body part, or a \[[MIME-IMB](https://www.rfc-editor.org/info/rfc9051/#RFC2045)\] header.[¶](https://www.rfc-editor.org/info/rfc9051/#section-2.4-1)

## [3\.](https://www.rfc-editor.org/info/rfc9051/#section-3) [State and Flow Diagram](https://www.rfc-editor.org/info/rfc9051/#name-state-and-flow-diagram) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-3)

Once the connection between client and server is established, an IMAP4rev2 connection is in one of four states. The initial state is identified in the server greeting. Most commands are only valid in certain states. It is a protocol error for the client to attempt a command while the connection is in an inappropriate state, and the server will respond with a BAD or NO (depending upon server implementation) command completion result.[¶](https://www.rfc-editor.org/info/rfc9051/#section-3-1)

### [3.1.](https://www.rfc-editor.org/info/rfc9051/#section-3.1) [Not Authenticated State](https://www.rfc-editor.org/info/rfc9051/#name-not-authenticated-state) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-3.1)

In the not authenticated state, the client MUST supply authentication credentials before most commands will be permitted. This state is entered when a connection starts unless the connection has been pre-authenticated.[¶](https://www.rfc-editor.org/info/rfc9051/#section-3.1-1)

### [3.2.](https://www.rfc-editor.org/info/rfc9051/#section-3.2) [Authenticated State](https://www.rfc-editor.org/info/rfc9051/#name-authenticated-state) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-3.2)

In the authenticated state, the client is authenticated and MUST select a mailbox to access before commands that affect messages will be permitted. This state is entered when a pre-authenticated connection starts, when acceptable authentication credentials have been provided, after an error in selecting a mailbox, or after a successful CLOSE or UNSELECT command.[¶](https://www.rfc-editor.org/info/rfc9051/#section-3.2-1)

### [3.3.](https://www.rfc-editor.org/info/rfc9051/#section-3.3) [Selected State](https://www.rfc-editor.org/info/rfc9051/#name-selected-state) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-3.3)

In a selected state, a mailbox has been selected to access. This state is entered when a mailbox has been successfully selected.[¶](https://www.rfc-editor.org/info/rfc9051/#section-3.3-1)

### [3.4.](https://www.rfc-editor.org/info/rfc9051/#section-3.4) [Logout State](https://www.rfc-editor.org/info/rfc9051/#name-logout-state) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-3.4)

In the logout state, the connection is being terminated. This state can be entered as a result of a client request (via the LOGOUT command) or by unilateral action on the part of either the client or the server.[¶](https://www.rfc-editor.org/info/rfc9051/#section-3.4-1)

If the client requests the logout state, the server MUST send an untagged BYE response and a tagged OK response to the LOGOUT command before the server closes the connection; and the client MUST read the tagged OK response to the LOGOUT command before the client closes the connection.[¶](https://www.rfc-editor.org/info/rfc9051/#section-3.4-2)

A server SHOULD NOT unilaterally close the connection without first sending an untagged BYE response that contains the reason for doing so. A client SHOULD NOT unilaterally close the connection; instead, it SHOULD issue a LOGOUT command. If the server detects that the client has unilaterally closed the connection, the server MAY omit the untagged BYE response and simply close its connection.[¶](https://www.rfc-editor.org/info/rfc9051/#section-3.4-3)

Legend for the above diagram:[¶](https://www.rfc-editor.org/info/rfc9051/#section-3.4-5)

(1)

connection without pre-authentication (OK greeting)[¶](https://www.rfc-editor.org/info/rfc9051/#section-3.4-6.1)

(2)

pre-authenticated connection (PREAUTH greeting)[¶](https://www.rfc-editor.org/info/rfc9051/#section-3.4-6.2)

(3)

rejected connection (BYE greeting)[¶](https://www.rfc-editor.org/info/rfc9051/#section-3.4-6.3)

(4)

successful LOGIN or AUTHENTICATE command[¶](https://www.rfc-editor.org/info/rfc9051/#section-3.4-6.4)

(5)

successful SELECT or EXAMINE command[¶](https://www.rfc-editor.org/info/rfc9051/#section-3.4-6.5)

(6)

CLOSE or UNSELECT command, unsolicited CLOSED response code, or failed SELECT or EXAMINE command[¶](https://www.rfc-editor.org/info/rfc9051/#section-3.4-6.6)

(7)

LOGOUT command, server shutdown, or connection closed[¶](https://www.rfc-editor.org/info/rfc9051/#section-3.4-6.7)

## [4\.](https://www.rfc-editor.org/info/rfc9051/#section-4) [Data Formats](https://www.rfc-editor.org/info/rfc9051/#name-data-formats) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-4)

IMAP4rev2 uses textual commands and responses. Data in IMAP4rev2 can be in one of several forms: atom, number, string, parenthesized list, or NIL. Note that a particular data item may take more than one form; for example, a data item defined as using "astring" syntax may be either an atom or a string.[¶](https://www.rfc-editor.org/info/rfc9051/#section-4-1)

### [4.1.](https://www.rfc-editor.org/info/rfc9051/#section-4.1) [Atom](https://www.rfc-editor.org/info/rfc9051/#name-atom) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-4.1)

An atom consists of one or more non-special characters.[¶](https://www.rfc-editor.org/info/rfc9051/#section-4.1-1)

#### [4.1.1.](https://www.rfc-editor.org/info/rfc9051/#section-4.1.1) [Sequence Set and UID Set](https://www.rfc-editor.org/info/rfc9051/#name-sequence-set-and-uid-set) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-4.1.1)

A set of messages can be referenced by a sequence set containing either message sequence numbers or unique identifiers. See [Section 9](https://www.rfc-editor.org/info/rfc9051/#IMAP-ABNF) for details. A sequence set can contain ranges of sequence numbers (such as "5:50"), an enumeration of specific sequence numbers, or a combination of the above. A sequence set can use the special symbol "\*" to represent the maximum sequence number in the mailbox. A sequence set never contains unique identifiers.[¶](https://www.rfc-editor.org/info/rfc9051/#section-4.1.1-1)

A "UID set" is similar to the sequence set, but uses unique identifiers instead of message sequence numbers, and is not permitted to contain the special symbol "\*".[¶](https://www.rfc-editor.org/info/rfc9051/#section-4.1.1-2)

### [4.2.](https://www.rfc-editor.org/info/rfc9051/#section-4.2) [Number](https://www.rfc-editor.org/info/rfc9051/#name-number) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-4.2)

A number consists of one or more digit characters and represents a numeric value.[¶](https://www.rfc-editor.org/info/rfc9051/#section-4.2-1)

### [4.3.](https://www.rfc-editor.org/info/rfc9051/#section-4.3) [String](https://www.rfc-editor.org/info/rfc9051/#name-string) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-4.3)

A string is in one of three forms: synchronizing literal, non-synchronizing literal, or quoted string. The synchronizing literal form is the general form of a string, without limitation on the characters the string may include. The non-synchronizing literal form is also the general form, but it has a length restriction. The quoted string form is an alternative that avoids the overhead of processing a literal, but has limitations on the characters that may be used.[¶](https://www.rfc-editor.org/info/rfc9051/#section-4.3-1)

When the distinction between synchronizing and non-synchronizing literals is not important, this document only uses the term "literal".[¶](https://www.rfc-editor.org/info/rfc9051/#section-4.3-2)

A synchronizing literal is a sequence of zero or more octets (including CR and LF), prefix-quoted with an octet count in the form of an open brace ("{"), the number of octets, a close brace ("}"), and a CRLF. In the case of synchronizing literals transmitted from server to client, the CRLF is immediately followed by the octet data. In the case of synchronizing literals transmitted from client to server, the client MUST wait to receive a command continuation request (described later in this document) before sending the octet data (and the remainder of the command).[¶](https://www.rfc-editor.org/info/rfc9051/#section-4.3-3)

The non-synchronizing literal is an alternative form of synchronizing literal and may be used from client to server anywhere a synchronizing literal is permitted. The non-synchronizing literal form MUST NOT be sent from server to client. The non-synchronizing literal is distinguished from the synchronizing literal by having a plus ("+") between the octet count and the closing brace ("}"). The server does not generate a command continuation request in response to a non-synchronizing literal, and clients are not required to wait before sending the octets of a non-synchronizing literal. Unless otherwise specified in an IMAP extension, non-synchronizing literals MUST NOT be larger than 4096 octets. Any literal larger than 4096 bytes MUST be sent as a synchronizing literal. (Non-synchronizing literals defined in this document are the same as non-synchronizing literals defined by the LITERAL- extension from \[[RFC7888](https://www.rfc-editor.org/info/rfc9051/#RFC7888)\]. See that document for details on how to handle invalid non-synchronizing literals longer than 4096 octets and for interaction with other IMAP extensions.)[¶](https://www.rfc-editor.org/info/rfc9051/#section-4.3-4)

A quoted string is a sequence of zero or more Unicode characters, excluding CR and LF, encoded in UTF-8, with double quote (<">) characters at each end.[¶](https://www.rfc-editor.org/info/rfc9051/#section-4.3-5)

The empty string is represented as "" (a quoted string with zero characters between double quotes), as {0} followed by a CRLF (a synchronizing literal with an octet count of 0), or as {0+} followed by a CRLF (a non-synchronizing literal with an octet count of 0).[¶](https://www.rfc-editor.org/info/rfc9051/#section-4.3-6)

Note: Even if the octet count is 0, a client transmitting a synchronizing literal MUST wait to receive a command continuation request.[¶](https://www.rfc-editor.org/info/rfc9051/#section-4.3-7)

#### [4.3.1.](https://www.rfc-editor.org/info/rfc9051/#section-4.3.1) [8-Bit and Binary Strings](https://www.rfc-editor.org/info/rfc9051/#name-8-bit-and-binary-strings) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-4.3.1)

8-bit textual and binary mail is supported through the use of a \[[MIME-IMB](https://www.rfc-editor.org/info/rfc9051/#RFC2045)\] content transfer encoding. IMAP4rev2 implementations MAY transmit 8-bit or multi-octet characters in literals but SHOULD do so only when the \[[CHARSET](https://www.rfc-editor.org/info/rfc9051/#RFC2978)\] is identified.[¶](https://www.rfc-editor.org/info/rfc9051/#section-4.3.1-1)

IMAP4rev2 is compatible with \[[I18N-HDRS](https://www.rfc-editor.org/info/rfc9051/#RFC6532)\]. As a result, the identified charset for header-field values with 8-bit content is UTF-8 \[[UTF-8](https://www.rfc-editor.org/info/rfc9051/#RFC3629)\]. IMAP4rev2 implementations MUST accept and MAY transmit \[[UTF-8](https://www.rfc-editor.org/info/rfc9051/#RFC3629)\] text in quoted-strings as long as the string does not contain NUL, CR, or LF. This differs from IMAP4rev1 implementations.[¶](https://www.rfc-editor.org/info/rfc9051/#section-4.3.1-2)

Although a BINARY content transfer encoding is defined, unencoded binary strings are not permitted, unless returned in a <literal8> in response to a BINARY.PEEK\[<section-binary>\]<<partial>> or BINARY\[<section-binary>\]<<partial>> FETCH data item. A "binary string" is any string with NUL characters. A string with an excessive amount of CTL characters MAY also be considered to be binary. Unless returned in response to BINARY.PEEK\[...\]/BINARY\[...\] FETCH, client and server implementations MUST encode binary data into a textual form, such as base64, before transmitting the data.[¶](https://www.rfc-editor.org/info/rfc9051/#section-4.3.1-3)

### [4.4.](https://www.rfc-editor.org/info/rfc9051/#section-4.4) [Parenthesized List](https://www.rfc-editor.org/info/rfc9051/#name-parenthesized-list) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-4.4)

Data structures are represented as a "parenthesized list"; a sequence of data items, delimited by space, and bounded at each end by parentheses. A parenthesized list can contain other parenthesized lists, using multiple levels of parentheses to indicate nesting.[¶](https://www.rfc-editor.org/info/rfc9051/#section-4.4-1)

The empty list is represented as () -- a parenthesized list with no members.[¶](https://www.rfc-editor.org/info/rfc9051/#section-4.4-2)

### [4.5.](https://www.rfc-editor.org/info/rfc9051/#section-4.5) [NIL](https://www.rfc-editor.org/info/rfc9051/#name-nil) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-4.5)

The special form "NIL" represents the non-existence of a particular data item that is represented as a string or parenthesized list, as distinct from the empty string "" or the empty parenthesized list ().[¶](https://www.rfc-editor.org/info/rfc9051/#section-4.5-1)

Examples:[¶](https://www.rfc-editor.org/info/rfc9051/#section-4.5-3)

The following LIST response:[¶](https://www.rfc-editor.org/info/rfc9051/#section-4.5-4)

is equivalent to:[¶](https://www.rfc-editor.org/info/rfc9051/#section-4.5-6)

as LIST response ABNF is using "astring" for mailbox name.[¶](https://www.rfc-editor.org/info/rfc9051/#section-4.5-8)

However, the following response:[¶](https://www.rfc-editor.org/info/rfc9051/#section-4.5-9)

is not equivalent to:[¶](https://www.rfc-editor.org/info/rfc9051/#section-4.5-11)

The former indicates absence of the body part, while the latter means that it contains a string with the three characters "NIL".[¶](https://www.rfc-editor.org/info/rfc9051/#section-4.5-13)

## [5\.](https://www.rfc-editor.org/info/rfc9051/#section-5) [Operational Considerations](https://www.rfc-editor.org/info/rfc9051/#name-operational-considerations) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-5)

The following rules are listed here to ensure that all IMAP4rev2 implementations interoperate properly.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5-1)

### [5.1.](https://www.rfc-editor.org/info/rfc9051/#section-5.1) [Mailbox Naming](https://www.rfc-editor.org/info/rfc9051/#name-mailbox-naming) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-5.1)

In IMAP4rev2, mailbox names are encoded in Net-Unicode \[[NET-UNICODE](https://www.rfc-editor.org/info/rfc9051/#RFC5198)\] (this differs from IMAP4rev1). Client implementations MAY attempt to create Net-Unicode mailbox names and MUST interpret any 8-bit mailbox names returned by LIST as \[[NET-UNICODE](https://www.rfc-editor.org/info/rfc9051/#RFC5198)\]. Server implementations MUST prohibit the creation of 8-bit mailbox names that do not comply with Net-Unicode. However, servers MAY accept a denormalized UTF-8 mailbox name and convert it to Unicode Normalization Form C (NFC) (as per Net-Unicode requirements) prior to mailbox creation. Servers that choose to accept such denormalized UTF-8 mailbox names MUST accept them in all IMAP commands that have a mailbox name parameter. In particular, SELECT <name> must open the same mailbox that was successfully created with CREATE <name>, even if <name> is a denormalized UTF-8 mailbox name.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.1-1)

The case-insensitive mailbox name INBOX is a special name reserved to mean "the primary mailbox for this user on this server". (Note that this special name might not exist on some servers for some users, for example, if the user has no access to personal namespace.) The interpretation of all other names is implementation dependent.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.1-2)

In particular, this specification takes no position on case sensitivity in non-INBOX mailbox names. Some server implementations are fully case sensitive in ASCII range; others preserve the case of a newly created name but otherwise are case insensitive; and yet others coerce names to a particular case. Client implementations must be able to interact with any of these.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.1-3)

There are certain client considerations when creating a new mailbox name:[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.1-4)

1.  Any character that is one of the atom-specials (see "Formal Syntax" in [Section 9](https://www.rfc-editor.org/info/rfc9051/#IMAP-ABNF)) will require that the mailbox name be represented as a quoted string or literal.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.1-5.1)
2.  CTL and other non-graphic characters are difficult to represent in a user interface and are best avoided. Servers MAY refuse to create mailbox names containing Unicode CTL characters.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.1-5.2)
3.  Although the list-wildcard characters ("%" and "\*") are valid in a mailbox name, it is difficult to use such mailbox names with the LIST command due to the conflict with wildcard interpretation.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.1-5.3)
4.  Usually, a character (determined by the server implementation) is reserved to delimit levels of hierarchy.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.1-5.4)
5.  Two characters, "#" and "&", have meanings by convention and should be avoided except when used in that convention. See [Section 5.1.2.1](https://www.rfc-editor.org/info/rfc9051/#namespace-convention) and [Appendix A.1](https://www.rfc-editor.org/info/rfc9051/#mailbox-i18n), respectively.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.1-5.5)

#### [5.1.1.](https://www.rfc-editor.org/info/rfc9051/#section-5.1.1) [Mailbox Hierarchy Naming](https://www.rfc-editor.org/info/rfc9051/#name-mailbox-hierarchy-naming) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-5.1.1)

If it is desired to export hierarchical mailbox names, mailbox names MUST be left-to-right hierarchical, using a single ASCII character to separate levels of hierarchy. The same hierarchy separator character is used for all levels of hierarchy within a single name.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.1.1-1)

#### [5.1.2.](https://www.rfc-editor.org/info/rfc9051/#section-5.1.2) [Namespaces](https://www.rfc-editor.org/info/rfc9051/#name-namespaces) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-5.1.2)

Personal Namespace:

A namespace that the server considers within the personal scope of the authenticated user on a particular connection. Typically, only the authenticated user has access to mailboxes in their Personal Namespace. It is the part of the namespace that belongs to the user and is allocated for mailboxes. If an INBOX exists for a user, it MUST appear within the user's Personal Namespace. In the typical case, there SHOULD be only one Personal Namespace per user on a server.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.1.2-1.2)

Other Users' Namespace:

A namespace that consists of mailboxes from the Personal Namespaces of other users. To access mailboxes in the Other Users' Namespace, the currently authenticated user MUST be explicitly granted access rights. For example, it is common for a manager to grant to their administrative support staff access rights to their mailbox. In the typical case, there SHOULD be only one Other Users' Namespace per user on a server.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.1.2-1.4)

Shared Namespace:

A namespace that consists of mailboxes that are intended to be shared amongst users and do not exist within a user's Personal Namespace.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.1.2-1.6)

The namespaces a server uses MAY differ on a per-user basis.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.1.2-2)

##### [5.1.2.1.](https://www.rfc-editor.org/info/rfc9051/#section-5.1.2.1) [Historic Mailbox Namespace Naming Convention](https://www.rfc-editor.org/info/rfc9051/#name-historic-mailbox-namespace-)

By convention, the first hierarchical element of any mailbox name that begins with "#" identifies the "namespace" of the remainder of the name. This makes it possible to disambiguate between different types of mailbox stores, each of which have their own namespaces.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.1.2.1-1)

For example, implementations that offer access to USENET newsgroups MAY use the "#news" namespace to partition the USENET newsgroup namespace from that of other mailboxes. Thus, the comp.mail.misc newsgroup would have a mailbox name of "#news.comp.mail.misc", and the name "comp.mail.misc" can refer to a different object (e.g., a user's private mailbox).[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.1.2.1-2)

Namespaces that include the "#" character are not IMAP URL \[[IMAP-URL](https://www.rfc-editor.org/info/rfc9051/#RFC5092)\] friendly and require the "#" character to be represented as %23 when within URLs. As such, server implementors MAY instead consider using namespace prefixes that do not contain the "#" character.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.1.2.1-3)

##### [5.1.2.2.](https://www.rfc-editor.org/info/rfc9051/#section-5.1.2.2) [Common Namespace Models](https://www.rfc-editor.org/info/rfc9051/#name-common-namespace-models)

The previous version of this protocol did not define a default server namespace. Two common namespace models have evolved:[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.1.2.2-1)

The "Personal Mailbox" model, in which the default namespace that is presented consists of only the user's personal mailboxes. To access shared mailboxes, the user must use an escape mechanism to reach another namespace.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.1.2.2-2)

The "Complete Hierarchy" model, in which the default namespace that is presented includes the user's personal mailboxes along with any other mailboxes they have access to.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.1.2.2-3)

### [5.2.](https://www.rfc-editor.org/info/rfc9051/#section-5.2) [Mailbox Size and Message Status Updates](https://www.rfc-editor.org/info/rfc9051/#name-mailbox-size-and-message-st) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-5.2)

At any time, a server can send data that the client did not request. Sometimes, such behavior is required by this specification and/or extensions. For example, agents other than the server may add messages to the mailbox (e.g., new message delivery); change the flags of the messages in the mailbox (e.g., simultaneous access to the same mailbox by multiple agents); or even remove messages from the mailbox. A server MUST send mailbox size updates automatically if a mailbox size change is observed during the processing of a command. A server SHOULD send message flag updates automatically, without requiring the client to request such updates explicitly.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.2-1)

Special rules exist for server notification of a client about the removal of messages to prevent synchronization errors; see the description of the EXPUNGE response ([Section 7.5.1](https://www.rfc-editor.org/info/rfc9051/#expunge-response)) for more detail. In particular, it is NOT permitted to send an EXISTS response that would reduce the number of messages in the mailbox; only the EXPUNGE response can do this.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.2-2)

Regardless of what implementation decisions a client makes on remembering data from the server, a client implementation MUST remember mailbox size updates. It MUST NOT assume that any command after the initial mailbox selection will return the size of the mailbox.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.2-3)

### [5.3.](https://www.rfc-editor.org/info/rfc9051/#section-5.3) [Response When No Command in Progress](https://www.rfc-editor.org/info/rfc9051/#name-response-when-no-command-in) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-5.3)

Server implementations are permitted to send an untagged response (except for EXPUNGE) while there is no command in progress. Server implementations that send such responses MUST deal with flow control considerations. Specifically, they MUST either (1) verify that the size of the data does not exceed the underlying transport's available window size or (2) use non-blocking writes.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.3-1)

### [5.4.](https://www.rfc-editor.org/info/rfc9051/#section-5.4) [Autologout Timer](https://www.rfc-editor.org/info/rfc9051/#name-autologout-timer) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-5.4)

If a server has an inactivity autologout timer that applies to sessions after authentication, the duration of that timer MUST be at least 30 minutes. The receipt of any command from the client during that interval resets the autologout timer.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.4-1)

Note that this specification doesn't have any restrictions on an autologout timer used before successful client authentication. In particular, servers are allowed to use a shortened pre-authentication timer to protect themselves from Denial-of-Service attacks.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.4-2)

### [5.5.](https://www.rfc-editor.org/info/rfc9051/#section-5.5) [Multiple Commands in Progress (Command Pipelining)](https://www.rfc-editor.org/info/rfc9051/#name-multiple-commands-in-progre) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-5.5)

The client MAY send another command without waiting for the completion result response of a command, subject to ambiguity rules (see below) and flow control constraints on the underlying data stream. Similarly, a server MAY begin processing another command before processing the current command to completion, subject to ambiguity rules. However, any command continuation request responses and command continuations MUST be negotiated before any subsequent command is initiated.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.5-1)

The exception is if an ambiguity would result because of a command that would affect the results of other commands. If the server detects a possible ambiguity, it MUST execute commands to completion in the order given by the client.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.5-2)

The most obvious example of ambiguity is when a command would affect the results of another command. One example is a FETCH that would cause \\Seen flags to be set and a SEARCH UNSEEN command.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.5-3)

A non-obvious ambiguity occurs with commands that permit an untagged EXPUNGE response (commands other than FETCH, STORE, and SEARCH), since an untagged EXPUNGE response can invalidate sequence numbers in a subsequent command. This is not a problem for FETCH, STORE, or SEARCH commands because servers are prohibited from sending EXPUNGE responses while any of those commands are in progress. Therefore, if the client sends any command other than FETCH, STORE, or SEARCH, it MUST wait for the completion result response before sending a command with message sequence numbers.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.5-4)

Note: EXPUNGE responses are permitted while UID FETCH, UID STORE, and UID SEARCH are in progress. If the client sends a UID command, it MUST wait for a completion result response before sending a command that uses message sequence numbers (this may include UID SEARCH). Any message sequence numbers in an argument to UID SEARCH are associated with messages prior to the effect of any untagged EXPUNGE responses returned by the UID SEARCH.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.5-5)

For example, the following non-waiting command sequences are invalid:[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.5-6)

-   FETCH + NOOP + STORE[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.5-7.1)
-   STORE + COPY + FETCH[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.5-7.2)
-   COPY + COPY[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.5-7.3)

The following are examples of valid non-waiting command sequences:[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.5-8)

-   FETCH + STORE + SEARCH + NOOP[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.5-9.1)
-   STORE + COPY + EXPUNGE[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.5-9.2)

UID SEARCH + UID SEARCH may be valid or invalid as a non-waiting command sequence, depending upon whether or not the second UID SEARCH contains message sequence numbers.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.5-10)

Use of a SEARCH result variable (see [Section 6.4.4.1](https://www.rfc-editor.org/info/rfc9051/#search-save)) creates direct dependency between two commands. See [Section 6.4.4.2](https://www.rfc-editor.org/info/rfc9051/#search-save-pipelining) for more considerations about pipelining such dependent commands.[¶](https://www.rfc-editor.org/info/rfc9051/#section-5.5-11)

## [6\.](https://www.rfc-editor.org/info/rfc9051/#section-6) [Client Commands](https://www.rfc-editor.org/info/rfc9051/#name-client-commands) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6)

IMAP4rev2 commands are described in this section. Commands are organized by the state in which the command is permitted. Commands that are permitted in multiple states are listed in the minimum permitted state (for example, commands valid in authenticated and selected states are listed in the authenticated state commands).[¶](https://www.rfc-editor.org/info/rfc9051/#section-6-1)

Command arguments, identified by "Arguments:" in the command descriptions below, are described by function, not by syntax. The precise syntax of command arguments is described in "Formal Syntax" ([Section 9](https://www.rfc-editor.org/info/rfc9051/#IMAP-ABNF)).[¶](https://www.rfc-editor.org/info/rfc9051/#section-6-2)

Some commands cause specific server responses to be returned; these are identified by "Responses:" in the command descriptions below. See the response descriptions in "Responses" ([Section 7](https://www.rfc-editor.org/info/rfc9051/#server-responses)) for information on these responses and in "Formal Syntax" ([Section 9](https://www.rfc-editor.org/info/rfc9051/#IMAP-ABNF)) for the precise syntax of these responses. It is possible for server data to be transmitted as a result of any command. Thus, commands that do not specifically require server data specify "no specific responses for this command" instead of "none".[¶](https://www.rfc-editor.org/info/rfc9051/#section-6-3)

The "Result:" in the command description refers to the possible tagged status responses to a command and any special interpretation of these status responses.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6-4)

The state of a connection is only changed by successful commands that are documented as changing state. A rejected command (BAD response) never changes the state of the connection or of the selected mailbox. A failed command (NO response) generally does not change the state of the connection or of the selected mailbox, with the exception of the SELECT and EXAMINE commands.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6-5)

### [6.1.](https://www.rfc-editor.org/info/rfc9051/#section-6.1) [Client Commands - Any State](https://www.rfc-editor.org/info/rfc9051/#name-client-commands-any-state) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.1)

The following commands are valid in any state: CAPABILITY, NOOP, and LOGOUT.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.1-1)

#### [6.1.1.](https://www.rfc-editor.org/info/rfc9051/#section-6.1.1) [CAPABILITY Command](https://www.rfc-editor.org/info/rfc9051/#name-capability-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.1.1)

Arguments:

none[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.1.1-1.2)

Responses:

REQUIRED untagged response:

CAPABILITY[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.1.1-1.4.1.2)

Result:

OK -

capability completed[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.1.1-1.6.1.2)

BAD -

arguments invalid[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.1.1-1.6.1.4)

The CAPABILITY command requests a listing of capabilities (e.g., extensions and/or modifications of server behavior) that the server supports. The server MUST send a single untagged CAPABILITY response with "IMAP4rev2" as one of the listed capabilities before the (tagged) OK response.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.1.1-2)

A capability name that begins with "AUTH=" indicates that the server supports that particular authentication mechanism as defined in the Simple Authentication and Security Layer (SASL) \[[SASL](https://www.rfc-editor.org/info/rfc9051/#RFC4422)\]. All such names are, by definition, part of this specification.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.1.1-3)

Other capability names refer to extensions, revisions, or amendments to this specification. See the documentation of the CAPABILITY response in [Section 7.2.2](https://www.rfc-editor.org/info/rfc9051/#capability-resp) for additional information. If IMAP4rev1 capability is not advertised, no capabilities, beyond the base IMAP4rev2 set defined in this specification, are enabled without explicit client action to invoke the capability. If both IMAP4rev1 and IMAP4rev2 capabilities are advertised, no capabilities, beyond the base IMAP4rev1 set specified in \[[RFC3501](https://www.rfc-editor.org/info/rfc9051/#RFC3501)\], are enabled without explicit client action to invoke the capability.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.1.1-4)

Client and server implementations MUST implement the STARTTLS ([Section 6.2.1](https://www.rfc-editor.org/info/rfc9051/#STARTTLS)) and LOGINDISABLED capabilities on cleartext ports. Client and server implementations MUST also implement AUTH=PLAIN (described in \[[PLAIN](https://www.rfc-editor.org/info/rfc9051/#RFC4616)\]) capability on both cleartext and Implicit TLS ports. See the Security Considerations ([Section 11](https://www.rfc-editor.org/info/rfc9051/#sec-cons)) for important information.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.1.1-5)

Unless otherwise specified, all registered extensions to IMAP4rev1 are also valid extensions to IMAP4rev2.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.1.1-6)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.1.1-7)

#### [6.1.2.](https://www.rfc-editor.org/info/rfc9051/#section-6.1.2) [NOOP Command](https://www.rfc-editor.org/info/rfc9051/#name-noop-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.1.2)

Arguments:

none[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.1.2-1.2)

Responses:

no specific responses for this command (but see below)[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.1.2-1.4)

Result:

OK -

noop completed[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.1.2-1.6.1.2)

BAD -

command unknown or arguments invalid[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.1.2-1.6.1.4)

The NOOP command always succeeds. It does nothing.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.1.2-2)

Since any command can return a status update as untagged data, the NOOP command can be used as a periodic poll for new messages or message status updates during a period of inactivity (the IDLE command; see [Section 6.3.13](https://www.rfc-editor.org/info/rfc9051/#idle)) should be used instead of NOOP if real-time updates to mailbox state are desirable). The NOOP command can also be used to reset any inactivity autologout timer on the server.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.1.2-3)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.1.2-4)

#### [6.1.3.](https://www.rfc-editor.org/info/rfc9051/#section-6.1.3) [LOGOUT Command](https://www.rfc-editor.org/info/rfc9051/#name-logout-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.1.3)

Arguments:

none[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.1.3-1.2)

Responses:

REQUIRED untagged response:

BYE[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.1.3-1.4.1.2)

Result:

OK -

logout completed[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.1.3-1.6.1.2)

BAD -

command unknown or arguments invalid[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.1.3-1.6.1.4)

The LOGOUT command informs the server that the client is done with the connection. The server MUST send a BYE untagged response before the (tagged) OK response, and then close the network connection.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.1.3-2)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.1.3-3)

### [6.2.](https://www.rfc-editor.org/info/rfc9051/#section-6.2) [Client Commands - Not Authenticated State](https://www.rfc-editor.org/info/rfc9051/#name-client-commands-not-authent) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.2)

In the not authenticated state, the AUTHENTICATE or LOGIN command establishes authentication and enters the authenticated state. The AUTHENTICATE command provides a general mechanism for a variety of authentication techniques, privacy protection, and integrity checking, whereas the LOGIN command uses a conventional user name and plaintext password pair and has no means of establishing privacy protection or integrity checking.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2-1)

The STARTTLS command is an alternative form of establishing session privacy protection and integrity checking but does not by itself establish authentication or enter the authenticated state.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2-2)

Server implementations MAY allow access to certain mailboxes without establishing authentication. This can be done by means of the ANONYMOUS \[[SASL](https://www.rfc-editor.org/info/rfc9051/#RFC4422)\] authenticator described in \[[ANONYMOUS](https://www.rfc-editor.org/info/rfc9051/#RFC4505)\]. An older convention is a LOGIN command using the userid "anonymous"; in this case, a password is required although the server may choose to accept any password. The restrictions placed on anonymous users are implementation dependent.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2-3)

Once authenticated (including as anonymous), it is not possible to re-enter not authenticated state.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2-4)

In addition to the universal commands (CAPABILITY, NOOP, and LOGOUT), the following commands are valid in the not authenticated state: STARTTLS, AUTHENTICATE, and LOGIN. See the Security Considerations ([Section 11](https://www.rfc-editor.org/info/rfc9051/#sec-cons)) for important information about these commands.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2-5)

#### [6.2.1.](https://www.rfc-editor.org/info/rfc9051/#section-6.2.1) [STARTTLS Command](https://www.rfc-editor.org/info/rfc9051/#name-starttls-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.2.1)

Arguments:

none[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.1-1.2)

Responses:

no specific response for this command[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.1-1.4)

Result:

OK -

starttls completed, begin TLS negotiation[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.1-1.6.1.2)

NO -

TLS negotiation can't be initiated, due to server configuration error[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.1-1.6.1.4)

BAD -

STARTTLS received after a successful TLS negotiation or arguments invalid[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.1-1.6.1.6)

Note that the STARTTLS command is available only on cleartext ports. The server MUST always respond with a tagged BAD response when the STARTTLS command is received on an Implicit TLS port.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.1-2)

A [TLS](https://www.rfc-editor.org/info/rfc9051/#RFC8446) \[[TLS-1.3](https://www.rfc-editor.org/info/rfc9051/#RFC8446)\] negotiation begins immediately after the CRLF at the end of the tagged OK response from the server. Once a client issues a STARTTLS command, it MUST NOT issue further commands until a server response is seen and the TLS negotiation is complete. Some past server implementations incorrectly implemented STARTTLS processing and are known to contain STARTTLS plaintext command injection vulnerability \[[CERT-555316](https://www.rfc-editor.org/info/rfc9051/#CERT-555316)\]. In order to avoid this vulnerability, server implementations MUST do one of the following if any data is received in the same TCP buffer after the CRLF that starts the STARTTLS command:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.1-3)

1.  Extra data from the TCP buffer is interpreted as the beginning of the TLS handshake. (If the data is in cleartext, this will result in the TLS handshake failing.)[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.1-4.1)
2.  Extra data from the TCP buffer is thrown away.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.1-4.2)

Note that the first option is friendlier to clients that pipeline the beginning of the STARTTLS command with TLS handshake data.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.1-5)

After successful TLS negotiation, the server remains in the non-authenticated state, even if client credentials are supplied during the TLS negotiation. This does not preclude an authentication mechanism such as EXTERNAL (defined in \[[SASL](https://www.rfc-editor.org/info/rfc9051/#RFC4422)\]) from using client identity determined by the TLS negotiation.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.1-6)

Once TLS has been started, the client MUST discard cached information about server capabilities and SHOULD reissue the CAPABILITY command. This is necessary to protect against active attacks that alter the capabilities list prior to STARTTLS. The server MAY advertise different capabilities and, in particular, SHOULD NOT advertise the STARTTLS capability, after a successful STARTTLS command.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.1-7)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.1-8)

#### [6.2.2.](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2) [AUTHENTICATE Command](https://www.rfc-editor.org/info/rfc9051/#name-authenticate-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.2.2)

Arguments:

SASL authentication mechanism name[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-1.2.1)

OPTIONAL initial response[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-1.2.2)

Responses:

continuation data can be requested[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-1.4)

Result:

OK -

authenticate completed, now in authenticated state[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-1.6.1.2)

NO -

authenticate failure: unsupported authentication mechanism, credentials rejected[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-1.6.1.4)

BAD -

command unknown or arguments invalid, authentication exchange canceled[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-1.6.1.6)

The AUTHENTICATE command indicates a \[[SASL](https://www.rfc-editor.org/info/rfc9051/#RFC4422)\] authentication mechanism to the server. If the server supports the requested authentication mechanism, it performs an authentication protocol exchange to authenticate and identify the client. It MAY also negotiate an OPTIONAL security layer for subsequent protocol interactions. If the requested authentication mechanism is not supported, the server SHOULD reject the AUTHENTICATE command by sending a tagged NO response.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-2)

The AUTHENTICATE command supports the optional "initial response" feature defined in [Section 4](https://www.rfc-editor.org/info/rfc4422/#section-4) of \[[SASL](https://www.rfc-editor.org/info/rfc9051/#RFC4422)\]. The client doesn't need to use it. If a SASL mechanism supports "initial response", but it is not specified by the client, the server handles it as specified in [Section 3](https://www.rfc-editor.org/info/rfc4422/#section-3) of \[[SASL](https://www.rfc-editor.org/info/rfc9051/#RFC4422)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-3)

The service name specified by this protocol's profile of \[[SASL](https://www.rfc-editor.org/info/rfc9051/#RFC4422)\] is "imap".[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-4)

The authentication protocol exchange consists of a series of server challenges and client responses that are specific to the authentication mechanism. A server challenge consists of a command continuation request response with the "+" token followed by a base64-encoded (see [Section 4](https://www.rfc-editor.org/info/rfc4648/#section-4) of \[[RFC4648](https://www.rfc-editor.org/info/rfc9051/#RFC4648)\]) string. The client response consists of a single line consisting of a base64-encoded string. If the client wishes to cancel an authentication exchange, it issues a line consisting of a single "\*". If the server receives such a response, or if it receives an invalid base64 string (e.g., characters outside the base64 alphabet or non-terminal "="), it MUST reject the AUTHENTICATE command by sending a tagged BAD response.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-5)

As with any other client response, the initial response MUST be encoded as base64. It also MUST be transmitted outside of a quoted string or literal. To send a zero-length initial response, the client MUST send a single pad character ("="). This indicates that the response is present, but it is a zero-length string.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-6)

When decoding the base64 data in the initial response, decoding errors MUST be treated as in any normal SASL client response, i.e., with a tagged BAD response. In particular, the server should check for any characters not explicitly allowed by the base64 alphabet, as well as any sequence of base64 characters that contains the pad character ('=') anywhere other than the end of the string (e.g., "=AAA" and "AAA=BBB" are not allowed).[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-7)

If the client uses an initial response with a SASL mechanism that does not support an initial response, the server MUST reject the command with a tagged BAD response.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-8)

If a security layer is negotiated through the \[[SASL](https://www.rfc-editor.org/info/rfc9051/#RFC4422)\] authentication exchange, it takes effect immediately following the CRLF that concludes the authentication exchange for the client and the CRLF of the tagged OK response for the server.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-9)

While client and server implementations MUST implement the AUTHENTICATE command itself, it is not required to implement any authentication mechanisms other than the PLAIN mechanism described in \[[PLAIN](https://www.rfc-editor.org/info/rfc9051/#RFC4616)\]. Also, an authentication mechanism is not required to support any security layers.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-10)

Note: a server implementation MUST implement a configuration in which it does NOT permit any plaintext password mechanisms, unless the STARTTLS command has been negotiated, TLS has been negotiated on an Implicit TLS port, or some other mechanism that protects the session from password snooping has been provided. Server sites SHOULD NOT use any configuration that permits a plaintext password mechanism without such a protection mechanism against password snooping. Client and server implementations SHOULD implement additional \[[SASL](https://www.rfc-editor.org/info/rfc9051/#RFC4422)\] mechanisms that do not use plaintext passwords, such as the GSSAPI mechanism described in \[[RFC4752](https://www.rfc-editor.org/info/rfc9051/#RFC4752)\], the SCRAM-SHA-256/SCRAM-SHA-256-PLUS \[[SCRAM-SHA-256](https://www.rfc-editor.org/info/rfc9051/#RFC7677)\] mechanisms, and/or the EXTERNAL \[[SASL](https://www.rfc-editor.org/info/rfc9051/#RFC4422)\] mechanism for mutual TLS authentication. (Note that the SASL framework allows for the creation of SASL mechanisms that support 2-factor authentication (2FA); however, none are fully ready to be recommended by this document.)[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-11)

Servers and clients can support multiple authentication mechanisms. The server SHOULD list its supported authentication mechanisms in the response to the CAPABILITY command so that the client knows which authentication mechanisms to use.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-12)

A server MAY include a CAPABILITY response code in the tagged OK response of a successful AUTHENTICATE command in order to send capabilities automatically. It is unnecessary for a client to send a separate CAPABILITY command if it recognizes these automatic capabilities. This should only be done if a security layer was not negotiated by the AUTHENTICATE command, because the tagged OK response as part of an AUTHENTICATE command is not protected by encryption/integrity checking. \[[SASL](https://www.rfc-editor.org/info/rfc9051/#RFC4422)\] requires the client to re-issue a CAPABILITY command in this case. The server MAY advertise different capabilities after a successful AUTHENTICATE command.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-13)

If an AUTHENTICATE command fails with a NO response, the client MAY try another authentication mechanism by issuing another AUTHENTICATE command. It MAY also attempt to authenticate by using the LOGIN command (see [Section 6.2.3](https://www.rfc-editor.org/info/rfc9051/#login) for more detail). In other words, the client MAY request authentication types in decreasing order of preference, with the LOGIN command as a last resort.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-14)

The authorization identity passed from the client to the server during the authentication exchange is interpreted by the server as the user name whose privileges the client is requesting.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-15)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-16)

The following example demonstrates the use of an initial response.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-18)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-19)

Note that because the initial response is optional, the following negotiation (which does not use the initial response) is still valid and MUST be supported by the server:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-21)

Note that in the above example there is a space following the "+" from the server.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-23)

The following is an example authentication using the SASL EXTERNAL mechanism (defined in \[[SASL](https://www.rfc-editor.org/info/rfc9051/#RFC4422)\]) under a TLS protection layer and an empty initial response:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-24)

Note: The line breaks within server challenges and client responses are for editorial clarity and are not in real authenticators.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.2-26)

#### [6.2.3.](https://www.rfc-editor.org/info/rfc9051/#section-6.2.3) [LOGIN Command](https://www.rfc-editor.org/info/rfc9051/#name-login-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.2.3)

Arguments:

user name[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.3-1.2.1)

password[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.3-1.2.2)

Responses:

no specific responses for this command[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.3-1.4)

Result:

OK -

login completed, now in authenticated state[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.3-1.6.1.2)

NO -

login failure: user name or password rejected[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.3-1.6.1.4)

BAD -

command unknown or arguments invalid[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.3-1.6.1.6)

The LOGIN command identifies the client to the server and carries the plaintext password authenticating this user. The LOGIN command SHOULD NOT be used except as a last resort (after attempting and failing to authenticate using the AUTHENTICATE command one or more times), and it is recommended that client implementations have a means to disable any automatic use of the LOGIN command.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.3-2)

A server MAY include a CAPABILITY response code in the tagged OK response to a successful LOGIN command in order to send capabilities automatically. It is unnecessary for a client to send a separate CAPABILITY command if it recognizes these automatic capabilities.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.3-3)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.3-4)

Note: Use of the LOGIN command over an insecure network (such as the Internet) is a security risk, because anyone monitoring network traffic can obtain plaintext passwords. For that reason, clients MUST NOT use LOGIN on unsecure networks.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.3-6)

Unless the client is accessing IMAP service on an Implicit TLS port \[[RFC8314](https://www.rfc-editor.org/info/rfc9051/#RFC8314)\], the STARTTLS command has been negotiated, or some other mechanism that protects the session from password snooping has been provided, a server implementation MUST implement a configuration in which it advertises the LOGINDISABLED capability and does NOT permit the LOGIN command. Server sites SHOULD NOT use any configuration that permits the LOGIN command without such a protection mechanism against password snooping. A client implementation MUST NOT send a LOGIN command if the LOGINDISABLED capability is advertised.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.2.3-7)

### [6.3.](https://www.rfc-editor.org/info/rfc9051/#section-6.3) [Client Commands - Authenticated State](https://www.rfc-editor.org/info/rfc9051/#name-client-commands-authenticat) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.3)

In the authenticated state, commands that manipulate mailboxes as atomic entities are permitted. Of these commands, SELECT and EXAMINE will select a mailbox for access and enter the selected state.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3-1)

In addition to the universal commands (CAPABILITY, NOOP, and LOGOUT), the following commands are valid in the authenticated state: ENABLE, SELECT, EXAMINE, NAMESPACE, CREATE, DELETE, RENAME, SUBSCRIBE, UNSUBSCRIBE, LIST, STATUS, APPEND, and IDLE.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3-2)

#### [6.3.1.](https://www.rfc-editor.org/info/rfc9051/#section-6.3.1) [ENABLE Command](https://www.rfc-editor.org/info/rfc9051/#name-enable-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.3.1)

Arguments:

capability names[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.1-1.2)

Responses:

no specific responses for this command[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.1-1.4)

Result:

OK -

Relevant capabilities enabled[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.1-1.6.1.2)

BAD -

No arguments, or syntax error in an argument[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.1-1.6.1.4)

Several IMAP extensions allow the server to return unsolicited responses specific to these extensions in certain circumstances. However, servers cannot send those unsolicited responses (with the exception of response codes (see [Section 7.1](https://www.rfc-editor.org/info/rfc9051/#server-status-responses)) included in tagged or untagged OK/NO/BAD responses, which can always be sent) until they know that the clients support such extensions and thus will be able to correctly parse and process the extension response data.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.1-2)

The ENABLE command provides an explicit indication from the client that it supports particular extensions. It is designed such that the client can send a simple constant string with the extensions it supports, and the server will enable the shared subset that both support.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.1-3)

The ENABLE command takes a list of capability names and requests the server to enable the named extensions. Once enabled using ENABLE, each extension remains active until the IMAP connection is closed. For each argument, the server does the following:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.1-4)

-   If the argument is not an extension known to the server, the server MUST ignore the argument.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.1-5.1)
-   If the argument is an extension known to the server, and it is not specifically permitted to be enabled using ENABLE, the server MUST ignore the argument. (Note that knowing about an extension doesn't necessarily imply supporting that extension.)[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.1-5.2)
-   If the argument is an extension that is supported by the server and that needs to be enabled, the server MUST enable the extension for the duration of the connection. Note that once an extension is enabled, there is no way to disable it.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.1-5.3)

If the ENABLE command is successful, the server MUST send an untagged ENABLED response ([Section 7.2.1](https://www.rfc-editor.org/info/rfc9051/#enabled)), which includes all enabled extensions as specified above. The ENABLED response is sent even if no extensions were enabled.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.1-6)

Clients SHOULD only include extensions that need to be enabled by the server. For example, a client can enable IMAP4rev2-specific behavior when both IMAP4rev1 and IMAP4rev2 are advertised in the CAPABILITY response. Future RFCs may add to this list.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.1-7)

The ENABLE command is only valid in the authenticated state, before any mailbox is selected. Clients MUST NOT issue ENABLE once they SELECT/EXAMINE a mailbox; however, server implementations don't have to check that no mailbox is selected or was previously selected during the duration of a connection.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.1-8)

The ENABLE command can be issued multiple times in a session. It is additive; that is, "ENABLE a b", followed by "ENABLE c", is the same as a single command "ENABLE a b c". When multiple ENABLE commands are issued, each corresponding ENABLED response SHOULD only contain extensions enabled by the corresponding ENABLE command, i.e., for the above example, the ENABLED response to "ENABLE c" should not contain "a" or "b".[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.1-9)

There are no limitations on pipelining ENABLE. For example, it is possible to send ENABLE and then immediately SELECT, or a LOGIN immediately followed by ENABLE.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.1-10)

The server MUST NOT change the CAPABILITY list as a result of executing ENABLE; that is, a CAPABILITY command issued right after an ENABLE command MUST list the same capabilities as a CAPABILITY command issued before the ENABLE command. This is demonstrated in the following example. Note that below "X-GOOD-IDEA" is a fictitious extension capability that can be ENABLED.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.1-11)

In the following example, the client enables the Conditional Store (CONDSTORE) extension \[[RFC7162](https://www.rfc-editor.org/info/rfc9051/#RFC7162)\]:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.1-13)

##### [6.3.1.1.](https://www.rfc-editor.org/info/rfc9051/#section-6.3.1.1) [Note to Designers of Extensions That May Use the ENABLE Command](https://www.rfc-editor.org/info/rfc9051/#name-note-to-designers-of-extens)

Designers of IMAP extensions are discouraged from creating extensions that require ENABLE unless there is no good alternative design. Specifically, extensions that cause potentially incompatible behavior changes to deployed server responses (and thus benefit from ENABLE) have a higher complexity cost than extensions that do not.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.1.1-1)

#### [6.3.2.](https://www.rfc-editor.org/info/rfc9051/#section-6.3.2) [SELECT Command](https://www.rfc-editor.org/info/rfc9051/#name-select-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.3.2)

Arguments:

mailbox name[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.2-1.2)

Responses:

REQUIRED untagged responses:

FLAGS, EXISTS, LIST[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.2-1.4.1.2)

REQUIRED OK untagged responses:

PERMANENTFLAGS, UIDNEXT, UIDVALIDITY[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.2-1.4.1.4)

Result:

OK -

select completed, now in selected state[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.2-1.6.1.2)

NO -

select failure, now in authenticated state: no such mailbox, can't access mailbox[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.2-1.6.1.4)

BAD -

command unknown or arguments invalid[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.2-1.6.1.6)

The SELECT command selects a mailbox so that messages in the mailbox can be accessed. Before returning an OK to the client, the server MUST send the following untagged data to the client. (The order of individual responses is not important.) Note that earlier versions of this protocol, such as the IMAP4rev1 version specified in \[[RFC2060](https://www.rfc-editor.org/info/rfc9051/#RFC2060)\], only required the FLAGS and EXISTS untagged responses and UIDVALIDITY response code. Client implementations that need to remain compatible with such older IMAP versions have to implement default behavior for missing data, as discussed with the individual items.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.2-2)

FLAGS

Defined flags in the mailbox. See the description of the FLAGS response in [Section 7.3.5](https://www.rfc-editor.org/info/rfc9051/#flags-resp) for more detail.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.2-3.2)

<n> EXISTS

The number of messages in the mailbox. See the description of the EXISTS response in [Section 7.4.1](https://www.rfc-editor.org/info/rfc9051/#exists) for more detail.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.2-3.4)

LIST

The server MUST return a LIST response with the mailbox name. The list of mailbox attributes MUST be accurate. If the server allows denormalized UTF-8 mailbox names (see [Section 5.1](https://www.rfc-editor.org/info/rfc9051/#mailbox-naming)) and the supplied mailbox name differs from the normalized version, the server MUST return LIST with the OLDNAME extended data item. See [Section 6.3.9.7](https://www.rfc-editor.org/info/rfc9051/#oldname) for more details.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.2-3.6)

OK \[PERMANENTFLAGS (<list of flags>)\]

A list of message flags that the client can change permanently. If this is missing, the client should assume that all flags can be changed permanently.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.2-3.8)

OK \[UIDNEXT <n>\]

The next unique identifier value. Refer to [Section 2.3.1.1](https://www.rfc-editor.org/info/rfc9051/#uid-def) for more information.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.2-3.10)

OK \[UIDVALIDITY <n>\]

The unique identifier validity value. Refer to [Section 2.3.1.1](https://www.rfc-editor.org/info/rfc9051/#uid-def) for more information.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.2-3.12)

Only one mailbox can be selected at a time in a connection; simultaneous access to multiple mailboxes requires multiple connections. The SELECT command automatically deselects any currently selected mailbox before attempting the new selection. Consequently, if a mailbox is selected and a SELECT command that fails is attempted, no mailbox is selected. When deselecting a selected mailbox, the server MUST return an untagged OK response with the "\[CLOSED\]" response code when the currently selected mailbox is closed (see [Section 7.1](https://www.rfc-editor.org/info/rfc9051/#closed)).[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.2-4)

If the client is permitted to modify the mailbox, the server SHOULD prefix the text of the tagged OK response with the "\[READ-WRITE\]" response code.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.2-5)

If the client is not permitted to modify the mailbox but is permitted read access, the mailbox is selected as read-only, and the server MUST prefix the text of the tagged OK response to SELECT with the "\[READ-ONLY\]" response code. Read-only access through SELECT differs from the EXAMINE command in that certain read-only mailboxes MAY permit the change of permanent state on a per-user (as opposed to global) basis. Netnews messages marked in a server-based .newsrc file are an example of such per-user permanent state that can be modified with read-only mailboxes.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.2-6)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.2-7)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.2-9)

Note that IMAP4rev1-compliant servers can also send the untagged RECENT response that was deprecated in IMAP4rev2, e.g., "\* 0 RECENT". Pure IMAP4rev2 clients are advised to ignore the untagged RECENT response.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.2-11)

#### [6.3.3.](https://www.rfc-editor.org/info/rfc9051/#section-6.3.3) [EXAMINE Command](https://www.rfc-editor.org/info/rfc9051/#name-examine-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.3.3)

Arguments:

mailbox name[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.3-1.2)

Responses:

REQUIRED untagged responses:

FLAGS, EXISTS, LIST[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.3-1.4.1.2)

REQUIRED OK untagged responses:

PERMANENTFLAGS, UIDNEXT, UIDVALIDITY[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.3-1.4.1.4)

Result:

OK -

examine completed, now in selected state[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.3-1.6.1.2)

NO -

examine failure, now in authenticated state: no such mailbox, can't access mailbox[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.3-1.6.1.4)

BAD -

command unknown or arguments invalid[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.3-1.6.1.6)

The EXAMINE command is identical to SELECT and returns the same output; however, the selected mailbox is identified as read-only. No changes to the permanent state of the mailbox, including per-user state, are permitted.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.3-2)

The text of the tagged OK response to the EXAMINE command MUST begin with the "\[READ-ONLY\]" response code.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.3-3)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.3-4)

#### [6.3.4.](https://www.rfc-editor.org/info/rfc9051/#section-6.3.4) [CREATE Command](https://www.rfc-editor.org/info/rfc9051/#name-create-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.3.4)

Arguments:

mailbox name[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.4-1.2)

Responses:

OPTIONAL untagged response:

LIST[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.4-1.4.1.2)

Result:

OK -

create completed[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.4-1.6.1.2)

NO -

create failure: can't create mailbox with that name[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.4-1.6.1.4)

BAD -

command unknown or arguments invalid[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.4-1.6.1.6)

The CREATE command creates a mailbox with the given name. An OK response is returned only if a new mailbox with that name has been created. It is an error to attempt to create INBOX or a mailbox with a name that refers to an extant mailbox. Any error in creation will return a tagged NO response. If a client attempts to create a UTF-8 mailbox name that is not a valid Net-Unicode name, the server MUST reject the creation or convert the name to Net-Unicode prior to creating the mailbox. If the server decides to convert (normalize) the name, it SHOULD return an untagged LIST with an OLDNAME extended data item, with the OLDNAME value being the supplied mailbox name and the name parameter being the normalized mailbox name. (See [Section 6.3.9.7](https://www.rfc-editor.org/info/rfc9051/#oldname) for more details.)[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.4-2)

Mailboxes created in one IMAP session MAY be announced to other IMAP sessions using an unsolicited LIST response. If the server automatically subscribes a mailbox when it is created, then the unsolicited LIST response for each affected subscribed mailbox name MUST include the \\Subscribed attribute.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.4-3)

If the mailbox name is suffixed with the server's hierarchy separator character (as returned from the server by a LIST command), this is a declaration that the client intends to create mailbox names under this name in the hierarchy. Server implementations that do not require this declaration MUST ignore the declaration. In any case, the name created is without the trailing hierarchy delimiter.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.4-4)

If the server's hierarchy separator character appears elsewhere in the name, the server SHOULD create any superior hierarchical names that are needed for the CREATE command to be successfully completed. In other words, an attempt to create "foo/bar/zap" on a server in which "/" is the hierarchy separator character SHOULD create foo/ and foo/bar/ if they do not already exist.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.4-5)

If a new mailbox is created with the same name as a mailbox that was deleted, its unique identifiers MUST be greater than any unique identifiers used in the previous incarnation of the mailbox unless the new incarnation has a different unique identifier validity value. See the description of the UID command in [Section 6.4.9](https://www.rfc-editor.org/info/rfc9051/#uid-commands) for more detail.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.4-6)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.4-7)

(In the last example, imagine that "NonNormalized" is a non-NFC normalized Unicode mailbox name and that "Normalized" is its NFC normalized version.)[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.4-9)

#### [6.3.5.](https://www.rfc-editor.org/info/rfc9051/#section-6.3.5) [DELETE Command](https://www.rfc-editor.org/info/rfc9051/#name-delete-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.3.5)

Arguments:

mailbox name[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.5-1.2)

Responses:

OPTIONAL untagged response:

LIST[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.5-1.4.1.2)

Result:

OK -

delete completed[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.5-1.6.1.2)

NO -

delete failure: can't delete mailbox with that name[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.5-1.6.1.4)

BAD -

command unknown or arguments invalid[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.5-1.6.1.6)

The DELETE command permanently removes the mailbox with the given name. A tagged OK response is returned only if the mailbox has been deleted. It is an error to attempt to delete INBOX or a mailbox name that does not exist.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.5-2)

The DELETE command MUST NOT remove inferior hierarchical names. For example, if a mailbox "foo" has an inferior "foo.bar" (assuming "." is the hierarchy delimiter character), removing "foo" MUST NOT remove "foo.bar". It is an error to attempt to delete a name that has inferior hierarchical names and also has the \\Noselect mailbox name attribute (see the description of the LIST response ([Section 7.3.1](https://www.rfc-editor.org/info/rfc9051/#list-resp)) for more details).[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.5-3)

It is permitted to delete a name that has inferior hierarchical names and does not have the \\Noselect mailbox name attribute. If the server implementation does not permit deleting the name while inferior hierarchical names exist, then it SHOULD disallow the DELETE command by returning a tagged NO response. The NO response SHOULD include the HASCHILDREN response code. Alternatively, the server MAY allow the DELETE command, but it sets the \\Noselect mailbox name attribute for that name.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.5-4)

If the server returns an OK response, all messages in that mailbox are removed by the DELETE command.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.5-5)

The value of the highest-used unique identifier of the deleted mailbox MUST be preserved so that a new mailbox created with the same name will not reuse the identifiers of the former incarnation, unless the new incarnation has a different unique identifier validity value. See the description of the UID command in [Section 6.4.9](https://www.rfc-editor.org/info/rfc9051/#uid-commands) for more detail.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.5-6)

If the server decides to convert (normalize) the mailbox name, it SHOULD return an untagged LIST with the "\\NonExistent" attribute and OLDNAME extended data item, with the OLDNAME value being the supplied mailbox name and the name parameter being the normalized mailbox name. (See [Section 6.3.9.7](https://www.rfc-editor.org/info/rfc9051/#oldname) for more details.)[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.5-7)

Mailboxes deleted in one IMAP session MAY be announced to other IMAP sessions using an unsolicited LIST response, containing the "\\NonExistent" attribute.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.5-8)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.5-9)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.5-11)

#### [6.3.6.](https://www.rfc-editor.org/info/rfc9051/#section-6.3.6) [RENAME Command](https://www.rfc-editor.org/info/rfc9051/#name-rename-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.3.6)

Arguments:

existing mailbox name[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.6-1.2.1)

new mailbox name[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.6-1.2.2)

Responses:

OPTIONAL untagged response:

LIST[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.6-1.4.1.2)

Result:

OK -

rename completed[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.6-1.6.1.2)

NO -

rename failure: can't rename mailbox with that name, can't rename to mailbox with that name[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.6-1.6.1.4)

BAD -

command unknown or arguments invalid[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.6-1.6.1.6)

The RENAME command changes the name of a mailbox. A tagged OK response is returned only if the mailbox has been renamed. It is an error to attempt to rename from a mailbox name that does not exist or to a mailbox name that already exists. Any error in renaming will return a tagged NO response.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.6-2)

If the name has inferior hierarchical names, then the inferior hierarchical names MUST also be renamed. For example, a rename of "foo" to "zap" will rename "foo/bar" (assuming "/" is the hierarchy delimiter character) to "zap/bar".[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.6-3)

If the server's hierarchy separator character appears in the new mailbox name, the server SHOULD create any superior hierarchical names that are needed for the RENAME command to complete successfully. In other words, an attempt to rename "foo/bar/zap" to "baz/rag/zowie" on a server in which "/" is the hierarchy separator character in the corresponding namespace SHOULD create "baz/" and "baz/rag/" if they do not already exist.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.6-4)

The value of the highest-used unique identifier of the old mailbox name MUST be preserved so that a new mailbox created with the same name will not reuse the identifiers of the former incarnation, unless the new incarnation has a different unique identifier validity value. See the description of the UID command in [Section 6.4.9](https://www.rfc-editor.org/info/rfc9051/#uid-commands) for more detail.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.6-5)

Renaming INBOX is permitted and does not result in a tagged BAD response, and it has special behavior: It moves all messages in INBOX to a new mailbox with the given name, leaving INBOX empty. If the server implementation supports inferior hierarchical names of INBOX, these are unaffected by a rename of INBOX. (Note that some servers disallow renaming INBOX by returning a tagged NO response, so clients need to be able to handle the failure of such RENAME commands.)[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.6-6)

If the server allows creation of mailboxes with names that are not valid Net-Unicode names, the server normalizes both the existing mailbox name parameter and the new mailbox name parameter. If the normalized version of any of these 2 parameters differs from the corresponding supplied version, the server SHOULD return an untagged LIST response with an OLDNAME extended data item, with the OLDNAME value being the supplied existing mailbox name and the name parameter being the normalized new mailbox name (see [Section 6.3.9.7](https://www.rfc-editor.org/info/rfc9051/#oldname)). This would allow the client to correlate the supplied name with the normalized name.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.6-7)

Mailboxes renamed in one IMAP session MAY be announced to other IMAP sessions using an unsolicited LIST response with an OLDNAME extended data item.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.6-8)

In both of the above cases, if the server automatically subscribes a mailbox when it is renamed, then the unsolicited LIST response for each affected subscribed mailbox name MUST include the \\Subscribed attribute. No unsolicited LIST responses need to be sent for child mailboxes. When INBOX is successfully renamed, it is assumed that a new INBOX is created. No unsolicited LIST responses need to be sent for INBOX in this case.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.6-9)

Examples:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.6-10)

Note that renaming a mailbox doesn't update subscription information on the original name. To keep subscription information in sync, the following sequence of commands can be used:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.6-12)

Note that the above sequence of commands doesn't account for updating the subscription for any child mailboxes of mailbox X.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.6-14)

#### [6.3.7.](https://www.rfc-editor.org/info/rfc9051/#section-6.3.7) [SUBSCRIBE Command](https://www.rfc-editor.org/info/rfc9051/#name-subscribe-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.3.7)

Arguments:

mailbox[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.7-1.2)

Responses:

no specific responses for this command[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.7-1.4)

Result:

OK -

subscribe completed[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.7-1.6.1.2)

NO -

subscribe failure: can't subscribe to that name[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.7-1.6.1.4)

BAD -

command unknown or arguments invalid[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.7-1.6.1.6)

The SUBSCRIBE command adds the specified mailbox name to the server's set of "active" or "subscribed" mailboxes as returned by the LIST (SUBSCRIBED) command. This command returns a tagged OK response if the subscription is successful or if the mailbox is already subscribed.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.7-2)

A server MAY validate the mailbox argument to SUBSCRIBE to verify that it exists. However, it SHOULD NOT unilaterally remove an existing mailbox name from the subscription list even if a mailbox by that name no longer exists.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.7-3)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.7-5)

#### [6.3.8.](https://www.rfc-editor.org/info/rfc9051/#section-6.3.8) [UNSUBSCRIBE Command](https://www.rfc-editor.org/info/rfc9051/#name-unsubscribe-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.3.8)

Arguments:

mailbox name[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.8-1.2)

Responses:

no specific responses for this command[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.8-1.4)

Result:

OK -

unsubscribe completed[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.8-1.6.1.2)

NO -

unsubscribe failure: can't unsubscribe that name[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.8-1.6.1.4)

BAD -

command unknown or arguments invalid[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.8-1.6.1.6)

The UNSUBSCRIBE command removes the specified mailbox name from the server's set of "active" or "subscribed" mailboxes as returned by the LIST (SUBSCRIBED) command. This command returns a tagged OK response if the unsubscription is successful or if the mailbox is not subscribed.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.8-2)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.8-3)

#### [6.3.9.](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9) [LIST Command](https://www.rfc-editor.org/info/rfc9051/#name-list-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.3.9)

Arguments (basic):

-   reference name[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-1.2.1.1)
-   mailbox name with possible wildcards[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-1.2.1.2)

Arguments (extended):

-   selection options (OPTIONAL)[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-1.4.1.1)
-   reference name[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-1.4.1.2)
-   mailbox patterns[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-1.4.1.3)
-   return options (OPTIONAL)[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-1.4.1.4)

Responses:

untagged responses: LIST[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-1.6)

Result:

OK -

list completed[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-1.8.1.2)

NO -

list failure: can't list that reference or mailbox name[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-1.8.1.4)

BAD -

command unknown or arguments invalid[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-1.8.1.6)

The LIST command returns a subset of mailbox names from the complete set of all mailbox names available to the client. Zero or more untagged LIST responses are returned, containing the name attributes, hierarchy delimiter, name, and possible extension information; see the description of the LIST response ([Section 7.3.1](https://www.rfc-editor.org/info/rfc9051/#list-resp)) for more detail.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-2)

The LIST command SHOULD return its data quickly, without undue delay. For example, it should not go to excess trouble to calculate the \\Marked or \\Unmarked status or perform other processing; if each name requires 1 second of processing, then a list of 1200 names would take 20 minutes![¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-3)

The extended LIST command, originally introduced in \[[RFC5258](https://www.rfc-editor.org/info/rfc9051/#RFC5258)\], provides capabilities beyond that of the original IMAP LIST command. The extended syntax is being used if one or more of the following conditions is true:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-4)

1.  the first word after the command name begins with a parenthesis ("LIST selection options");[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-5.1)
2.  the second word after the command name begins with a parenthesis; and[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-5.2)
3.  the LIST command has more than 2 parameters ("LIST return options").[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-5.3)

An empty ("" string) reference name argument indicates that the mailbox name is interpreted as by SELECT. The returned mailbox names MUST match the supplied mailbox name pattern(s). A non-empty reference name argument is the name of a mailbox or a level of mailbox hierarchy, and it indicates the context in which the mailbox name is interpreted. Clients SHOULD use the empty reference argument.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-6)

In the basic syntax only, an empty ("" string) mailbox name argument is a special request to return the hierarchy delimiter and the root name of the name given in the reference. The value returned as the root MAY be the empty string if the reference is non-rooted or is an empty string. In all cases, a hierarchy delimiter (or NIL if there is no hierarchy) is returned. This permits a client to get the hierarchy delimiter (or find out that the mailbox names are flat) even when no mailboxes by that name currently exist.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-7)

In the extended syntax, any mailbox name arguments that are empty strings are ignored. There is no special meaning for empty mailbox names when the extended syntax is used.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-8)

The reference and mailbox name arguments are interpreted into a canonical form that represents an unambiguous left-to-right hierarchy. The returned mailbox names will be in the interpreted form, which we call a "canonical LIST pattern": the canonical pattern constructed internally by the server from the reference and mailbox name arguments.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-9)

Note: The interpretation of the reference argument is implementation defined. It depends on whether the server implementation has a concept of the "current working directory" and leading "break out characters", which override the current working directory.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-10)

For example, on a server that exports a UNIX or NT file system, the reference argument contains the current working directory, and the mailbox name argument contains the name as interpreted in the current working directory.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-11)

If a server implementation has no concept of break out characters, the canonical form is normally the reference name appended with the mailbox name. Note that if the server implements the namespace convention ([Section 5.1.2.1](https://www.rfc-editor.org/info/rfc9051/#namespace-convention)), "#" is a break out character and must be treated as such.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-12)

If the reference argument is not a level of mailbox hierarchy (that is, it is a \\NoInferiors name), and/or the reference argument does not end with the hierarchy delimiter, it is interpreted as implementation dependent. For example, a reference of "foo/bar" and mailbox name of "rag/baz" could be interpreted as "foo/bar/rag/baz", "foo/barrag/baz", or "foo/rag/baz". A client SHOULD NOT use such a reference argument except at the explicit request of the user. A hierarchical browser MUST NOT make any assumptions about server interpretation of the reference unless the reference is a level of mailbox hierarchy AND ends with the hierarchy delimiter.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-13)

Any part of the reference argument that is included in the interpreted form SHOULD prefix the interpreted form. It SHOULD also be in the same form as the reference name argument. This rule permits the client to determine if the returned mailbox name is in the context of the reference argument or if something about the mailbox argument overrode the reference argument. Without this rule, the client would have to have knowledge of the server's naming semantics including what characters are "breakouts" that override a naming context.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-14)

Here are some examples of how references and mailbox names might be interpreted on a UNIX-based server:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-15)

The first three examples above demonstrate interpretations in the context of the reference argument. Note that "~smith/Mail" SHOULD NOT be transformed into something like "/u2/users/smith/Mail", or it would be impossible for the client to determine that the interpretation was in the context of the reference.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-17)

The character "\*" is a wildcard and matches zero or more characters at this position. The character "%" is similar to "\*", but it does not match a hierarchy delimiter. If the "%" wildcard is the last character of a mailbox name argument, matching levels of hierarchy are also returned. If these levels of hierarchy are not also selectable mailboxes, they are returned with the \\Noselect mailbox name attribute (see the description of the LIST response ([Section 7.3.1](https://www.rfc-editor.org/info/rfc9051/#list-resp)) for more details).[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-18)

Any syntactically valid pattern that is not accepted by a server for any reason MUST be silently ignored, i.e., it results in no LIST responses, and the LIST command still returns a tagged OK response.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-19)

Selection options tell the server to limit the mailbox names that are selected by the LIST operation. If selection options are used, the mailboxes returned are those that match both the list of canonical LIST patterns and the selection options. Unless a particular selection option provides special rules, the selection options are cumulative: a mailbox that matches the mailbox patterns is selected only if it also matches all of the selection options. (An example of a selection option with special rules is the RECURSIVEMATCH option.)[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-20)

Return options control what information is returned for each matched mailbox. Return options MUST NOT cause the server to report information about additional mailbox names other than those that match the canonical LIST patterns and selection options. If no return options are specified, the client is only expecting information about mailbox attributes. The server MAY return other information about the matched mailboxes, and clients MUST be able to handle that situation.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-21)

Initial selection options and return options are defined in the following subsections, and new ones will also be defined in extensions. Initial options defined in this document MUST be supported. Each non-initial option will be enabled by a capability string (one capability may enable multiple options), and a client MUST NOT send an option for which the server has not advertised support. A server MUST respond to options it does not recognize with a BAD response. The client SHOULD NOT specify any option more than once; however, if the client does this, the server MUST act as if it received the option only once. The order in which options are specified by the client is not significant.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-22)

In general, each selection option except RECURSIVEMATCH will have a corresponding return option with the same name. The REMOTE selection option is an anomaly in this regard and does not have a corresponding return option. That is because it expands, rather than restricts, the set of mailboxes that are returned. Future extensions to this specification should keep this parallelism in mind and define a pair of corresponding selection and return options.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-23)

Server implementations are permitted to "hide" otherwise accessible mailboxes from the wildcard characters, by preventing certain characters or names from matching a wildcard in certain situations. For example, a UNIX-based server might restrict the interpretation of "\*" so that an initial "/" character does not match.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-24)

The special name INBOX is included in the output from LIST, if INBOX is supported by this server for this user and if the uppercase string "INBOX" matches the interpreted reference and mailbox name arguments with wildcards as described above. The criteria for omitting INBOX is whether SELECT INBOX will return a failure; it is not relevant whether the user's real INBOX resides on this or some other server.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9-25)

##### [6.3.9.1.](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.1) [LIST Selection Options](https://www.rfc-editor.org/info/rfc9051/#name-list-selection-options)

The selection options defined in this specification are as follows:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.1-1)

SUBSCRIBED

Causes the LIST command to list subscribed names rather than the existing mailboxes. This will often be a subset of the actual mailboxes. It's also possible for this list to contain the names of mailboxes that don't exist. In any case, the list MUST include exactly those mailbox names that match the canonical list pattern and are subscribed to.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.1-2.2.1)

This option defines a mailbox attribute, "\\Subscribed", that indicates that a mailbox name is subscribed to. The "\\Subscribed" attribute MUST be supported and MUST be accurately computed when the SUBSCRIBED selection option is specified.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.1-2.2.2)

Note that the SUBSCRIBED selection option implies the SUBSCRIBED return option (see below).[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.1-2.2.3)

REMOTE

Causes the LIST command to show remote mailboxes as well as local ones, as described in \[[RFC2193](https://www.rfc-editor.org/info/rfc9051/#RFC2193)\]. This option is intended to replace the RLIST command and, in conjunction with the SUBSCRIBED selection option, the RLSUB command. Servers that don't support the concept of remote mailboxes can ignore this option.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.1-2.4.1)

This option defines a mailbox attribute, "\\Remote", that indicates that a mailbox is a remote mailbox. The "\\Remote" attribute MUST be accurately computed when the REMOTE option is specified.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.1-2.4.2)

The REMOTE selection option has no interaction with other options. Its effect is to tell the server to apply the other options, if any, to remote mailboxes, in addition to local ones. In particular, it has no interaction with RECURSIVEMATCH (see below). A request for (REMOTE RECURSIVEMATCH) is invalid, because a request for (RECURSIVEMATCH) is also invalid. A request for (REMOTE RECURSIVEMATCH SUBSCRIBED) is asking for all subscribed mailboxes, both local and remote.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.1-2.4.3)

RECURSIVEMATCH

Forces the server to return information about parent mailboxes that don't match other selection options but have some submailboxes that do. Information about children is returned in the CHILDINFO extended data item, as described in [Section 6.3.9.6](https://www.rfc-editor.org/info/rfc9051/#childinfo).[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.1-2.6.1)

Note 1:

In order for a parent mailbox to be returned, it still has to match the canonical LIST pattern.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.1-2.6.2.2)

Note 2:

When returning the CHILDINFO extended data item, it doesn't matter whether or not the submailbox matches the canonical LIST pattern. See also Example 9 in [Section 6.3.9.8](https://www.rfc-editor.org/info/rfc9051/#examples).[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.1-2.6.2.4)

The RECURSIVEMATCH option MUST NOT occur as the only selection option (or only with REMOTE), as it only makes sense when other selection options are also used. The server MUST return a BAD tagged response in such case.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.1-2.6.3)

Note that even if the RECURSIVEMATCH option is specified, the client MUST still be able to handle cases when a CHILDINFO extended data item is returned and there are no submailboxes that meet the selection criteria of the subsequent LIST command, as they can be deleted/renamed after the LIST response was sent but before the client had a chance to access them.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.1-2.6.4)

##### [6.3.9.2.](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.2) [LIST Return Options](https://www.rfc-editor.org/info/rfc9051/#name-list-return-options)

The return options defined in this specification are as follows:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.2-1)

SUBSCRIBED

Causes the LIST command to return subscription state for all matching mailbox names. The "\\Subscribed" attribute MUST be supported and MUST be accurately computed when the SUBSCRIBED return option is specified. Furthermore, all other mailbox attributes MUST be accurately computed (this differs from the behavior of the obsolete LSUB command from \[[RFC3501](https://www.rfc-editor.org/info/rfc9051/#RFC3501)\]). Note that the above requirements don't override the requirement for the LIST command to return results quickly (see [Section 6.3.9](https://www.rfc-editor.org/info/rfc9051/#list-cmd)), i.e., server implementations need to compute results quickly and accurately. For example, server implementors might need to create quick access indices.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.2-2.2.1)

CHILDREN

Requests mailbox child information as originally proposed in \[[RFC3348](https://www.rfc-editor.org/info/rfc9051/#RFC3348)\]. See [Section 6.3.9.5](https://www.rfc-editor.org/info/rfc9051/#children), below, for details.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.2-2.4)

STATUS

Requests STATUS response for each matching mailbox.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.2-2.6.1)

This option takes STATUS data items as parameters. For each selectable mailbox matching the list pattern and selection options, the server MUST return an untagged LIST response followed by an untagged STATUS response containing the information requested in the STATUS return option, except for some cases described below.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.2-2.6.2)

If an attempted STATUS for a listed mailbox fails because the mailbox can't be selected (e.g., if the "l" Access Control List (ACL) right \[[RFC4314](https://www.rfc-editor.org/info/rfc9051/#RFC4314)\] is granted to the mailbox and the "r" right is not granted, or is due to a race condition between LIST and STATUS changing the mailbox to \\NoSelect), the STATUS response MUST NOT be returned, and the LIST response MUST include the \\NoSelect attribute. This means the server may have to buffer the LIST reply until it has successfully looked up the necessary STATUS information.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.2-2.6.3)

If the server runs into unexpected problems while trying to look up the STATUS information, it MAY drop the corresponding STATUS reply. In such a situation, the LIST command would still return a tagged OK reply.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.2-2.6.4)

See the note in the discussion of the STATUS command in [Section 6.3.11](https://www.rfc-editor.org/info/rfc9051/#status-command) for information about obtaining status on the currently selected mailbox.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.2-2.6.5)

##### [6.3.9.3.](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.3) [General Principles for Returning LIST Responses](https://www.rfc-editor.org/info/rfc9051/#name-general-principles-for-retu)

This section outlines several principles that can be used by server implementations of this document to decide whether a LIST response should be returned, as well as how many responses and what kind of information they may contain.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.3-1)

1.  At most, one LIST response should be returned for each mailbox name that matches the canonical LIST pattern. Server implementors must not assume that clients will be able to assemble mailbox attributes and other information returned in multiple LIST responses.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.3-2.1)
2.  There are only two reasons for including a matching mailbox name in the responses to the LIST command (note that the server is allowed to return unsolicited responses at any time, and such responses are not governed by this rule):[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.3-2.2.1)
    
    1.  The mailbox name also satisfies the selection criteria.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.3-2.2.2.1)
    2.  The mailbox name doesn't satisfy the selection criteria, but it has at least one descendant mailbox name that satisfies the selection criteria and that doesn't match the canonical LIST pattern.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.3-2.2.2.2.1)
        
        For more information on this case, see the CHILDINFO extended data item described in [Section 6.3.9.6](https://www.rfc-editor.org/info/rfc9051/#childinfo). Note that the CHILDINFO extended data item can only be returned when the RECURSIVEMATCH selection option is specified.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.3-2.2.2.2.2)
        
3.  Attributes returned in the same LIST response are treated additively. For example, the following response[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.3-2.3.1)
    
    means that the "Fruit/Peach" mailbox doesn't exist, but it is subscribed.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.3-2.3.3)
    

All clients MUST treat a LIST attribute with a stronger meaning as implying any attribute that can be inferred from it. (See [Section 7.3.1](https://www.rfc-editor.org/info/rfc9051/#list-resp) for the list of currently defined attributes.) For example, the client must treat the presence of the \\NoInferiors attribute as if the \\HasNoChildren attribute was also sent by the server.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.4-1)

The following table summarizes inference rules.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.4-2)

##### [6.3.9.5.](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.5) [The CHILDREN Return Option](https://www.rfc-editor.org/info/rfc9051/#name-the-children-return-option)

The CHILDREN return option is simply an indication that the client wants information about whether or not mailboxes contain child mailboxes; a server MAY provide it even if the option is not specified.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.5-1)

Many IMAP clients present the user with a hierarchical view of the mailboxes that a user has access to. Rather than initially presenting the entire mailbox hierarchy to the user, it is often preferable to show the user a collapsed outline list of the mailbox hierarchy (particularly if there is a large number of mailboxes). The user can then expand the collapsed outline hierarchy as needed. It is common to include a visual clue (such as a ''+'') within the collapsed hierarchy to indicate that there are child mailboxes under a particular mailbox. When the visual clue is clicked, the hierarchy list is expanded to show the child mailboxes. The CHILDREN return option provides a mechanism for a client to efficiently determine whether a particular mailbox has children, without issuing a LIST "" \* or a LIST "" % for each mailbox name. The CHILDREN return option defines two new attributes that MUST be returned within a LIST response: \\HasChildren and \\HasNoChildren. Although these attributes MAY be returned in response to any LIST command, the CHILDREN return option is provided to indicate that the client particularly wants this information. If the CHILDREN return option is present, the server MUST return these attributes even if their computation is expensive.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.5-2)

\\HasChildren

The presence of this attribute indicates that the mailbox has child mailboxes. A server SHOULD NOT set this attribute if there are child mailboxes and the user does not have permission to access any of them. In this case, \\HasNoChildren SHOULD be used. In many cases, however, a server may not be able to efficiently compute whether a user has access to any child mailbox. Note that even though the \\HasChildren attribute for a mailbox must be correct at the time of processing the mailbox, a client must be prepared to deal with a situation when a mailbox is marked with the \\HasChildren attribute, but no child mailbox appears in the response to the LIST command. This might happen, for example, due to child mailboxes being deleted or made inaccessible to the user (using access control) by another client before the server is able to list them.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.5-3.2)

\\HasNoChildren

The presence of this attribute indicates that the mailbox has NO child mailboxes that are accessible to the currently authenticated user.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.5-3.4)

It is an error for the server to return both a \\HasChildren and a \\HasNoChildren attribute in the same LIST response.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.5-4)

Note: the \\HasNoChildren attribute should not be confused with the \\NoInferiors attribute, which indicates that no child mailboxes exist now and none can be created in the future.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.5-5)

##### [6.3.9.6.](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.6) [CHILDINFO Extended Data Item](https://www.rfc-editor.org/info/rfc9051/#name-childinfo-extended-data-ite)

The CHILDINFO extended data item MUST NOT be returned unless the client has specified the RECURSIVEMATCH selection option.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.6-1)

The CHILDINFO extended data item in a LIST response describes the selection criteria that has caused it to be returned and indicates that the mailbox has at least one descendant mailbox that matches the selection criteria.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.6-2)

Note: Some servers allow for mailboxes to exist without requiring their parent to exist. For example, the mailbox "Customers/ABC" can exist while the mailbox "Customers" does not. As the CHILDINFO extended data item is not allowed if the RECURSIVEMATCH selection option is not specified, such servers SHOULD use the "\\NonExistent \\HasChildren" attribute pair to signal to the client that there is a descendant mailbox that matches the selection criteria. See Example 11 in [Section 6.3.9.8](https://www.rfc-editor.org/info/rfc9051/#examples).[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.6-3)

The returned selection criteria allows the client to distinguish a solicited response from an unsolicited one, as well as to distinguish among solicited responses caused by multiple pipelined LIST commands that specify different criteria.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.6-4)

Servers SHOULD only return a non-matching mailbox name along with CHILDINFO if at least one matching child is not also being returned. That is, servers SHOULD suppress redundant CHILDINFO responses.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.6-5)

Examples 8 and 10 in [Section 6.3.9.8](https://www.rfc-editor.org/info/rfc9051/#examples) demonstrate the difference between the present CHILDINFO extended data item and the "\\HasChildren" attribute.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.6-6)

The following table summarizes interaction between the "\\NonExistent" attribute and CHILDINFO (the first column indicates whether the parent mailbox exists):[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.6-7)

where <attr> is one or more attributes that correspond to the selection criteria; for example, for the SUBSCRIBED option, the <attr> is \\Subscribed.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.6-9)

##### [6.3.9.7.](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.7) [OLDNAME Extended Data Item](https://www.rfc-editor.org/info/rfc9051/#name-oldname-extended-data-item)

The OLDNAME extended data item is included when a mailbox name is created (with the CREATE command), renamed (with the RENAME command), or deleted (with the DELETE command). (When a mailbox is deleted, the "\\NonExistent" attribute is also included.) IMAP extensions can specify other conditions when the OLDNAME extended data item should be included.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.7-1)

If the server allows denormalized mailbox names (see [Section 5.1](https://www.rfc-editor.org/info/rfc9051/#mailbox-naming)) in SELECT/EXAMINE, CREATE, RENAME, or DELETE, it SHOULD return an unsolicited LIST response that includes the OLDNAME extended data item, whenever the supplied mailbox name differs from the resulting normalized mailbox name. From the client point of view, this is indistinguishable from another user renaming or deleting the mailbox, as specified in the previous paragraph.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.7-2)

A deleted mailbox can be announced as follows:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.7-3)

Example of a renamed mailbox:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.7-5)

##### [6.3.9.8.](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8) [LIST Command Examples](https://www.rfc-editor.org/info/rfc9051/#name-list-command-examples)

This example shows some uses of the basic LIST command:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-1)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-2)

Extended examples:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-4)

1:

The first example shows the complete local hierarchy that will be used for the other examples.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.1.1)

2:

In the next example, we will see the subscribed mailboxes. This is similar to, but not equivalent with, the now deprecated <LSUB "" "\*"> (see \[[RFC3501](https://www.rfc-editor.org/info/rfc9051/#RFC3501)\] for more details on the LSUB command). Note that the mailbox called "Fruit/Peach" is subscribed to, but it does not actually exist (perhaps it was deleted while still subscribed). The "Fruit" mailbox is not subscribed to, but it has two subscribed children. The "Vegetable" mailbox is subscribed and has two children; one of them is subscribed as well.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.2.1)

3:

The next example shows the use of the CHILDREN option. The client, without having to list the second level of hierarchy, now knows which of the top-level mailboxes have submailboxes (children) and which do not. Note that it's not necessary for the server to return the \\HasNoChildren attribute for the inbox, because the \\NoInferiors attribute already implies that and has a stronger meaning.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.3.1)

4:

In this example, we see more mailboxes that reside on another server. This is similar to the command <RLIST "" "%">.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.4.1)

5:

The following example also requests the server to include mailboxes that reside on another server. The server returns information about all mailboxes that are subscribed. This is similar to the command <RLSUB "" "\*"> (see \[[RFC2193](https://www.rfc-editor.org/info/rfc9051/#RFC2193)\] for more details on RLSUB). We also see the use of two selection options.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.5.1)

6:

The following example requests the server to include mailboxes that reside on another server. The server is asked to return subscription information for all returned mailboxes. This is different from the example above.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.6.1)

Note that the output of this command is not a superset of the output in the previous example, as it doesn't include a LIST response for the non-existent "Fruit/Peach".[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.6.2)

7:

The following example demonstrates the difference between the \\HasChildren attribute and the CHILDINFO extended data item.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.7.1)

Let's assume there is the following hierarchy:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.7.2)

If the client asks RETURN (CHILDREN), it will get this:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.7.4)

A)

Let's also assume that the mailbox "Foo/Baz" is the only subscribed mailbox. Then we get this result:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.7.6.1.1)

Now, if the client issues <LIST (SUBSCRIBED) "" "%">, the server will return no mailboxes (as the mailboxes "Moo", "Foo", and "Inbox" are NOT subscribed). However, if the client issues this:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.7.6.1.3)

(that is, the mailbox "Foo" is not subscribed, but it has a child that is), then A1 or A2 occurs.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.7.6.1.5)

A1)

If the mailbox "Foo" had also been subscribed, the last command would return this:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.7.6.1.6.1.1)

or even this:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.7.6.1.6.1.3)

A2)

If we assume instead that the mailbox "Foo" is not part of the original hierarchy and is not subscribed, the last command will give this result:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.7.6.1.6.2.1)

B)

Now, let's assume that no mailbox is subscribed. In this case, the command <LIST (SUBSCRIBED RECURSIVEMATCH) "" "%"> will return no responses, as there are no subscribed children (even though "Foo" has children).[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.7.6.2.1)

C)

And finally, suppose that only the mailboxes "Foo" and "Moo" are subscribed. In that case, we see this result:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.7.6.3.1)

(which means that the mailbox "Foo" has children, but none of them is subscribed).[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.7.6.3.3)

8:

The following example demonstrates that the CHILDINFO extended data item is returned whether or not child mailboxes match the canonical LIST pattern.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.8.1)

Let's assume there is the following hierarchy:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.8.2)

And that the following mailboxes are subscribed:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.8.4)

The client issues the following command first:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.8.6)

and the server may also include the following (but this would violate a restriction in [Section 6.3.9.6](https://www.rfc-editor.org/info/rfc9051/#childinfo), because CHILDINFO is redundant):[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.8.8)

The CHILDINFO extended data item is returned for mailboxes "foo2", "baz2", and "eps2" because all of them have subscribed children, even though for the mailbox "foo2", only one of the two subscribed children matches the pattern; for the mailbox "baz2", all of the subscribed children match the pattern; and for the mailbox "eps2", none of the subscribed children match the pattern.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.8.10)

Note that if the client issues the following:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.8.11)

the LIST responses for mailboxes "foo2", "baz2", and "eps2" still have the CHILDINFO extended data item, even though this information is redundant and the client can determine it by itself.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.8.13)

9:

The following example shows usage of an extended syntax for the mailbox pattern. It also demonstrates that the presence of the CHILDINFO extended data item doesn't necessarily imply \\HasChildren.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.9.1)

10:

The following example shows how a server that supports missing mailbox hierarchy elements can signal to a client that didn't specify the RECURSIVEMATCH selection option that there is a child mailbox that matches the selection criteria.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.10.1)

Because "music/rock" is the only mailbox under "music", there's no need for the server to also return "music". However, clients must handle both cases.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.10.3)

11:

The following examples show use of the STATUS return option.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.11.1)

The "bar" mailbox isn't selectable, so it has no STATUS reply.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.11.3)

The LIST reply for "foo" is returned because it has matching children, but no STATUS reply is returned because "foo" itself doesn't match the selection criteria.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.9.8-5.11.5)

#### [6.3.10.](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10) [NAMESPACE Command](https://www.rfc-editor.org/info/rfc9051/#name-namespace-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.3.10)

Arguments:

none[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-1.2)

Responses:

REQUIRED untagged responses:

NAMESPACE[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-1.4.1.2)

Result:

OK -

command completed[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-1.6.1.2)

NO -

Can't complete the command[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-1.6.1.4)

BAD -

arguments invalid[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-1.6.1.6)

The NAMESPACE command causes a single untagged NAMESPACE response to be returned. The untagged NAMESPACE response contains the prefix and hierarchy delimiter to the server's Personal Namespace(s), Other Users' Namespace(s), and Shared Namespace(s) that the server wishes to expose. The response will contain a NIL for any namespace class that is not available. The namespace-response-extensions ABNF non-terminal is defined for extensibility and MAY be included in the NAMESPACE response.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-2)

Example 1:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-3)

In this example, a server supports a single Personal Namespace. No leading prefix is used on personal mailboxes, and "/" is the hierarchy delimiter.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-4)

Example 2:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-6)

A user logged on anonymously to a server. No personal mailboxes are associated with the anonymous user, and the user does not have access to the Other Users' Namespace. No prefix is required to access shared mailboxes, and the hierarchy delimiter is "."[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-7)

Example 3:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-9)

A server that contains a Personal Namespace and a single Shared Namespace.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-10)

Example 4:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-12)

A server that contains a Personal Namespace, Other Users' Namespace, and multiple Shared Namespaces. Note that the hierarchy delimiter used within each namespace can be different.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-13)

The prefix string allows a client to do things such as automatically create personal mailboxes or LIST all available mailboxes within a namespace.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-15)

Example 5:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-16)

A server that supports only the Personal Namespace, with a leading prefix of INBOX to personal mailboxes and a hierarchy delimiter of ".".[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-17)

Automatically create a mailbox to store sent items.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-19)

Although a server will typically support only a single Personal Namespace, and a single Other User's Namespace, circumstances exist where there MAY be multiples of these, and a client MUST be prepared for them. If a client is configured such that it is required to create a certain mailbox, there can be circumstances where it is unclear which Personal Namespaces it should create the mailbox in. In these situations, a client SHOULD let the user select which namespaces to create the mailbox in, or just use the first Personal Namespace.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-21)

Example 6:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-22)

In this example, a server supports two Personal Namespaces. In addition to the regular Personal Namespace, the user has an additional Personal Namespace that allows access to mailboxes in an MH format mailstore.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-23)

The client is configured to save a copy of all mail sent by the user into a mailbox with the \\Sent attribute (see [Section 7.3.1](https://www.rfc-editor.org/info/rfc9051/#list-resp)). Furthermore, after a message is deleted from a mailbox, the client is configured to move that message to a mailbox with the \\Trash attribute. The server signals with the \\NonExistent mailbox attribute that the corresponding mailboxes don't exist yet and that it is possible to create them. Once created, they could be used for \\Sent or \\Trash purposes, and the server will no longer include the \\NonExistent mailbox attribute for them.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-24)

Note that this example demonstrates how some extension parameters can be passed to further describe the #mh namespace. See the fictitious "X-PARAM" extension parameter.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-25)

It is desired to keep only one copy of sent mail. It is unclear which Personal Namespace the client should use to create the 'Sent Mail' mailbox. The user is prompted to select a namespace, and only one 'Sent Mail' mailbox is created.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-27)

The client is designed so that it keeps two 'Deleted Items' mailboxes, one for each namespace.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-29)

The next level of hierarchy following the Other Users' Namespace prefix SHOULD consist of <username>, where <username> is a user name as per the LOGIN or AUTHENTICATE command.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-31)

A client can construct a LIST command by appending a "%" to the Other Users' Namespace prefix to discover the Personal Namespaces of other users that are available to the currently authenticated user.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-32)

In response to such a LIST command, a server SHOULD NOT return user names that have not granted access to their personal mailboxes to the user in question.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-33)

A server MAY return a LIST response containing only the names of users that have explicitly granted access to the user in question.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-34)

Alternatively, a server MAY return NO to such a LIST command, requiring that a user name be included with the Other Users' Namespace prefix before listing any other user's mailboxes.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-35)

Example 7:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-36)

A server that supports providing a list of other user's mailboxes that are accessible to the currently logged on user.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-37)

Example 8:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-39)

A server that does not support providing a list of other user's mailboxes that are accessible to the currently logged on user. The mailboxes are listable if the client includes the name of the other user with the Other Users' Namespace prefix.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-40)

In this example, the currently logged on user has access to the Personal Namespace of user Mike, but the server chose to suppress this information in the LIST response. However, by appending the user name Mike (received through user input) to the Other Users' Namespace prefix, the client is able to get a listing of the personal mailboxes of user Mike.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-42)

A prefix string might not contain a hierarchy delimiter, because in some cases, it is not needed as part of the prefix.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-44)

Example 9:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-45)

A server that allows access to the Other Users' Namespace by prefixing the others' mailboxes with a '~' followed by <username>, where <username> is a user name as per the LOGIN or AUTHENTICATE command.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-46)

List the mailboxes for user mark[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10-48)

#### [6.3.11.](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11) [STATUS Command](https://www.rfc-editor.org/info/rfc9051/#name-status-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.3.11)

Arguments:

mailbox name[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11-1.2.1)

status data item names[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11-1.2.2)

Responses:

REQUIRED untagged responses:

STATUS[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11-1.4.1.2)

Result:

OK -

status completed[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11-1.6.1.2)

NO -

status failure: no status for that name[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11-1.6.1.4)

BAD -

command unknown or arguments invalid[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11-1.6.1.6)

The STATUS command requests the status of the indicated mailbox. It does not change the currently selected mailbox, nor does it affect the state of any messages in the queried mailbox.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11-2)

The STATUS command provides an alternative to opening a second IMAP4rev2 connection and doing an EXAMINE command on a mailbox to query that mailbox's status without deselecting the current mailbox in the first IMAP4rev2 connection.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11-3)

Unlike the LIST command, the STATUS command is not guaranteed to be fast in its response. Under certain circumstances, it can be quite slow. In some implementations, the server is obliged to open the mailbox as "read-only" internally to obtain certain status information. Also unlike the LIST command, the STATUS command does not accept wildcards.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11-4)

Note: The STATUS command is intended to access the status of mailboxes other than the currently selected mailbox. Because the STATUS command can cause the mailbox to be opened internally, and because this information is available by other means on the selected mailbox, the STATUS command SHOULD NOT be used on the currently selected mailbox. However, servers MUST be able to execute the STATUS command on the selected mailbox. (This might also implicitly happen when the STATUS return option is used in a LIST command.)[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11-5)

The STATUS command MUST NOT be used as a "check for new messages in the selected mailbox" operation (refer to Sections [7](https://www.rfc-editor.org/info/rfc9051/#server-responses) and [7.4.1](https://www.rfc-editor.org/info/rfc9051/#exists) for more information about the proper method for new message checking).[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11-6)

STATUS SIZE (see below) can take a significant amount of time, depending upon server implementation. Clients should use STATUS SIZE cautiously.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11-7)

The currently defined status data items that can be requested are:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11-8)

MESSAGES

The number of messages in the mailbox.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11-9.2)

UIDNEXT

The next unique identifier value of the mailbox. Refer to [Section 2.3.1.1](https://www.rfc-editor.org/info/rfc9051/#uid-def) for more information.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11-9.4)

UIDVALIDITY

The unique identifier validity value of the mailbox. Refer to [Section 2.3.1.1](https://www.rfc-editor.org/info/rfc9051/#uid-def) for more information.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11-9.6)

UNSEEN

The number of messages that do not have the \\Seen flag set.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11-9.8)

DELETED

The number of messages that have the \\Deleted flag set.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11-9.10)

SIZE

The total size of the mailbox in octets. This is not strictly required to be an exact value, but it MUST be equal to or greater than the sum of the values of the RFC822.SIZE FETCH message data items (see [Section 6.4.5](https://www.rfc-editor.org/info/rfc9051/#fetch-command)) of all messages in the mailbox.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11-9.12)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11-10)

#### [6.3.12.](https://www.rfc-editor.org/info/rfc9051/#section-6.3.12) [APPEND Command](https://www.rfc-editor.org/info/rfc9051/#name-append-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.3.12)

Arguments:

mailbox name[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.12-1.2.1)

OPTIONAL flag parenthesized list[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.12-1.2.2)

OPTIONAL date/time string[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.12-1.2.3)

message literal[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.12-1.2.4)

Responses:

OPTIONAL untagged response:

LIST[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.12-1.4.1.2)

Result:

OK -

append completed[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.12-1.6.1.2)

NO -

append error: can't append to that mailbox, error in flags or date/time or message text[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.12-1.6.1.4)

BAD -

command unknown or arguments invalid[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.12-1.6.1.6)

The APPEND command appends the literal argument as a new message to the end of the specified destination mailbox. This argument SHOULD be in the format of an \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] or \[[I18N-HDRS](https://www.rfc-editor.org/info/rfc9051/#RFC6532)\] message. 8-bit characters are permitted in the message. A server implementation that is unable to preserve 8-bit data properly MUST be able to reversibly convert 8-bit APPEND data to 7 bits using a \[[MIME-IMB](https://www.rfc-editor.org/info/rfc9051/#RFC2045)\] content transfer encoding.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.12-2)

Note: There may be exceptions, such as draft messages, in which required \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] header fields are omitted in the message literal argument to APPEND. The full implications of doing so must be understood and carefully weighed.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.12-3)

If a flag parenthesized list is specified, the flags SHOULD be set in the resulting message; otherwise, the flag list of the resulting message is set to "empty" by default.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.12-4)

If a date-time is specified, the internal date SHOULD be set in the resulting message; otherwise, the internal date of the resulting message is set to the current date and time by default.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.12-5)

If the append is unsuccessful for any reason, the mailbox MUST be restored to its state before the APPEND attempt (other than possibly keeping the changed mailbox's UIDNEXT value); no partial appending is permitted.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.12-6)

If the destination mailbox does not exist, a server MUST return an error and MUST NOT automatically create the mailbox. Unless it is certain that the destination mailbox cannot be created, the server MUST send the response code "\[TRYCREATE\]" as the prefix of the text of the tagged NO response. This gives a hint to the client that it can attempt a CREATE command and retry the APPEND if the CREATE is successful.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.12-7)

On successful completion of an APPEND, the server returns an APPENDUID response code (see [Section 7.1](https://www.rfc-editor.org/info/rfc9051/#server-status-responses)), unless otherwise specified below.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.12-8)

In the case of a mailbox that has permissions set so that the client can APPEND to the mailbox, but not SELECT or EXAMINE it, the server MUST NOT send an APPENDUID response code as it would disclose information about the mailbox.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.12-9)

In the case of a mailbox that has UIDNOTSTICKY status (see [Section 7.1](https://www.rfc-editor.org/info/rfc9051/#server-status-responses)), the server MAY omit the APPENDUID response code as it is not meaningful.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.12-10)

If the mailbox is currently selected, normal new message actions SHOULD occur. Specifically, the server SHOULD notify the client immediately via an untagged EXISTS response. If the server does not do so, the client MAY issue a NOOP command after one or more APPEND commands.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.12-11)

If the server decides to convert (normalize) the mailbox name, it SHOULD return an untagged LIST with an OLDNAME extended data item, with the OLDNAME value being the supplied mailbox name and the name parameter being the normalized mailbox name. (See [Section 6.3.9.7](https://www.rfc-editor.org/info/rfc9051/#oldname) for more details.)[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.12-12)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.12-13)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.12-15)

In this example, A003 and A004 demonstrate successful appending and copying to a mailbox that returns the UIDs assigned to the messages. A005 is an example in which no messages were copied; this is because in A003, we see that message 2 had UID 304, and message 3 had UID 319; therefore, UIDs 305 through 310 do not exist (refer to [Section 2.3.1.1](https://www.rfc-editor.org/info/rfc9051/#uid-def) for further explanation). A006 is an example of a message being copied that did not return a COPYUID; and, as expected, A007 shows that the mail store containing that mailbox does not support persistent UIDs.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.12-17)

#### [6.3.13.](https://www.rfc-editor.org/info/rfc9051/#section-6.3.13) [IDLE Command](https://www.rfc-editor.org/info/rfc9051/#name-idle-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.3.13)

Arguments:

none[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.13-1.2)

Responses:

continuation data will be requested; the client sends the continuation data "DONE" to end the command[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.13-1.4)

Result:

OK -

IDLE completed after client sent "DONE"[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.13-1.6.1.2)

NO -

failure: the server will not allow the IDLE command at this time[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.13-1.6.1.4)

BAD -

command unknown or arguments invalid[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.13-1.6.1.6)

Without the IDLE command, a client would need to poll the server for changes to the selected mailbox (new mail, deletions, and flag changes). It's often more desirable to have the server transmit updates to the client in real time. This allows a user to see new mail immediately. The IDLE command allows a client to tell the server that it's ready to accept such real-time updates.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.13-2)

The IDLE command is sent from the client to the server when the client is ready to accept unsolicited update messages. The server requests a response to the IDLE command using the continuation ("+") response. The IDLE command remains active until the client responds to the continuation, and as long as an IDLE command is active, the server is now free to send untagged EXISTS, EXPUNGE, FETCH, and other responses at any time. If the server chooses to send unsolicited FETCH responses, they MUST include a UID FETCH item.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.13-3)

The IDLE command is terminated by the receipt of a "DONE" continuation from the client; such response satisfies the server's continuation request. At that point, the server MAY send any remaining queued untagged responses and then MUST immediately send the tagged response to the IDLE command and prepare to process other commands. As for other commands, the processing of any new command may cause the sending of unsolicited untagged responses, subject to the ambiguity limitations. The client MUST NOT send a command while the server is waiting for the DONE, since the server will not be able to distinguish a command from a continuation.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.13-4)

The server MAY consider a client inactive if it has an IDLE command running, and if such a server has an inactivity timeout, it MAY log the client off implicitly at the end of its timeout period. Because of that, clients using IDLE are advised to terminate IDLE and reissue it at least every 29 minutes to avoid being logged off. This still allows a client to receive immediate mailbox updates even though it need only "poll" at half hour intervals.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.13-5)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.3.13-6)

### [6.4.](https://www.rfc-editor.org/info/rfc9051/#section-6.4) [Client Commands - Selected State](https://www.rfc-editor.org/info/rfc9051/#name-client-commands-selected-st) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.4)

In the selected state, commands that manipulate messages in a mailbox are permitted.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4-1)

In addition to the universal commands (CAPABILITY, NOOP, and LOGOUT), and the authenticated state commands (SELECT, EXAMINE, NAMESPACE, CREATE, DELETE, RENAME, SUBSCRIBE, UNSUBSCRIBE, LIST, STATUS, and APPEND), the following commands are valid in the selected state: CLOSE, UNSELECT, EXPUNGE, SEARCH, FETCH, STORE, COPY, MOVE, and UID.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4-2)

#### [6.4.1.](https://www.rfc-editor.org/info/rfc9051/#section-6.4.1) [CLOSE Command](https://www.rfc-editor.org/info/rfc9051/#name-close-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.4.1)

Arguments:

none[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.1-1.2)

Responses:

no specific responses for this command[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.1-1.4)

Result:

OK -

close completed, now in authenticated state[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.1-1.6.1.2)

BAD -

command unknown or arguments invalid[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.1-1.6.1.4)

The CLOSE command permanently removes all messages that have the \\Deleted flag set from the currently selected mailbox, and it returns to the authenticated state from the selected state. No untagged EXPUNGE responses are sent.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.1-2)

No messages are removed, and no error is given, if the mailbox is selected by an EXAMINE command or is otherwise selected as read-only.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.1-3)

Even if a mailbox is selected, a SELECT, EXAMINE, or LOGOUT command MAY be issued without previously issuing a CLOSE command. The SELECT, EXAMINE, and LOGOUT commands implicitly close the currently selected mailbox without doing an expunge. However, when many messages are deleted, a CLOSE-LOGOUT or CLOSE-SELECT sequence is considerably faster than an EXPUNGE-LOGOUT or EXPUNGE-SELECT because no untagged EXPUNGE responses (which the client would probably ignore) are sent.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.1-4)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.1-5)

#### [6.4.2.](https://www.rfc-editor.org/info/rfc9051/#section-6.4.2) [UNSELECT Command](https://www.rfc-editor.org/info/rfc9051/#name-unselect-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.4.2)

Arguments:

none[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.2-1.2)

Responses:

no specific responses for this command[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.2-1.4)

Result:

OK -

unselect completed, now in authenticated state[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.2-1.6.1.2)

BAD -

no mailbox selected, or argument supplied but none permitted[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.2-1.6.1.4)

The UNSELECT command frees a session's resources associated with the selected mailbox and returns the server to the authenticated state. This command performs the same actions as CLOSE, except that no messages are permanently removed from the currently selected mailbox.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.2-2)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.2-3)

#### [6.4.3.](https://www.rfc-editor.org/info/rfc9051/#section-6.4.3) [EXPUNGE Command](https://www.rfc-editor.org/info/rfc9051/#name-expunge-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.4.3)

Arguments:

none[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.3-1.2)

Responses:

untagged responses:

EXPUNGE[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.3-1.4.1.2)

Result:

OK -

expunge completed[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.3-1.6.1.2)

NO -

expunge failure: can't expunge (e.g., permission denied)[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.3-1.6.1.4)

BAD -

command unknown or arguments invalid[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.3-1.6.1.6)

The EXPUNGE command permanently removes all messages that have the \\Deleted flag set from the currently selected mailbox. Before returning an OK to the client, an untagged EXPUNGE response is sent for each message that is removed.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.3-2)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.3-3)

Note: In this example, messages 3, 4, 7, and 11 had the \\Deleted flag set. See the description of the EXPUNGE response ([Section 7.5.1](https://www.rfc-editor.org/info/rfc9051/#expunge-response)) for further explanation.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.3-5)

#### [6.4.4.](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4) [SEARCH Command](https://www.rfc-editor.org/info/rfc9051/#name-search-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.4.4)

Arguments:

OPTIONAL result specifier[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-1.2.1)

OPTIONAL \[[CHARSET](https://www.rfc-editor.org/info/rfc9051/#RFC2978)\] specification[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-1.2.2)

searching criteria (one or more)[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-1.2.3)

Responses:

OPTIONAL untagged response:

ESEARCH[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-1.4.1.2)

Result:

OK -

search completed[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-1.6.1.2)

NO -

search error: can't search that \[[CHARSET](https://www.rfc-editor.org/info/rfc9051/#RFC2978)\] or criteria[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-1.6.1.4)

BAD -

command unknown or arguments invalid[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-1.6.1.6)

The SEARCH command searches the mailbox for messages that match the given searching criteria.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-2)

The SEARCH command may contain result options. Result options control what kind of information is returned about messages matching the search criteria in an untagged ESEARCH response. If no result option is specified or empty list of options is specified as "()", ALL is assumed (see below). The order of individual options is arbitrary. Individual options may contain parameters enclosed in parentheses. (However, if an option has a mandatory parameter, which can always be represented as a number or a sequence-set, the option parameter does not need the enclosing parentheses. See "Formal Syntax" ([Section 9](https://www.rfc-editor.org/info/rfc9051/#IMAP-ABNF)) for more details.) If an option has parameters, they consist of atoms and/or strings and/or lists in a specific order. Any options not defined by extensions that the server supports MUST be rejected with a BAD response.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-3)

Note that IMAP4rev1 used SEARCH responses \[[RFC3501](https://www.rfc-editor.org/info/rfc9051/#RFC3501)\] instead of ESEARCH responses. Clients that support only IMAP4rev2 MUST ignore SEARCH responses.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-4)

This document specifies the following result options:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-5)

MIN

Return the lowest message number/UID that satisfies the SEARCH criteria.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-6.2.1)

If the SEARCH results in no matches, the server MUST NOT include the MIN result option in the ESEARCH response; however, it still MUST send the ESEARCH response.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-6.2.2)

MAX

Return the highest message number/UID that satisfies the SEARCH criteria.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-6.4.1)

If the SEARCH results in no matches, the server MUST NOT include the MAX result option in the ESEARCH response; however, it still MUST send the ESEARCH response.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-6.4.2)

ALL

Return all message numbers/UIDs that satisfy the SEARCH criteria using the sequence-set syntax. Note that the client MUST NOT assume that messages/UIDs will be listed in any particular order.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-6.6.1)

If the SEARCH results in no matches, the server MUST NOT include the ALL result option in the ESEARCH response; however, it still MUST send the ESEARCH response.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-6.6.2)

COUNT

Return the number of messages that satisfy the SEARCH criteria. This result option MUST always be included in the ESEARCH response.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-6.8)

SAVE

This option tells the server to remember the result of the SEARCH or UID SEARCH command (as well as any command based on SEARCH, e.g., SORT and THREAD \[[RFC5256](https://www.rfc-editor.org/info/rfc9051/#RFC5256)\]) and store it in an internal variable that we will reference as the "search result variable". The client can use the "$" marker to reference the content of this internal variable. The "$" marker can be used instead of message sequence or UID sequence in order to indicate that the server should substitute it with the list of messages from the search result variable. Thus, the client can use the result of the latest remembered SEARCH command as a parameter to another command. See [Section 6.4.4.1](https://www.rfc-editor.org/info/rfc9051/#search-save) for details on how the value of the search result variable is determined, how it is affected by other commands executed, and how the SAVE return option interacts with other return options.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-6.10.1)

In absence of any other SEARCH result option, the SAVE result option also suppresses any ESEARCH response that would have been otherwise returned by the SEARCH command.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-6.10.2)

Note: future extensions to this document can allow servers to return multiple ESEARCH responses for a single extended SEARCH command. However, all options specified above MUST result in a single ESEARCH response if used by themselves or in combination. This guarantee simplifies processing in IMAP4rev2 clients. Future SEARCH extensions that relax this restriction will have to describe how results from multiple ESEARCH responses are to be combined.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-7)

Searching criteria consist of one or more search keys.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-8)

When multiple keys are specified, the result is the intersection (AND function) of all the messages that match those keys. For example, the criteria DELETED FROM "SMITH" SINCE 1-Feb-1994 refers to all deleted messages from Smith with INTERNALDATE greater than February 1, 1994. A search key can also be a parenthesized list of one or more search keys (e.g., for use with the OR and NOT keys).[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-9)

Server implementations MAY exclude \[[MIME-IMB](https://www.rfc-editor.org/info/rfc9051/#RFC2045)\] body parts with terminal content media types other than TEXT and MESSAGE from consideration in SEARCH matching.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-10)

The OPTIONAL \[[CHARSET](https://www.rfc-editor.org/info/rfc9051/#RFC2978)\] specification consists of the word "CHARSET" followed by the name of a character set from the registry \[[CHARSET-REG](https://www.rfc-editor.org/info/rfc9051/#CHARSET-REG)\]. It indicates the \[[CHARSET](https://www.rfc-editor.org/info/rfc9051/#RFC2978)\] of the strings that appear in the search criteria. \[[MIME-IMB](https://www.rfc-editor.org/info/rfc9051/#RFC2045)\] content transfer encodings and \[[MIME-HDRS](https://www.rfc-editor.org/info/rfc9051/#RFC2047)\] strings in \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\]/\[[MIME-IMB](https://www.rfc-editor.org/info/rfc9051/#RFC2045)\] headers MUST be decoded before comparing text. Servers MUST support US-ASCII and UTF-8 charsets; other CHARSETs MAY be supported. Clients SHOULD use UTF-8. Note that if CHARSET is not provided, IMAP4rev2 servers MUST assume UTF-8, so selecting CHARSET UTF-8 is redundant. It is permitted for improved compatibility with existing IMAP4rev1 clients.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-11)

If the server does not support the specified \[[CHARSET](https://www.rfc-editor.org/info/rfc9051/#RFC2978)\], it MUST return a tagged NO response (not a BAD). This response SHOULD contain the BADCHARSET response code, which MAY list the CHARSETs supported by the server.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-12)

In all search keys that use strings, and unless otherwise specified, a message matches the key if the string is a substring of the associated text. The matching SHOULD be case insensitive for characters within the ASCII range. Consider using \[[IMAP-I18N](https://www.rfc-editor.org/info/rfc9051/#RFC5255)\] for language-sensitive, case-insensitive searching. Note that the empty string is a substring; this is useful when performing a HEADER search in order to test for a header field presence in the message.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-13)

The defined search keys are as follows. Refer to "Formal Syntax" ([Section 9](https://www.rfc-editor.org/info/rfc9051/#IMAP-ABNF)) for the precise syntactic definitions of the arguments.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-14)

<sequence set>

Messages with message sequence numbers corresponding to the specified message sequence number set.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.2)

ALL

All messages in the mailbox; the default initial key for ANDing.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.4)

ANSWERED

Messages with the \\Answered flag set.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.6)

BCC <string>

Messages that contain the specified string in the envelope structure's Blind Carbon Copy (BCC) field.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.8)

BEFORE <date>

Messages whose internal date (disregarding time and timezone) is earlier than the specified date.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.10)

BODY <string>

Messages that contain the specified string in the body of the message. Unlike TEXT (see below), this doesn't match any header fields. Servers are allowed to implement flexible matching for this search key, for example, by matching "swim" to both "swam" and "swum" in English language text or only performing full word matching (where "swim" will not match "swimming").[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.12)

CC <string>

Messages that contain the specified string in the envelope structure's CC field.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.14)

DELETED

Messages with the \\Deleted flag set.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.16)

DRAFT

Messages with the \\Draft flag set.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.18)

FLAGGED

Messages with the \\Flagged flag set.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.20)

FROM <string>

Messages that contain the specified string in the envelope structure's FROM field.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.22)

HEADER <field-name> <string>

Messages that have a header field with the specified field-name (as defined in \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\]) and that contain the specified string in the text of the header field (what comes after the colon). If the string to search is zero-length, this matches all messages that have a header field with the specified field-name regardless of the contents. Servers should use a substring search for this SEARCH item, as clients can use it for automatic processing not initiated by end users. For example, this can be used when searching for Message-ID or Content-Type header field values that need to be exact or for searches in header fields that the IMAP server might not know anything about.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.24)

KEYWORD <flag>

Messages with the specified keyword flag set.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.26)

LARGER <n>

Messages with an RFC822.SIZE larger than the specified number of octets.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.28)

NOT <search-key>

Messages that do not match the specified search key.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.30)

ON <date>

Messages whose internal date (disregarding time and timezone) is within the specified date.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.32)

OR <search-key1> <search-key2>

Messages that match either search key.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.34)

SEEN

Messages that have the \\Seen flag set.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.36)

SENTBEFORE <date>

Messages whose \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] Date: header field (disregarding time and timezone) is earlier than the specified date.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.38)

SENTON <date>

Messages whose \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] Date: header field (disregarding time and timezone) is within the specified date.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.40)

SENTSINCE <date>

Messages whose \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] Date: header field (disregarding time and timezone) is within or later than the specified date.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.42)

SINCE <date>

Messages whose internal date (disregarding time and timezone) is within or later than the specified date.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.44)

SMALLER <n>

Messages with an RFC822.SIZE smaller than the specified number of octets.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.46)

SUBJECT <string>

Messages that contain the specified string in the envelope structure's SUBJECT field.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.48)

TEXT <string>

Messages that contain the specified string in the header (including MIME header fields) or body of the message. Servers are allowed to implement flexible matching for this search key, for example, matching "swim" to both "swam" and "swum" in English language text or only performing full-word matching (where "swim" will not match "swimming").[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.50)

TO <string>

Messages that contain the specified string in the envelope structure's TO field.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.52)

UID <sequence set>

Messages with unique identifiers corresponding to the specified unique identifier set. Sequence-set ranges are permitted.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.54)

UNANSWERED

Messages that do not have the \\Answered flag set.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.56)

UNDELETED

Messages that do not have the \\Deleted flag set.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.58)

UNDRAFT

Messages that do not have the \\Draft flag set.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.60)

UNFLAGGED

Messages that do not have the \\Flagged flag set.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.62)

UNKEYWORD <flag>

Messages that do not have the specified keyword flag set.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.64)

UNSEEN

Messages that do not have the \\Seen flag set.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.66)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-16)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-18)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-20)

The following example demonstrates finding the first unseen message in the mailbox:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-23)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-24)

The following example demonstrates that if the ESEARCH UID indicator is present, all data in the ESEARCH response is referring to UIDs; for example, the MIN result specifier will be followed by a UID.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-26)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-27)

The following example demonstrates returning the number of deleted messages:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-29)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-30)

##### [6.4.4.1.](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.1) [SAVE Result Option and SEARCH Result Variable](https://www.rfc-editor.org/info/rfc9051/#name-save-result-option-and-sear)

Upon successful completion of a SELECT or an EXAMINE command (after the tagged OK response), the current search result variable is reset to the empty sequence.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.1-1)

A successful SEARCH command with the SAVE result option sets the value of the search result variable to the list of messages found in the SEARCH command. For example, if no messages were found, the search result variable will contain the empty sequence.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.1-2)

Any of the following SEARCH commands MUST NOT change the search result variable:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.1-3)

-   a SEARCH command that caused the server to return the BAD tagged response,[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.1-4.1)
-   a SEARCH command with no SAVE result option that caused the server to return NO tagged response, and[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.1-4.2)
-   a successful SEARCH command with no SAVE result option.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.1-4.3)

A SEARCH command with the SAVE result option that caused the server to return the NO tagged response sets the value of the search result variable to the empty sequence.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.1-5)

When a message listed in the search result variable is EXPUNGEd, it is automatically removed from the list. Implementors are reminded that if the server stores the list as a list of message numbers, it MUST automatically adjust them when notifying the client about expunged messages, as described in [Section 7.5.1](https://www.rfc-editor.org/info/rfc9051/#expunge-response).[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.1-6)

If the server decides to send a new UIDVALIDITY value while the mailbox is opened, it causes the resetting of the search variable to the empty sequence.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.1-7)

Note that even if the "$" marker contains the empty sequence of messages, it must be treated by all commands accepting message sets as parameters as a valid, but non-matching, list of messages. For example, the "FETCH $" command would return a tagged OK response and no FETCH responses. See also Example 5 in [Section 6.4.4.4](https://www.rfc-editor.org/info/rfc9051/#search-save-examples).[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.1-8)

The SAVE result option doesn't change whether the server would return items corresponding to MIN, MAX, ALL, or COUNT result options.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.1-9)

When the SAVE result option is combined with the MIN or MAX result option, and both ALL and COUNT result options are absent, the corresponding MIN/MAX is returned (if the search result is not empty), but the "$" marker would contain a single message as returned in the MIN/MAX return item.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.1-10)

If the SAVE result option is combined with both MIN and MAX result options, and both ALL and COUNT result options are absent, the "$" marker would contain zero messages, one message, or two messages as returned in the MIN/MAX return items.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.1-11)

If the SAVE result option is combined with the ALL and/or COUNT result option(s), the "$" marker would always contain all messages found by the SEARCH or UID SEARCH command.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.1-12)

The following table summarizes the additional requirement on ESEARCH server implementations described in this section.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.1-13)

where '\*' means "ALL" and/or "COUNT", and '\[m\]' means optional "MIN" and/or "MAX"[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.1-15)

Implementation note: server implementors should note that "$" can reference IMAP message sequences or UID sequences, depending on the context where it is used. For example, the "$" marker can be set as a result of a SEARCH (SAVE) command and used as a parameter to a UID FETCH command (which accepts a UID sequence, not a message sequence), or the "$" marker can be set as a result of a UID SEARCH (SAVE) command and used as a parameter to a FETCH command (which accepts a message sequence, not a UID sequence). Server implementations need to automatically map the "$" marker value to message numbers or UIDs, depending on the context where the "$" marker is used.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.1-16)

##### [6.4.4.2.](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.2) [Multiple Commands in Progress](https://www.rfc-editor.org/info/rfc9051/#name-multiple-commands-in-progres)

Use of a SEARCH RETURN (SAVE) command followed by a command using the "$" marker creates direct dependency between the two commands. As directed by [Section 5.5](https://www.rfc-editor.org/info/rfc9051/#pipelining), a server MUST execute the two commands in the order they were received.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.2-1)

A client MAY pipeline a SEARCH RETURN (SAVE) command with one or more commands using the "$" marker, as long as this doesn't create an ambiguity, as described in [Section 5.5](https://www.rfc-editor.org/info/rfc9051/#pipelining). Examples 7-9 in [Section 6.4.4.4](https://www.rfc-editor.org/info/rfc9051/#search-save-examples) explain this in more details.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.2-2)

##### [6.4.4.3.](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.3) [Refusing to Save Search Results](https://www.rfc-editor.org/info/rfc9051/#name-refusing-to-save-search-res)

In some cases, the server MAY refuse to save a SEARCH (SAVE) result, for example, if an internal limit on the number of saved results is reached. In this case, the server MUST return a tagged NO response containing the NOTSAVED response code and set the search result variable to the empty sequence, as described in [Section 6.4.4.1](https://www.rfc-editor.org/info/rfc9051/#search-save).[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.3-1)

##### [6.4.4.4.](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.4) [Examples Showing Use of the SAVE Result Option](https://www.rfc-editor.org/info/rfc9051/#name-examples-showing-use-of-the)

Only in this section: explanatory comments in examples that start with // are not part of the protocol.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.4-1)

1.  The following example demonstrates how the client can use the result of a SEARCH command to FETCH headers of interesting messages:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.4-2.1.1)
    
    Example 1:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.4-2.1.2)
    
    The client can also pipeline the two commands:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.4-2.1.4)
    
    Example 2:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.4-2.1.5)
    
2.  The following example demonstrates that the result of one SEARCH command can be used as input to another SEARCH command:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.4-2.2.1)
    
    Example 3:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.4-2.2.2)
    
    Note that the second command in Example 3 can be replaced with:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.4-2.2.4)
    
    and the result of the command would be the same.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.4-2.2.6)
    
3.  The following example shows that the "$" marker can be combined with other message numbers using the OR SEARCH criterion.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.4-2.3.1)
    
    Example 4:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.4-2.3.2)
    
4.  The following example demonstrates that a failed SEARCH sets the search result variable to the empty list. The server doesn't implement the KOI8-R charset.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.4-2.4.1)
    
    Example 5:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.4-2.4.2)
    
    Note: Since this document format is restricted to 7-bit ASCII text, it is not possible to show actual KOI8-R data. The "XXXX" is a placeholder for what would be 4 octets of 8-bit data in an actual transaction.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.4-2.4.4)
    
5.  The following example demonstrates that it is not an error to use the "$" marker when it contains no messages.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.4-2.5.1)
    
    Example 6:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.4-2.5.2)
    
    Example 7:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.4-2.5.4)
    
    Example 8:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.4-2.5.6)
    
    The following example demonstrates that the result of the second SEARCH RETURN (SAVE) always overrides the result of the first.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.4-2.5.8)
    
    Example 9:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.4-2.5.9)
    
    The following example demonstrates behavioral difference for different combinations of ESEARCH result options.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.4-2.5.11)
    
    Example 10:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4.4-2.5.12)
    

#### [6.4.5.](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5) [FETCH Command](https://www.rfc-editor.org/info/rfc9051/#name-fetch-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.4.5)

Arguments:

sequence set[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-1.2.1)

message data item names or macro[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-1.2.2)

Responses:

untagged responses:

FETCH[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-1.4.1.2)

Result:

OK -

fetch completed[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-1.6.1.2)

NO -

fetch error: can't fetch that data[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-1.6.1.4)

BAD -

command unknown or arguments invalid[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-1.6.1.6)

The FETCH command retrieves data associated with a message in the mailbox. The data items to be fetched can be either a single atom or a parenthesized list.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-2)

Most data items, identified in the formal syntax ([Section 9](https://www.rfc-editor.org/info/rfc9051/#IMAP-ABNF)) under the msg-att-static rule, are static and MUST NOT change for any particular message. Other data items, identified in the formal syntax under the msg-att-dynamic rule, MAY change either as a result of a STORE command or due to external events.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-3)

-   For example, if a client receives an ENVELOPE for a message when it already knows the envelope, it can safely ignore the newly transmitted envelope.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-4.1)

There are three macros that specify commonly used sets of data items and can be used instead of data items. A macro must be used by itself and not in conjunction with other macros or data items.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-5)

ALL

Macro equivalent to: (FLAGS INTERNALDATE RFC822.SIZE ENVELOPE)[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-6.2)

FAST

Macro equivalent to: (FLAGS INTERNALDATE RFC822.SIZE)[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-6.4)

FULL

Macro equivalent to: (FLAGS INTERNALDATE RFC822.SIZE ENVELOPE BODY)[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-6.6)

Several data items reference "section" or "section-binary". See [Section 6.4.5.1](https://www.rfc-editor.org/info/rfc9051/#fetch-section) for their detailed definition.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-7)

The currently defined data items that can be fetched are:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-8)

BINARY\[<section-binary>\]<<partial>>

Requests that the specified section be transmitted after performing decoding of the section's Content-Transfer-Encoding.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.2.1)

The <partial> argument, if present, requests that a subset of the data be returned. The semantics of a partial FETCH BINARY command are the same as for a partial FETCH BODY command, with the exception that the <partial> arguments refer to the DECODED section data.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.2.2)

Note that this data item can only be requested for leaf body parts: those that have media types other than multipart/\*, message/rfc822, or message/global.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.2.3)

BINARY.PEEK\[<section-binary>\]<<partial>>

An alternate form of BINARY\[<section-binary>\] that does not implicitly set the \\Seen flag.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.4)

BINARY.SIZE\[<section-binary>\]

Requests the decoded size of the section (i.e., the size to expect in response to the corresponding FETCH BINARY request).[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.6.1)

Note: client authors are cautioned that this might be an expensive operation for some server implementations. Needlessly issuing this request could result in degraded performance due to servers having to calculate the value every time the request is issued.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.6.2)

Note that this data item can only be requested for leaf body parts: those that have media types other than multipart/\*, message/rfc822, or message/global.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.6.3)

BODY

Non-extensible form of BODYSTRUCTURE.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.8)

BODY\[<section>\]<<partial>>

The text of a particular body section. If BODY\[\] is specified (the section specification is omitted), the FETCH is requesting the \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] expression of the entire message.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.10.1)

It is possible to fetch a substring of the designated text. This is done by appending an open angle bracket ("<"), the octet position of the first desired octet, a period, the maximum number of octets desired, and a close angle bracket (">") to the part specifier. If the starting octet is beyond the end of the text, an empty string is returned.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.10.2)

Any partial fetch that attempts to read beyond the end of the text is truncated as appropriate. A partial fetch that starts at octet 0 is returned as a partial fetch, even if this truncation happened.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.10.3)

Note: This means that BODY\[\]<0.2048> of a 1500-octet message will return BODY\[\]<0> with a literal of size 1500, not BODY\[\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.10.4)

Note: A substring fetch of a HEADER.FIELDS or HEADER.FIELDS.NOT part specifier is calculated after subsetting the header.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.10.5)

The \\Seen flag is implicitly set; if this causes the flags to change, they SHOULD be included as part of the FETCH responses.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.10.6)

BODY.PEEK\[<section>\]<<partial>>

An alternate form of BODY\[<section>\] that does not implicitly set the \\Seen flag.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.12)

BODYSTRUCTURE

The \[[MIME-IMB](https://www.rfc-editor.org/info/rfc9051/#RFC2045)\] body structure of the message. This is computed by the server by parsing the \[[MIME-IMB](https://www.rfc-editor.org/info/rfc9051/#RFC2045)\] header fields in the \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] header and \[[MIME-IMB](https://www.rfc-editor.org/info/rfc9051/#RFC2045)\] headers. See [Section 7.5.2](https://www.rfc-editor.org/info/rfc9051/#fetch-response) for more details.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.14)

ENVELOPE

The envelope structure of the message. This is computed by the server by parsing the \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] header into the component parts, defaulting various fields as necessary. See [Section 7.5.2](https://www.rfc-editor.org/info/rfc9051/#fetch-response) for more details.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.16)

FLAGS

The flags that are set for this message.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.18)

INTERNALDATE

The internal date of the message.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.20)

RFC822.SIZE

The size of the message, as defined in [Section 2.3.4](https://www.rfc-editor.org/info/rfc9051/#RFC822.SIZE_message_attribute).[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.22)

UID

The unique identifier for the message.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.24)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-10)

##### [6.4.5.1.](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5.1) [FETCH Section Specification](https://www.rfc-editor.org/info/rfc9051/#name-fetch-section-specification)

Several FETCH data items reference "section" or "section-binary". The section specification is a set of zero or more part specifiers delimited by periods. A part specifier is either a part number or one of the following: HEADER, HEADER.FIELDS, HEADER.FIELDS.NOT, MIME, and TEXT. (Non-numeric part specifiers have to be the last specifier in a section specification.) An empty section specification refers to the entire message, including the header.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5.1-1)

Every message has at least one part number. Messages that do not use MIME, and MIME messages that are not multipart and have no encapsulated message within them, only have a part 1.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5.1-2)

Multipart messages are assigned consecutive part numbers, as they occur in the message. If a particular part is of type message or multipart, its parts MUST be indicated by a period followed by the part number within that nested multipart part.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5.1-3)

A part of type MESSAGE/RFC822 or MESSAGE/GLOBAL also has nested part numbers, referring to parts of the MESSAGE part's body.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5.1-4)

The HEADER, HEADER.FIELDS, HEADER.FIELDS.NOT, and TEXT part specifiers can be the sole part specifier or can be prefixed by one or more numeric part specifiers, provided that the numeric part specifier refers to a part of type MESSAGE/RFC822 or MESSAGE/GLOBAL. The MIME part specifier MUST be prefixed by one or more numeric part specifiers.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5.1-5)

The HEADER, HEADER.FIELDS, and HEADER.FIELDS.NOT part specifiers refer to the \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] header of the message or of an encapsulated \[[MIME-IMT](https://www.rfc-editor.org/info/rfc9051/#RFC2046)\] MESSAGE/RFC822 or MESSAGE/GLOBAL message. HEADER.FIELDS and HEADER.FIELDS.NOT are followed by a list of field-names (as defined in \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\]) and return a subset of the header. The subset returned by HEADER.FIELDS contains only those header fields with a field-name that matches one of the names in the list; similarly, the subset returned by HEADER.FIELDS.NOT contains only the header fields with a non-matching field-name. The field-matching is ASCII-range case insensitive but is otherwise exact. Subsetting does not exclude the \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] delimiting blank line between the header and the body; the blank line is included in all header fetches, except in the case of a message that has no body and no blank line.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5.1-6)

The MIME part specifier refers to the \[[MIME-IMB](https://www.rfc-editor.org/info/rfc9051/#RFC2045)\] header for this part.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5.1-7)

The TEXT part specifier refers to the text body of the message, omitting the \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] header.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5.1-8)

Here is an example of a complex message with some of its part specifiers:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5.1-9)

#### [6.4.6.](https://www.rfc-editor.org/info/rfc9051/#section-6.4.6) [STORE Command](https://www.rfc-editor.org/info/rfc9051/#name-store-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.4.6)

Arguments:

sequence set[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.6-1.2.1)

message data item name[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.6-1.2.2)

value for message data item[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.6-1.2.3)

Responses:

untagged responses:

FETCH[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.6-1.4.1.2)

Result:

OK -

store completed[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.6-1.6.1.2)

NO -

store error: can't store that data[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.6-1.6.1.4)

BAD -

command unknown or arguments invalid[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.6-1.6.1.6)

The STORE command alters data associated with a message in the mailbox. Normally, STORE will return the updated value of the data with an untagged FETCH response. A suffix of ".SILENT" in the data item name prevents the untagged FETCH, and the server SHOULD assume that the client has determined the updated value itself or does not care about the updated value.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.6-2)

Note: Regardless of whether or not the ".SILENT" suffix was used, the server SHOULD send an untagged FETCH response if a change to a message's flags from an external source is observed. The intent is that the status of the flags is determinate without a race condition.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.6-3)

The currently defined data items that can be stored are:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.6-4)

FLAGS <flag list>

Replace the flags for the message with the argument. The new value of the flags is returned as if a FETCH of those flags was done.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.6-5.2)

FLAGS.SILENT <flag list>

Equivalent to FLAGS, but without returning a new value.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.6-5.4)

+FLAGS <flag list>

Add the argument to the flags for the message. The new value of the flags is returned as if a FETCH of those flags was done.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.6-5.6)

+FLAGS.SILENT <flag list>

Equivalent to +FLAGS, but without returning a new value.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.6-5.8)

\-FLAGS <flag list>

Remove the argument from the flags for the message. The new value of the flags is returned as if a FETCH of those flags was done.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.6-5.10)

\-FLAGS.SILENT <flag list>

Equivalent to -FLAGS, but without returning a new value.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.6-5.12)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.6-6)

#### [6.4.7.](https://www.rfc-editor.org/info/rfc9051/#section-6.4.7) [COPY Command](https://www.rfc-editor.org/info/rfc9051/#name-copy-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.4.7)

Arguments:

sequence set[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.7-1.2.1)

mailbox name[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.7-1.2.2)

Responses:

no specific responses for this command[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.7-1.4)

Result:

OK -

copy completed[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.7-1.6.1.2)

NO -

copy error: can't copy those messages or to that name[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.7-1.6.1.4)

BAD -

command unknown or arguments invalid[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.7-1.6.1.6)

The COPY command copies the specified message(s) to the end of the specified destination mailbox. The flags and internal date of the message(s) SHOULD be preserved in the copy.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.7-2)

If the destination mailbox does not exist, a server MUST return an error. It MUST NOT automatically create the mailbox. Unless it is certain that the destination mailbox can not be created, the server MUST send the response code "\[TRYCREATE\]" as the prefix of the text of the tagged NO response. This gives a hint to the client that it can attempt a CREATE command and retry the COPY if the CREATE is successful.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.7-3)

If the COPY command is unsuccessful for any reason, server implementations MUST restore the destination mailbox to its state before the COPY attempt (other than possibly incrementing UIDNEXT), i.e., partial copy MUST NOT be done.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.7-4)

On successful completion of a COPY, the server returns a COPYUID response code (see [Section 7.1](https://www.rfc-editor.org/info/rfc9051/#server-status-responses)). Two exceptions to this requirement are listed below.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.7-5)

In the case of a mailbox that has permissions set so that the client can COPY to the mailbox, but not SELECT or EXAMINE it, the server MUST NOT send a COPYUID response code as it would disclose information about the mailbox.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.7-6)

In the case of a mailbox that has UIDNOTSTICKY status (see [Section 7.1](https://www.rfc-editor.org/info/rfc9051/#server-status-responses)), the server MAY omit the COPYUID response code as it is not meaningful.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.7-7)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.7-8)

#### [6.4.8.](https://www.rfc-editor.org/info/rfc9051/#section-6.4.8) [MOVE Command](https://www.rfc-editor.org/info/rfc9051/#name-move-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.4.8)

Arguments:

sequence set[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.8-1.2.1)

mailbox name[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.8-1.2.2)

Responses:

no specific responses for this command[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.8-1.4)

Result:

OK -

move completed[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.8-1.6.1.2)

NO -

move error: can't move those messages or to that name[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.8-1.6.1.4)

BAD -

command unknown or arguments invalid[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.8-1.6.1.6)

The MOVE command moves the specified message(s) to the end of the specified destination mailbox. The flags and internal date of the message(s) SHOULD be preserved.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.8-2)

This means that a new message is created in the target mailbox with a new UID, the original message is removed from the source mailbox, and it appears to the client as a single action. This has the same effect for each message as this sequence:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.8-3)

1.  \[UID\] COPY[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.8-4.1)
2.  \[UID\] STORE +FLAGS.SILENT \\DELETED[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.8-4.2)
3.  UID EXPUNGE[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.8-4.3)

Although the effect of the MOVE is the same as the preceding steps, the semantics are not identical: the intermediate states produced by those steps do not occur, and the response codes are different. In particular, though the COPY and EXPUNGE response codes will be returned, response codes for a STORE MUST NOT be generated, and the \\Deleted flag MUST NOT be set for any message.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.8-5)

Unlike the COPY command, MOVE of a set of messages might fail partway through the set. Regardless of whether the command is successful in moving the entire set, each individual message MUST be either moved or unaffected. The server MUST leave each message in a state where it is in at least one of the source or target mailboxes (no message can be lost or orphaned). The server SHOULD NOT leave any message in both mailboxes (it would be bad for a partial failure to result in a bunch of duplicate messages). This is true even if the server returns a tagged NO response to the command.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.8-6)

If the destination mailbox does not exist, a server MUST return an error. It MUST NOT automatically create the mailbox. Unless it is certain that the destination mailbox cannot be created, the server MUST send the response code "\[TRYCREATE\]" as the prefix of the text of the tagged NO response. This gives a hint to the client that it can attempt a CREATE command and retry the MOVE if the CREATE is successful.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.8-7)

Because of the similarity of MOVE to COPY, extensions that affect COPY affect MOVE in the same way. Response codes listed in [Section 7.1](https://www.rfc-editor.org/info/rfc9051/#server-status-responses), as well as those defined by extensions, are sent as indicated for COPY.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.8-8)

Servers send COPYUID in response to a MOVE or a UID MOVE (see [Section 6.4.9](https://www.rfc-editor.org/info/rfc9051/#uid-commands)) command. For additional information about COPYUID, see [Section 7.1](https://www.rfc-editor.org/info/rfc9051/#server-status-responses). Note that there are several exceptions listed in [Section 6.4.7](https://www.rfc-editor.org/info/rfc9051/#copy-command) that allow servers not to return COPYUID.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.8-9)

Servers are also REQUIRED to send the COPYUID response code in an untagged OK before sending EXPUNGE or similar responses. (Sending COPYUID in the tagged OK, as described in [Section 6.4.7](https://www.rfc-editor.org/info/rfc9051/#copy-command), means that clients first receive an EXPUNGE for a message and afterwards COPYUID for the same message. It can be unnecessarily difficult to process that sequence usefully.)[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.8-10)

An example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.8-11)

Note that the server may send unrelated EXPUNGE responses as well, if any happen to have been expunged at the same time; this is normal IMAP operation.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.8-13)

Note that moving a message to the currently selected mailbox (that is, where the source and target mailboxes are the same) is allowed when copying the message to the currently selected mailbox is allowed.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.8-14)

The server may send EXPUNGE responses before the tagged response, so the client cannot safely send more commands with message sequence number arguments while the server is processing MOVE.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.8-15)

MOVE and UID MOVE can be pipelined with other commands, but care has to be taken. Both commands modify sequence numbers and also allow unrelated EXPUNGE responses. The renumbering of other messages in the source mailbox following any EXPUNGE response can be surprising and makes it unsafe to pipeline any command that relies on message sequence numbers after a MOVE or UID MOVE. Similarly, MOVE cannot be pipelined with a command that might cause message renumbering. See [Section 5.5](https://www.rfc-editor.org/info/rfc9051/#pipelining) for more information about ambiguities as well as handling requirements for both clients and servers.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.8-16)

#### [6.4.9.](https://www.rfc-editor.org/info/rfc9051/#section-6.4.9) [UID Command](https://www.rfc-editor.org/info/rfc9051/#name-uid-command) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.4.9)

Arguments:

command name[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.9-1.2.1)

command arguments[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.9-1.2.2)

Responses:

untagged responses:

FETCH, ESEARCH, EXPUNGE[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.9-1.4.1.2)

Result:

OK -

UID command completed[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.9-1.6.1.2)

NO -

UID command error[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.9-1.6.1.4)

BAD -

command unknown or arguments invalid[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.9-1.6.1.6)

The UID command has three forms. In the first form, it takes as its arguments a COPY, MOVE, FETCH, or STORE command with arguments appropriate for the associated command. However, the numbers in the sequence-set argument are unique identifiers instead of message sequence numbers. Sequence-set ranges are permitted, but there is no guarantee that unique identifiers will be contiguous.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.9-2)

A non-existent unique identifier is ignored without any error message generated. Thus, it is possible for a UID FETCH command to return an OK without any data or a UID COPY, UID MOVE, or UID STORE to return an OK without performing any operations.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.9-3)

In the second form, the UID command takes an EXPUNGE command with an extra parameter that specifies a sequence set of UIDs to operate on. The UID EXPUNGE command permanently removes all messages that have both the \\Deleted flag set and a UID that is included in the specified sequence set from the currently selected mailbox. If a message either does not have the \\Deleted flag set or has a UID that is not included in the specified sequence set, it is not affected.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.9-4)

UID EXPUNGE is particularly useful for disconnected use clients. By using UID EXPUNGE instead of EXPUNGE when resynchronizing with the server, the client can ensure that it does not inadvertently remove any messages that have been marked as \\Deleted by other clients between the time that the client was last connected and the time the client resynchronizes.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.9-5)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.9-6)

In the third form, the UID command takes a SEARCH command with SEARCH command arguments. The interpretation of the arguments is the same as with SEARCH; however, the numbers returned in an ESEARCH response for a UID SEARCH command are unique identifiers instead of message sequence numbers. Also, the corresponding ESEARCH response MUST include the UID indicator. For example, the command UID SEARCH 1:100 UID 443:557 returns the unique identifiers corresponding to the intersection of two sequence sets, the message sequence number range 1:100, and the UID range 443:557.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.9-8)

Note: in the above example, the UID range 443:557 appears. The same comment about a non-existent unique identifier being ignored without any error message also applies here. Hence, even if neither UID 443 or 557 exist, this range is valid and would include an existing UID 495.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.9-9)

Also note that a UID range of 559:\* always includes the UID of the last message in the mailbox, even if 559 is higher than any assigned UID value. This is because the contents of a range are independent of the order of the range endpoints. Thus, any UID range with \* as one of the endpoints indicates at least one message (the message with the highest numbered UID), unless the mailbox is empty.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.9-10)

The number after the "\*" in an untagged FETCH or EXPUNGE response is always a message sequence number, not a unique identifier, even for a UID command response. However, server implementations MUST implicitly include the UID message data item as part of any FETCH response caused by a UID command, regardless of whether a UID was specified as a message data item to the FETCH.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.9-11)

Note: The rule about including the UID message data item as part of a FETCH response primarily applies to the UID FETCH and UID STORE commands, including a UID FETCH command that does not include UID as a message data item. Although it is unlikely that the other UID commands will cause an untagged FETCH, this rule applies to these commands as well.[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.9-12)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.4.9-13)

### [6.5.](https://www.rfc-editor.org/info/rfc9051/#section-6.5) [Client Commands - Experimental/Expansion](https://www.rfc-editor.org/info/rfc9051/#name-client-commands-experimenta) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-6.5)

Each command that is not part of this specification MUST have at least one capability name (see [Section 6.1.1](https://www.rfc-editor.org/info/rfc9051/#capability-command)) associated with it. (Multiple commands can be associated with the same capability name.)[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.5-1)

Server implementations MUST NOT send any added untagged responses (not specified in this specification), unless the client requested it by issuing the associated experimental command (specified in an extension document) or the ENABLE command ([Section 6.3.1](https://www.rfc-editor.org/info/rfc9051/#enable-command)).[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.5-2)

The following example demonstrates how a client can check for the presence of a fictitious XPIG-LATIN capability that adds the XPIG-LATIN command and the XPIG-LATIN untagged response. (Note that for an extension, the command name and the capability name don't have to be the same.)[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.5-3)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-6.5-4)

## [7\.](https://www.rfc-editor.org/info/rfc9051/#section-7) [Server Responses](https://www.rfc-editor.org/info/rfc9051/#name-server-responses) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-7)

Server responses are in three forms: status responses, server data, and command continuation requests. The information contained in a server response, identified by "Contents:" in the response descriptions below, is described by function, not by syntax. The precise syntax of server responses is described in "Formal Syntax" ([Section 9](https://www.rfc-editor.org/info/rfc9051/#IMAP-ABNF)).[¶](https://www.rfc-editor.org/info/rfc9051/#section-7-1)

The client MUST be prepared to accept any response at all times.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7-2)

Status responses can be tagged or untagged. Tagged status responses indicate the completion result (OK, NO, or BAD status) of a client command and have a tag matching the command.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7-3)

Some status responses, and all server data, are untagged. An untagged response is indicated by the token "\*" instead of a tag. Untagged status responses indicate server greeting or server status that does not indicate the completion of a command (for example, an impending system shutdown alert). For historical reasons, untagged server data responses are also called "unsolicited data", although strictly speaking, only unilateral server data is truly "unsolicited".[¶](https://www.rfc-editor.org/info/rfc9051/#section-7-4)

Certain server data MUST be remembered by the client when it is received; this is noted in the description of that data. Such data conveys critical information that affects the interpretation of all subsequent commands and responses (e.g., updates reflecting the creation or destruction of messages).[¶](https://www.rfc-editor.org/info/rfc9051/#section-7-5)

Other server data SHOULD be remembered for later reference; if the client does not need to remember the data, or if remembering the data has no obvious purpose (e.g., a SEARCH response when no SEARCH command is in progress), the data can be ignored.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7-6)

An example of unilateral untagged server data occurs when the IMAP connection is in the selected state. In the selected state, the server checks the mailbox for new messages as part of command execution. Normally, this is part of the execution of every command; hence, a NOOP command suffices to check for new messages. If new messages are found, the server sends an untagged EXISTS response reflecting the new size of the mailbox. Server implementations that offer multiple simultaneous access to the same mailbox SHOULD also send appropriate unilateral untagged FETCH and EXPUNGE responses if another agent changes the state of any message flags or expunges any messages.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7-7)

Command continuation request responses use the token "+" instead of a tag. These responses are sent by the server to indicate acceptance of an incomplete client command and readiness for the remainder of the command.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7-8)

### [7.1.](https://www.rfc-editor.org/info/rfc9051/#section-7.1) [Server Responses - Generic Status Responses](https://www.rfc-editor.org/info/rfc9051/#name-server-responses-generic-st) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-7.1)

Status responses are OK, NO, BAD, PREAUTH, and BYE. OK, NO, and BAD can be tagged or untagged. PREAUTH and BYE are always untagged.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-1)

Status responses MAY include an OPTIONAL "response code". A response code consists of data inside square brackets in the form of an atom, possibly followed by a space and arguments. The response code contains additional information or status codes for client software beyond the OK/NO/BAD condition and are defined when there is a specific action that a client can take based upon the additional information.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-2)

The currently defined response codes are:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-3)

ALERT

The human-readable text contains a special alert that is presented to the user in a fashion that calls the user's attention to the message. Content of ALERT response codes received on a connection without TLS or SASL security-layer confidentiality SHOULD be ignored by clients. If displayed, such alerts MUST be clearly marked as potentially suspicious. (Note that some existing clients are known to hyperlink returned text, which make them very dangerous.) Alerts received after successful establishment of a TLS/SASL confidentiality layer MUST be presented to the user.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.2)

ALREADYEXISTS

The operation attempts to create something that already exists, such as when a CREATE or RENAME command attempts to create a mailbox and there is already one of that name.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.4.1)

APPENDUID

Followed by the UIDVALIDITY of the destination mailbox and the UID assigned to the appended message in the destination mailbox, it indicates that the message has been appended to the destination mailbox with that UID.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.6.1)

If the server also supports the \[[MULTIAPPEND](https://www.rfc-editor.org/info/rfc9051/#RFC3502)\] extension, and if multiple messages were appended in the APPEND command, then the second value is a UID set containing the UIDs assigned to the appended messages, in the order they were transmitted in the APPEND command. This UID set may not contain extraneous UIDs or the symbol "\*".[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.6.2)

Note: the UID set form of the APPENDUID response code MUST NOT be used if only a single message was appended. In particular, a server MUST NOT send a range such as 123:123. This is because a client that does not support \[[MULTIAPPEND](https://www.rfc-editor.org/info/rfc9051/#RFC3502)\] expects only a single UID and not a UID set.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.6.3)

UIDs are assigned in strictly ascending order in the mailbox (refer to [Section 2.3.1.1](https://www.rfc-editor.org/info/rfc9051/#uid-def)); note that a range of 12:10 is exactly equivalent to 10:12 and refers to the sequence 10,11,12.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.6.4)

This response code is returned in a tagged OK response to the APPEND command.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.6.5)

AUTHENTICATIONFAILED

Authentication failed for some reason on which the server is unwilling to elaborate. Typically, this includes "unknown user" and "bad password".[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.8.1)

This is the same as not sending any response code, except that when a client sees AUTHENTICATIONFAILED, it knows that the problem wasn't, e.g., UNAVAILABLE, so there's no point in trying the same login/password again later.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.8.2)

AUTHORIZATIONFAILED

Authentication succeeded in using the authentication identity, but the server cannot or will not allow the authentication identity to act as the requested authorization identity. This is only applicable when the authentication and authorization identities are different.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.10.1)

BADCHARSET

Optionally followed by a parenthesized list of charsets. A SEARCH failed because the given charset is not supported by this implementation. If the optional list of charsets is given, this lists the charsets that are supported by this implementation.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.12)

CANNOT

This operation violates some invariant of the server and can never succeed.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.14.1)

CAPABILITY

Followed by a list of capabilities. This can appear in the initial OK or PREAUTH response to transmit an initial capabilities list. It can also appear in tagged responses to LOGIN or AUTHENTICATE commands. This makes it unnecessary for a client to send a separate CAPABILITY command if it recognizes this response code and there was no change to the TLS and/or authentication state since it was received.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.16)

CLIENTBUG

The server has detected a client bug. This can accompany any of OK, NO, and BAD, depending on what the client bug is.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.18.1)

CLOSED

The CLOSED response code has no parameters. A server returns the CLOSED response code when the currently selected mailbox is closed implicitly using the SELECT or EXAMINE command on another mailbox. The CLOSED response code serves as a boundary between responses for the previously opened mailbox (which was closed) and the newly selected mailbox; all responses before the CLOSED response code relate to the mailbox that was closed, and all subsequent responses relate to the newly opened mailbox.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.20.1)

There is no need to return the CLOSED response code on completion of the CLOSE or the UNSELECT command (or similar), whose purpose is to close the currently selected mailbox without opening a new one.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.20.2)

CONTACTADMIN

The user should contact the system administrator or support desk.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.22.1)

COPYUID

Followed by the UIDVALIDITY of the destination mailbox, a UID set containing the UIDs of the message(s) in the source mailbox that were copied to the destination mailbox, followed by another UID set containing the UIDs assigned to the copied message(s) in the destination mailbox, indicates that the message(s) has been copied to the destination mailbox with the stated UID(s).[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.24.1)

The source UID set is in the order the message(s) was copied; the destination UID set corresponds to the source UID set and is in the same order. Neither of the UID sets may contain extraneous UIDs or the symbol "\*".[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.24.2)

UIDs are assigned in strictly ascending order in the mailbox (refer to [Section 2.3.1.1](https://www.rfc-editor.org/info/rfc9051/#uid-def)); note that a range of 12:10 is exactly equivalent to 10:12 and refers to the sequence 10,11,12.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.24.3)

This response code is returned in a tagged OK response to the COPY or UID COPY command or in the untagged OK response to the MOVE or UID MOVE command.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.24.4)

CORRUPTION

The server discovered that some relevant data (e.g., the mailbox) are corrupt. This response code does not include any information about what's corrupt, but the server can write that to its logfiles.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.26.1)

EXPIRED

Either authentication succeeded or the server no longer had the necessary data; either way, access is no longer permitted using that passphrase. The client or user should get a new passphrase.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.28.1)

EXPUNGEISSUED

Someone else has issued an EXPUNGE for the same mailbox. The client may want to issue NOOP soon. \[[IMAP-MULTIACCESS](https://www.rfc-editor.org/info/rfc9051/#RFC2180)\] discusses this subject in depth.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.30.1)

HASCHILDREN

The mailbox delete operation failed because the mailbox has one or more children, and the server doesn't allow deletion of mailboxes with children.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.32.1)

INUSE

An operation has not been carried out because it involves sawing off a branch someone else is sitting on. Someone else may be holding an exclusive lock needed for this operation, or the operation may involve deleting a resource someone else is using, typically a mailbox.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.34.1)

The operation may succeed if the client tries again later.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.34.2)

LIMIT

The operation ran up against an implementation limit of some kind, such as the number of flags on a single message or the number of flags used in a mailbox.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.36.1)

NONEXISTENT

The operation attempts to delete something that does not exist. Similar to ALREADYEXISTS.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.38.1)

NOPERM

The access control system (e.g., ACL; see \[[RFC4314](https://www.rfc-editor.org/info/rfc9051/#RFC4314)\]) does not permit this user to carry out an operation, such as selecting or creating a mailbox.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.40.1)

OVERQUOTA

The user would be over quota after the operation. (The user may or may not be over quota already.)[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.42.1)

Note that if the server sends OVERQUOTA but doesn't support the IMAP QUOTA extension defined by \[[RFC2087](https://www.rfc-editor.org/info/rfc9051/#RFC2087)\], then there is a quota, but the client cannot find out what the quota is.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.42.2)

PARSE

The human-readable text represents an error in parsing the \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] header or \[[MIME-IMB](https://www.rfc-editor.org/info/rfc9051/#RFC2045)\] headers of a message in the mailbox.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.44)

PERMANENTFLAGS

Followed by a parenthesized list of flags and indicates which of the known flags the client can change permanently. Any flags that are in the FLAGS untagged response, but not in the PERMANENTFLAGS list, cannot be set permanently. The PERMANENTFLAGS list can also include the special flag \\\*, which indicates that it is possible to create new keywords by attempting to store those keywords in the mailbox. If the client attempts to STORE a flag that is not in the PERMANENTFLAGS list, the server will either ignore the change or store the state change for the remainder of the current session only.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.46.1)

There is no need for a server that included the special flag \\\* to return a new PERMANENTFLAGS response code when a new keyword was successfully set on a message upon client request. However, if the server has a limit on the number of different keywords that can be stored in a mailbox and that limit is reached, the server MUST send a new PERMANENTFLAGS response code without the special flag \\\*.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.46.2)

PRIVACYREQUIRED

The operation is not permitted due to a lack of data confidentiality. If TLS is not in use, the client could try STARTTLS (see [Section 6.2.1](https://www.rfc-editor.org/info/rfc9051/#STARTTLS)) or alternatively reconnect on an Implicit TLS port, and then repeat the operation.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.48.1)

READ-ONLY

The mailbox is selected as read-only, or its access while selected has changed from read-write to read-only.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.50)

READ-WRITE

The mailbox is selected as read-write, or its access while selected has changed from read-only to read-write.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.52)

SERVERBUG

The server encountered a bug in itself or violated one of its own invariants.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.54.1)

TRYCREATE

An APPEND, COPY, or MOVE attempt is failing because the target mailbox does not exist (as opposed to some other reason). This is a hint to the client that the operation can succeed if the mailbox is first created by the CREATE command.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.56)

UIDNEXT

Followed by a decimal number and indicates the next unique identifier value. Refer to [Section 2.3.1.1](https://www.rfc-editor.org/info/rfc9051/#uid-def) for more information.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.58)

UIDNOTSTICKY

The selected mailbox is supported by a mail store that does not support persistent UIDs; that is, UIDVALIDITY will be different each time the mailbox is selected. Consequently, APPEND or COPY to this mailbox will not return an APPENDUID or COPYUID response code.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.60.1)

This response code is returned in an untagged NO response to the SELECT command.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.60.2)

Note: servers SHOULD NOT have any UIDNOTSTICKY mail stores. This facility exists to support legacy mail stores in which it is technically infeasible to support persistent UIDs. This should be avoided when designing new mail stores.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.60.3)

UIDVALIDITY

Followed by a decimal number and indicates the unique identifier validity value. Refer to [Section 2.3.1.1](https://www.rfc-editor.org/info/rfc9051/#uid-def) for more information.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.62)

UNAVAILABLE

Temporary failure because a subsystem is down. For example, an IMAP server that uses a Lightweight Directory Access Protocol (LDAP) or Radius server for authentication might use this response code when the LDAP/Radius server is down.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.64.1)

UNKNOWN-CTE

The server does not know how to decode the section's Content-Transfer-Encoding.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.66)

Client implementations MUST ignore response codes that they do not recognize.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1-5)

#### [7.1.1.](https://www.rfc-editor.org/info/rfc9051/#section-7.1.1) [OK Response](https://www.rfc-editor.org/info/rfc9051/#name-ok-response) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-7.1.1)

Contents:

-   OPTIONAL response code[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.1-1.2.1.1)
-   human-readable text[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.1-1.2.1.2)

The OK response indicates an information message from the server. When tagged, it indicates successful completion of the associated command. The human-readable text MAY be presented to the user as an information message. The untagged form indicates an information-only message; the nature of the information MAY be indicated by a response code.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.1-2)

The untagged form is also used as one of three possible greetings at connection startup. It indicates that the connection is not yet authenticated and that a LOGIN or an AUTHENTICATE command is needed.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.1-3)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.1-4)

#### [7.1.2.](https://www.rfc-editor.org/info/rfc9051/#section-7.1.2) [NO Response](https://www.rfc-editor.org/info/rfc9051/#name-no-response) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-7.1.2)

Contents:

-   OPTIONAL response code[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.2-1.2.1.1)
-   human-readable text[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.2-1.2.1.2)

The NO response indicates an operational error message from the server. When tagged, it indicates unsuccessful completion of the associated command. The untagged form indicates a warning; the command can still complete successfully. The human-readable text describes the condition.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.2-2)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.2-3)

#### [7.1.3.](https://www.rfc-editor.org/info/rfc9051/#section-7.1.3) [BAD Response](https://www.rfc-editor.org/info/rfc9051/#name-bad-response) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-7.1.3)

Contents:

-   OPTIONAL response code[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.3-1.2.1.1)
-   human-readable text[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.3-1.2.1.2)

The BAD response indicates an error message from the server. When tagged, it reports a protocol-level error in the client's command; the tag indicates the command that caused the error. The untagged form indicates a protocol-level error for which the associated command can not be determined; it can also indicate an internal server failure. The human-readable text describes the condition.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.3-2)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.3-3)

#### [7.1.4.](https://www.rfc-editor.org/info/rfc9051/#section-7.1.4) [PREAUTH Response](https://www.rfc-editor.org/info/rfc9051/#name-preauth-response) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-7.1.4)

Contents:

-   OPTIONAL response code[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.4-1.2.1.1)
-   human-readable text[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.4-1.2.1.2)

The PREAUTH response is always untagged and is one of three possible greetings at connection startup. It indicates that the connection has already been authenticated by external means; thus, no LOGIN/AUTHENTICATE command is needed.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.4-2)

Because PREAUTH moves the connection directly to the authenticated state, it effectively prevents the client from using the STARTTLS command ([Section 6.2.1](https://www.rfc-editor.org/info/rfc9051/#STARTTLS)). For this reason, the PREAUTH response SHOULD only be returned by servers on connections that are protected by TLS (such as on an Implicit TLS port \[[RFC8314](https://www.rfc-editor.org/info/rfc9051/#RFC8314)\]) or protected through other means such as IPsec. Clients that require mandatory TLS MUST close the connection after receiving the PREAUTH response on a non-protected port.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.4-3)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.4-4)

#### [7.1.5.](https://www.rfc-editor.org/info/rfc9051/#section-7.1.5) [BYE Response](https://www.rfc-editor.org/info/rfc9051/#name-bye-response) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-7.1.5)

Contents:

-   OPTIONAL response code[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.5-1.2.1.1)
-   human-readable text[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.5-1.2.1.2)

The BYE response is always untagged and indicates that the server is about to close the connection. The human-readable text MAY be displayed to the user in a status report by the client. The BYE response is sent under one of four conditions:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.5-2)

1.  as part of a normal logout sequence. The server will close the connection after sending the tagged OK response to the LOGOUT command.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.5-3.1)
2.  as a panic shutdown announcement. The server closes the connection immediately.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.5-3.2)
3.  as an announcement of an inactivity autologout. The server closes the connection immediately.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.5-3.3)
4.  as one of three possible greetings at connection startup, indicating that the server is not willing to accept a connection from this client. The server closes the connection immediately.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.5-3.4)

The difference between a BYE that occurs as part of a normal LOGOUT sequence (the first case) and a BYE that occurs because of a failure (the other three cases) is that the connection closes immediately in the failure case. In all cases, the client SHOULD continue to read response data from the server until the connection is closed; this will ensure that any pending untagged or completion responses are read and processed.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.5-4)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.1.5-5)

### [7.2.](https://www.rfc-editor.org/info/rfc9051/#section-7.2) [Server Responses - Server Status](https://www.rfc-editor.org/info/rfc9051/#name-server-responses-server-sta) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-7.2)

These responses are always untagged. This is how server status data are transmitted from the server to the client.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.2-1)

#### [7.2.1.](https://www.rfc-editor.org/info/rfc9051/#section-7.2.1) [ENABLED Response](https://www.rfc-editor.org/info/rfc9051/#name-enabled-response) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-7.2.1)

Contents:

capability listing[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.2.1-1.2)

The ENABLED response occurs as a result of an ENABLE command. The capability listing contains a space-separated listing of capability names that the server supports and that were successfully enabled. The ENABLED response may contain no capabilities, which means that no extensions listed by the client were successfully enabled.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.2.1-2)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.2.1-3)

#### [7.2.2.](https://www.rfc-editor.org/info/rfc9051/#section-7.2.2) [CAPABILITY Response](https://www.rfc-editor.org/info/rfc9051/#name-capability-response) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-7.2.2)

Contents:

capability listing[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.2.2-1.2)

The CAPABILITY response occurs as a result of a CAPABILITY command. The capability listing contains a space-separated listing of capability names that the server supports. The capability listing MUST include the atom "IMAP4rev2", but note that it doesn't have to be the first capability listed. The order of capability names has no significance.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.2.2-2)

Client and server implementations MUST implement the capabilities "AUTH=PLAIN" (described in \[[PLAIN](https://www.rfc-editor.org/info/rfc9051/#RFC4616)\]), and MUST implement "STARTTLS" and "LOGINDISABLED" on the cleartext port. See the Security Considerations ([Section 11](https://www.rfc-editor.org/info/rfc9051/#sec-cons)) for important information related to these capabilities.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.2.2-3)

A capability name that begins with "AUTH=" indicates that the server supports that particular authentication mechanism \[[SASL](https://www.rfc-editor.org/info/rfc9051/#RFC4422)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.2.2-4)

The LOGINDISABLED capability indicates that the LOGIN command is disabled, and that the server will respond with a tagged NO response to any attempt to use the LOGIN command even if the user name and password are valid (their validity will not be checked). An IMAP client MUST NOT issue the LOGIN command if the server advertises the LOGINDISABLED capability.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.2.2-5)

Other capability names indicate that the server supports an extension, revision, or amendment to the IMAP4rev2 protocol. If IMAP4rev1 capability is not advertised, server responses MUST conform to this document until the client issues a command that uses an additional capability. If both IMAP4rev1 and IMAP4rev2 capabilities are advertised, server responses MUST conform to \[[RFC3501](https://www.rfc-editor.org/info/rfc9051/#RFC3501)\] until the client issues a command that uses an additional capability. (For example, the client can issue ENABLE IMAP4rev2 to enable IMAP4rev2-specific behavior.)[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.2.2-6)

Capability names SHOULD be registered with IANA using the RFC Required policy \[[RFC8126](https://www.rfc-editor.org/info/rfc9051/#RFC8126)\]. A server SHOULD NOT offer unregistered capability names.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.2.2-7)

Client implementations SHOULD NOT require any capability name other than "IMAP4rev2", and possibly "STARTTLS" and "LOGINDISABLED" (on a cleartext port). Client implementations MUST ignore any unknown capability names.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.2.2-8)

A server MAY send capabilities automatically, by using the CAPABILITY response code in the initial PREAUTH or OK responses and by sending an updated CAPABILITY response code in the tagged OK response as part of a successful authentication. It is unnecessary for a client to send a separate CAPABILITY command if it recognizes these automatic capabilities and there was no change to the TLS and/or authentication state since they were received.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.2.2-9)

The list of capabilities returned by a server MAY change during the connection. In particular, it is quite common for the server to change the list of capabilities after successful TLS negotiation (STARTTLS command) and/or after successful authentication (AUTHENTICATE or LOGIN commands).[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.2.2-10)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.2.2-11)

Note that in the above example, XPIG-LATIN is a fictitious capability name.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.2.2-13)

### [7.3.](https://www.rfc-editor.org/info/rfc9051/#section-7.3) [Server Responses - Mailbox Status](https://www.rfc-editor.org/info/rfc9051/#name-server-responses-mailbox-st) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-7.3)

These responses are always untagged. This is how mailbox status data are transmitted from the server to the client. Many of these responses typically result from a command with the same name.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3-1)

#### [7.3.1.](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1) [LIST Response](https://www.rfc-editor.org/info/rfc9051/#name-list-response) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-7.3.1)

Contents:

-   name attributes[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-1.2.1.1)
-   hierarchy delimiter[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-1.2.1.2)
-   name[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-1.2.1.3)
-   OPTIONAL extension data[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-1.2.1.4)

The LIST response occurs as a result of a LIST command. It returns a single name that matches the LIST specification. There can be multiple LIST responses for a single LIST command.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-2)

The following base mailbox name attributes are defined:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-3)

\\NonExistent

The "\\NonExistent" attribute indicates that a mailbox name does not refer to an existing mailbox. Note that this attribute is not meaningful by itself, as mailbox names that match the canonical LIST pattern but don't exist must not be returned unless one of the two conditions listed below is also satisfied:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-4.2.1)

1.  The mailbox name also satisfies the selection criteria (for example, it is subscribed and the "SUBSCRIBED" selection option has been specified).[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-4.2.2.1)
2.  "RECURSIVEMATCH" has been specified, and the mailbox name has at least one descendant mailbox name that does not match the LIST pattern and does match the selection criteria.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-4.2.2.2)

In practice, this means that the "\\NonExistent" attribute is usually returned with one or more of "\\Subscribed", "\\Remote", "\\HasChildren", or the CHILDINFO extended data item.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-4.2.3)

The "\\NonExistent" attribute implies "\\NoSelect".[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-4.2.4)

\\Noinferiors

It is not possible for any child levels of hierarchy to exist under this name; no child levels exist now and none can be created in the future.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-4.4)

\\Noselect

It is not possible to use this name as a selectable mailbox.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-4.6)

\\HasChildren

The presence of this attribute indicates that the mailbox has child mailboxes. A server SHOULD NOT set this attribute if there are child mailboxes and the user does not have permission to access any of them. In this case, \\HasNoChildren SHOULD be used. In many cases, however, a server may not be able to efficiently compute whether a user has access to any child mailboxes. Note that even though the \\HasChildren attribute for a mailbox must be correct at the time of processing the mailbox, a client must be prepared to deal with a situation when a mailbox is marked with the \\HasChildren attribute, but no child mailbox appears in the response to the LIST command. This might happen, for example, due to child mailboxes being deleted or made inaccessible to the user (using access control) by another client before the server is able to list them.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-4.8)

\\HasNoChildren

The presence of this attribute indicates that the mailbox has NO child mailboxes that are accessible to the currently authenticated user.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-4.10)

\\Marked

The mailbox has been marked "interesting" by the server; the mailbox probably contains messages that have been added since the last time the mailbox was selected.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-4.12)

\\Unmarked

The mailbox does not contain any additional messages since the last time the mailbox was selected.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-4.14)

\\Subscribed

The mailbox name was subscribed to using the SUBSCRIBE command.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-4.16)

\\Remote

The mailbox is a remote mailbox.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-4.18)

It is an error for the server to return both a \\HasChildren and a \\HasNoChildren attribute in the same LIST response. A client that encounters a LIST response with both \\HasChildren and \\HasNoChildren attributes present should act as if both are absent in the LIST response.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-5)

Note: the \\HasNoChildren attribute should not be confused with the \\NoInferiors attribute, which indicates that no child mailboxes exist now and none can be created in the future.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-6)

If it is not feasible for the server to determine whether or not the mailbox is "interesting", the server SHOULD NOT send either \\Marked or \\Unmarked. The server MUST NOT send more than one of \\Marked, \\Unmarked, and \\Noselect for a single mailbox, and it MAY send none of these.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-7)

In addition to the base mailbox name attributes defined above, an IMAP server MAY also include any or all of the following attributes that denote "role" (or "special-use") of a mailbox. These attributes are included along with base attributes defined above. A given mailbox may have none, one, or more than one of these attributes. In some cases, a special use is advice to a client about what to put in that mailbox. In other cases, it's advice to a client about what to expect to find there.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-8)

\\All

This mailbox presents all messages in the user's message store. Implementations MAY omit some messages, such as, perhaps, those in \\Trash and \\Junk. When this special use is supported, it is almost certain to represent a virtual mailbox.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-9.2)

\\Archive

This mailbox is used to archive messages. The meaning of an "archival" mailbox is server dependent; typically, it will be used to get messages out of the inbox, or otherwise keep them out of the user's way, while still making them accessible.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-9.4)

\\Drafts

This mailbox is used to hold draft messages -- typically, messages that are being composed but have not yet been sent. In some server implementations, this might be a virtual mailbox, containing messages from other mailboxes that are marked with the "\\Draft" message flag. Alternatively, this might just be advice that a client put drafts here.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-9.6)

\\Flagged

This mailbox presents all messages marked in some way as "important". When this special use is supported, it is likely to represent a virtual mailbox collecting messages (from other mailboxes) that are marked with the "\\Flagged" message flag.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-9.8)

\\Junk

This mailbox is where messages deemed to be junk mail are held. Some server implementations might put messages here automatically. Alternatively, this might just be advice to a client-side spam filter.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-9.10)

\\Sent

This mailbox is used to hold copies of messages that have been sent. Some server implementations might put messages here automatically. Alternatively, this might just be advice that a client save sent messages here.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-9.12)

\\Trash

This mailbox is used to hold messages that have been deleted or marked for deletion. In some server implementations, this might be a virtual mailbox, containing messages from other mailboxes that are marked with the "\\Deleted" message flag. Alternatively, this might just be advice that a client that chooses not to use the IMAP "\\Deleted" model should use as its trash location. In server implementations that strictly expect the IMAP "\\Deleted" model, this special use is likely not to be supported.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-9.14)

All special-use attributes are OPTIONAL, and any given server or message store may support any combination of the attributes, or none at all. In most cases, there will likely be at most one mailbox with a given attribute for a given user, but in some server or message store implementations, it might be possible for multiple mailboxes to have the same special-use attribute.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-10)

Special-use attributes are likely to be user specific. User Adam might share his \\Sent mailbox with user Barb, but that mailbox is unlikely to also serve as Barb's \\Sent mailbox.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-11)

Other mailbox name attributes can be found in the "IMAP Mailbox Name Attributes" registry \[[IMAP-MAILBOX-NAME-ATTRS-REG](https://www.rfc-editor.org/info/rfc9051/#IMAP-MAILBOX-NAME-ATTRS-REG)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-12)

The hierarchy delimiter is a character used to delimit levels of hierarchy in a mailbox name. A client can use it to create child mailboxes and to search higher or lower levels of naming hierarchy. All children of a top-level hierarchy node MUST use the same separator character. A NIL hierarchy delimiter means that no hierarchy exists; the name is a "flat" name.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-13)

The name represents an unambiguous left-to-right hierarchy and MUST be valid for use as a reference in LIST command. Unless \\Noselect or \\NonExistent is indicated, the name MUST also be valid as an argument for commands, such as SELECT, that accept mailbox names.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-14)

The name might be followed by an OPTIONAL series of extended fields, a parenthesized list of tagged data (also referred to as an "extended data item"). The first element of an extended field is a string, which identifies the type of data. \[[RFC5258](https://www.rfc-editor.org/info/rfc9051/#RFC5258)\] specifies requirements on string registration (which are called "tags"; such tags are not to be confused with IMAP command tags); in particular, it states that "Tags MUST be registered with IANA". This document doesn't change that. See [Section 9.5](https://www.rfc-editor.org/info/rfc5258/#section-9.5) of \[[RFC5258](https://www.rfc-editor.org/info/rfc9051/#RFC5258)\] for the registration template. The server MAY return data in the extended fields that was not directly solicited by the client in the corresponding LIST command. For example, the client can enable extra extended fields by using another IMAP extension that makes use of the extended LIST responses. The client MUST ignore all extended fields it doesn't recognize.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-15)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-16)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-18)

#### [7.3.2.](https://www.rfc-editor.org/info/rfc9051/#section-7.3.2) [NAMESPACE Response](https://www.rfc-editor.org/info/rfc9051/#name-namespace-response) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-7.3.2)

Contents:

the prefix and hierarchy delimiter to the server's Personal Namespace(s), Other Users' Namespace(s), and Shared Namespace(s)[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.2-1.2)

The NAMESPACE response occurs as a result of a NAMESPACE command. It contains the prefix and hierarchy delimiter to the server's Personal Namespace(s), Other Users' Namespace(s), and Shared Namespace(s) that the server wishes to expose. The response will contain a NIL for any namespace class that is not available. The Namespace-Response-Extensions ABNF non-terminal is defined for extensibility and MAY be included in the response.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.2-2)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.2-3)

#### [7.3.3.](https://www.rfc-editor.org/info/rfc9051/#section-7.3.3) [STATUS Response](https://www.rfc-editor.org/info/rfc9051/#name-status-response) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-7.3.3)

Contents:

-   name[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.3-1.2.1.1)
-   status parenthesized list[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.3-1.2.1.2)

The STATUS response occurs as a result of a STATUS command. It returns the mailbox name that matches the STATUS specification and the requested mailbox status information.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.3-2)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.3-3)

#### [7.3.4.](https://www.rfc-editor.org/info/rfc9051/#section-7.3.4) [ESEARCH Response](https://www.rfc-editor.org/info/rfc9051/#name-esearch-response) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-7.3.4)

Contents:

one or more search-return-data pairs[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.4-1.2)

The ESEARCH response occurs as a result of a SEARCH or UID SEARCH command.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.4-2)

The ESEARCH response starts with an optional search correlator. If it is missing, then the response was not caused by a particular IMAP command, whereas if it is present, it contains the tag of the command that caused the response to be returned.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.4-3)

The search correlator is followed by an optional UID indicator. If this indicator is present, all data in the ESEARCH response refers to UIDs; otherwise, all returned data refers to message numbers.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.4-4)

The rest of the ESEARCH response contains one or more search data pairs. Each pair starts with a unique return item name, followed by a space and the corresponding data. Search data pairs may be returned in any order. Unless otherwise specified by an extension, any return item name SHOULD appear only once in an ESEARCH response.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.4-5)

This document specifies the following return item names:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.4-6)

MIN

Returns the lowest message number/UID that satisfies the SEARCH criteria.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.4-7.2.1)

If the SEARCH results in no matches, the server MUST NOT include the MIN return item in the ESEARCH response; however, it still MUST send the ESEARCH response.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.4-7.2.2)

MAX

Returns the highest message number/UID that satisfies the SEARCH criteria.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.4-7.4.1)

If the SEARCH results in no matches, the server MUST NOT include the MAX return item in the ESEARCH response; however, it still MUST send the ESEARCH response.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.4-7.4.2)

ALL

Returns all message numbers/UIDs that satisfy the SEARCH criteria using the sequence-set syntax. Each set MUST be complete; in particular, a UID set is returned in an ESEARCH response only when each number in the range corresponds to an existing (matching) message. The client MUST NOT assume that messages/UIDs will be listed in any particular order.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.4-7.6.1)

If the SEARCH results in no matches, the server MUST NOT include the ALL return item in the ESEARCH response; however, it still MUST send the ESEARCH response.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.4-7.6.2)

COUNT

Returns the number of messages that satisfy the SEARCH criteria. This return item MUST always be included in the ESEARCH response.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.4-7.8)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.4-8)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.4-10)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.4-12)

#### [7.3.5.](https://www.rfc-editor.org/info/rfc9051/#section-7.3.5) [FLAGS Response](https://www.rfc-editor.org/info/rfc9051/#name-flags-response) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-7.3.5)

Contents:

flag parenthesized list[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.5-1.2)

The FLAGS response occurs as a result of a SELECT or EXAMINE command. The flag parenthesized list identifies the flags (at a minimum, the system-defined flags) that are applicable for this mailbox. Flags other than the system flags can also exist, depending on server implementation.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.5-2)

The update from the FLAGS response MUST be remembered by the client.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.5-3)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.3.5-4)

### [7.4.](https://www.rfc-editor.org/info/rfc9051/#section-7.4) [Server Responses - Mailbox Size](https://www.rfc-editor.org/info/rfc9051/#name-server-responses-mailbox-si) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-7.4)

These responses are always untagged. This is how changes in the size of the mailbox are transmitted from the server to the client. Immediately following the "\*" token is a number that represents a message count.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.4-1)

#### [7.4.1.](https://www.rfc-editor.org/info/rfc9051/#section-7.4.1) [EXISTS Response](https://www.rfc-editor.org/info/rfc9051/#name-exists-response) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-7.4.1)

Contents:

none[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.4.1-1.2)

The EXISTS response reports the number of messages in the mailbox. This response occurs as a result of a SELECT or EXAMINE command and if the size of the mailbox changes (e.g., new messages).[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.4.1-2)

The update from the EXISTS response MUST be remembered by the client.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.4.1-3)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.4.1-4)

### [7.5.](https://www.rfc-editor.org/info/rfc9051/#section-7.5) [Server Responses - Message Status](https://www.rfc-editor.org/info/rfc9051/#name-server-responses-message-st) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-7.5)

These responses are always untagged. This is how message data are transmitted from the server to the client, often as a result of a command with the same name. Immediately following the "\*" token is a number that represents a message sequence number.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5-1)

#### [7.5.1.](https://www.rfc-editor.org/info/rfc9051/#section-7.5.1) [EXPUNGE Response](https://www.rfc-editor.org/info/rfc9051/#name-expunge-response) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-7.5.1)

Contents:

none[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.1-1.2)

The EXPUNGE response reports that the specified message sequence number has been permanently removed from the mailbox. The message sequence number for each successive message in the mailbox is immediately decremented by 1, and this decrement is reflected in message sequence numbers in subsequent responses (including other untagged EXPUNGE responses).[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.1-2)

The EXPUNGE response also decrements the number of messages in the mailbox; it is not necessary to send an EXISTS response with the new value.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.1-3)

As a result of the immediate decrement rule, message sequence numbers that appear in a set of successive EXPUNGE responses depend upon whether the messages are removed starting from lower numbers to higher numbers, or from higher numbers to lower numbers. For example, if the last 5 messages in a 9-message mailbox are expunged, a "lower to higher" server will send five untagged EXPUNGE responses for message sequence number 5, whereas a "higher to lower" server will send successive untagged EXPUNGE responses for message sequence numbers 9, 8, 7, 6, and 5.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.1-4)

An EXPUNGE response MUST NOT be sent when no command is in progress, nor while responding to a FETCH, STORE, or SEARCH command. This rule is necessary to prevent a loss of synchronization of message sequence numbers between client and server. A command is not "in progress" until the complete command has been received; in particular, a command is not "in progress" during the negotiation of command continuation.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.1-5)

Note: UID FETCH, UID STORE, and UID SEARCH are different commands from FETCH, STORE, and SEARCH. An EXPUNGE response MAY be sent during a UID command.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.1-6)

The update from the EXPUNGE response MUST be remembered by the client.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.1-7)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.1-8)

#### [7.5.2.](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2) [FETCH Response](https://www.rfc-editor.org/info/rfc9051/#name-fetch-response) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-7.5.2)

Contents:

message data[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-1.2)

The FETCH response returns data about a message to the client. The data are pairs of data item names, and their values are in parentheses. This response occurs as the result of a FETCH or STORE command, as well as by a unilateral server decision (e.g., flag updates).[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-2)

The current data items are:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-3)

BINARY\[<section-binary>\]<<number>>

An <nstring> or <literal8> expressing the content of the specified section after removing any encoding specified in the corresponding Content-Transfer-Encoding header field. If <number> is present, it refers to the offset within the DECODED section data.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.2.1)

If the domain of the decoded data is "8bit" and the data does not contain the NUL octet, the server SHOULD return the data in a <string> instead of a <literal8>; this allows the client to determine if the "8bit" data contains the NUL octet without having to explicitly scan the data stream for NULs.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.2.2)

Messaging clients and servers have been notoriously lax in their adherence to the Internet CRLF convention for terminating lines of textual data (text/\* media types) in Internet protocols. When sending data in a BINARY\[...\] FETCH data item, servers MUST ensure that textual line-oriented sections are always transmitted using the IMAP CRLF line termination syntax, regardless of the underlying storage representation of the data on the server.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.2.3)

If the server does not know how to decode the section's Content-Transfer-Encoding, it MUST fail the request and issue a "NO" response that contains the "UNKNOWN-CTE" response code.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.2.4)

BINARY.SIZE\[<section-binary>\]

The size of the section after removing any encoding specified in the corresponding Content-Transfer-Encoding header field. The value returned MUST match the size of the <nstring> or <literal8> that will be returned by the corresponding FETCH BINARY request.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.4.1)

If the server does not know how to decode the section's Content-Transfer-Encoding, it MUST fail the request and issue a "NO" response that contains the "UNKNOWN-CTE" response code.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.4.2)

BODY

A form of BODYSTRUCTURE without extension data.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.6)

BODY\[<section>\]<<origin octet>>

A string expressing the body contents of the specified section. The string SHOULD be interpreted by the client according to the content transfer encoding, body type, and subtype.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.8.1)

If the origin octet is specified, this string is a substring of the entire body contents, starting at that origin octet. This means that BODY\[\]<0> MAY be truncated, but BODY\[\] is NEVER truncated.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.8.2)

Note: The origin octet facility MUST NOT be used by a server in a FETCH response unless the client specifically requested it by means of a FETCH of a BODY\[<section>\]<<partial>> data item.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.8.3)

8-bit textual data is permitted if a \[[CHARSET](https://www.rfc-editor.org/info/rfc9051/#RFC2978)\] identifier is part of the body parameter parenthesized list for this section. Note that headers (part specifiers HEADER or MIME, or the header portion of a MESSAGE/RFC822 or MESSAGE/GLOBAL part) MAY be in UTF-8. Note also that the \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] delimiting blank line between the header and the body is not affected by header-line subsetting; the blank line is always included as part of the header data, except in the case of a message that has no body and no blank line.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.8.4)

Non-textual data such as binary data MUST be transfer encoded into a textual form, such as base64, prior to being sent to the client. To derive the original binary data, the client MUST decode the transfer-encoded string.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.8.5)

BODYSTRUCTURE

A parenthesized list that describes the \[[MIME-IMB](https://www.rfc-editor.org/info/rfc9051/#RFC2045)\] body structure of a message. This is computed by the server by parsing the \[[MIME-IMB](https://www.rfc-editor.org/info/rfc9051/#RFC2045)\] header fields, defaulting various fields as necessary.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.10.1)

For example, a simple text message of 48 lines and 2279 octets can have a body structure of:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.10.2)

Multiple parts are indicated by parenthesis nesting. Instead of a body type as the first element of the parenthesized list, there is a sequence of one or more nested body structures. The second element of the parenthesized list is the multipart subtype (mixed, digest, parallel, alternative, etc.).[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.10.4)

For example, a two-part message consisting of a text and a base64-encoded text attachment can have a body structure of:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.10.5)

Extension data follows the multipart subtype. Extension data is never returned with the BODY fetch but can be returned with a BODYSTRUCTURE fetch. Extension data, if present, MUST be in the defined order. The extension data of a multipart body part are in the following order:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.10.7)

body parameter parenthesized list

A parenthesized list of attribute/value pairs (e.g., ("foo" "bar" "baz" "rag") where "bar" is the value of "foo", and "rag" is the value of "baz") as defined in \[[MIME-IMB](https://www.rfc-editor.org/info/rfc9051/#RFC2045)\]. Servers SHOULD decode parameter-value continuations and parameter-value character sets as described in \[[RFC2231](https://www.rfc-editor.org/info/rfc9051/#RFC2231)\], for example, if the message contains parameters "baz\*0", "baz\*1", and "baz\*2", the server should decode them per \[[RFC2231](https://www.rfc-editor.org/info/rfc9051/#RFC2231)\], concatenate, and return the resulting value as a parameter "baz". Similarly, if the message contains parameters "foo\*0\*" and "foo\*1\*", the server should decode them per \[[RFC2231](https://www.rfc-editor.org/info/rfc9051/#RFC2231)\], convert to UTF-8, concatenate, and return the resulting value as a parameter "foo\*".[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.12)

body disposition

A parenthesized list, consisting of a disposition type string, followed by a parenthesized list of disposition attribute/value pairs as defined in \[[DISPOSITION](https://www.rfc-editor.org/info/rfc9051/#RFC2183)\]. Servers SHOULD decode parameter-value continuations as described in \[[RFC2231](https://www.rfc-editor.org/info/rfc9051/#RFC2231)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.14)

body language

A string or parenthesized list giving the body language value as defined in \[[LANGUAGE-TAGS](https://www.rfc-editor.org/info/rfc9051/#RFC3282)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.16)

body location

A string giving the body content URI as defined in \[[LOCATION](https://www.rfc-editor.org/info/rfc9051/#RFC2557)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.18.1)

Any following extension data are not yet defined in this version of the protocol. Such extension data can consist of zero or more NILs, strings, numbers, or potentially nested parenthesized lists of such data. Client implementations that do a BODYSTRUCTURE fetch MUST be prepared to accept such extension data. Server implementations MUST NOT send such extension data until it has been defined by a revision of this protocol.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.18.2)

The basic fields of a non-multipart body part are in the following order:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.18.3)

body type

A string giving the content media-type name as defined in \[[MIME-IMB](https://www.rfc-editor.org/info/rfc9051/#RFC2045)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.20)

body subtype

A string giving the content subtype name as defined in \[[MIME-IMB](https://www.rfc-editor.org/info/rfc9051/#RFC2045)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.22)

body parameter parenthesized list

A parenthesized list of attribute/value pairs (e.g., ("foo" "bar" "baz" "rag") where "bar" is the value of "foo", and "rag" is the value of "baz") as defined in \[[MIME-IMB](https://www.rfc-editor.org/info/rfc9051/#RFC2045)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.24)

body id

A string giving the Content-ID header field value as defined in [Section 7](https://www.rfc-editor.org/info/rfc2045/#section-7) of \[[MIME-IMB](https://www.rfc-editor.org/info/rfc9051/#RFC2045)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.26)

body description

A string giving the Content-Description header field value as defined in [Section 8](https://www.rfc-editor.org/info/rfc2045/#section-8) of \[[MIME-IMB](https://www.rfc-editor.org/info/rfc9051/#RFC2045)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.28)

body encoding

A string giving the content transfer encoding as defined in [Section 6](https://www.rfc-editor.org/info/rfc2045/#section-6) of \[[MIME-IMB](https://www.rfc-editor.org/info/rfc9051/#RFC2045)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.30)

body size

A number giving the size of the body in octets. Note that this size is the size in its transfer encoding and not the resulting size after any decoding.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.32.1)

A body type of type MESSAGE and subtype RFC822 contains, immediately after the basic fields, the envelope structure, body structure, and size in text lines of the encapsulated message.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.32.2)

A body type of type TEXT contains, immediately after the basic fields, the size of the body in text lines. Note that this size is the size in its content transfer encoding and not the resulting size after any decoding.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.32.3)

Extension data follows the basic fields and the type-specific fields listed above. Extension data is never returned with the BODY fetch but can be returned with a BODYSTRUCTURE fetch. Extension data, if present, MUST be in the defined order.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.32.4)

The extension data of a non-multipart body part are in the following order:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.32.5)

body MD5

A string giving the body MD5 value as defined in \[[MD5](https://www.rfc-editor.org/info/rfc9051/#RFC1864)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.34)

body disposition

A parenthesized list with the same content and function as the body disposition for a multipart body part.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.36)

body language

A string or parenthesized list giving the body language value as defined in \[[LANGUAGE-TAGS](https://www.rfc-editor.org/info/rfc9051/#RFC3282)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.38)

body location

A string giving the body content URI as defined in \[[LOCATION](https://www.rfc-editor.org/info/rfc9051/#RFC2557)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.40.1)

Any following extension data are not yet defined in this version of the protocol and would be as described above under multipart extension data.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.40.2)

ENVELOPE

A parenthesized list that describes the envelope structure of a message. This is computed by the server by parsing the \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] header into the component parts, defaulting various fields as necessary.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.42.1)

The fields of the envelope structure are in the following order: date, subject, from, sender, reply-to, to, cc, bcc, in-reply-to, and message-id. The date, subject, in-reply-to, and message-id fields are strings. The from, sender, reply-to, to, cc, and bcc fields are parenthesized lists of address structures.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.42.2)

An address structure is a parenthesized list that describes an electronic mail address. The fields of an address structure are in the following order: display name, \[[SMTP](https://www.rfc-editor.org/info/rfc9051/#RFC5321)\] at-domain-list (source route and obs-route ABNF production from \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\]), mailbox name (local-part ABNF production from \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\]), and hostname.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.42.3)

\[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] group syntax is indicated by a special form of address structure in which the hostname field is NIL. If the mailbox name field is also NIL, this is an end-of-group marker (semicolon in RFC 822 syntax). If the mailbox name field is non-NIL, this is the start of a group marker, and the mailbox name field holds the group name phrase.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.42.4)

If the Date, Subject, In-Reply-To, and Message-ID header fields are absent in the \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] header, the corresponding member of the envelope is NIL; if these header fields are present but empty, the corresponding member of the envelope is the empty string.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.42.5)

Note: some servers may return a NIL envelope member in the "present but empty" case. Clients SHOULD treat NIL and the empty string as identical.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.42.6)

Note: \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] requires that all messages have a valid Date header field. Therefore, for a well-formed message, the date member in the envelope cannot be NIL or the empty string. However, it can be NIL for a malformed or draft message.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.42.7)

Note: \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] requires that the In-Reply-To and Message-ID header fields, if present, have non-empty content. Therefore, for a well-formed message, the in-reply-to and message-id members in the envelope cannot be the empty string. However, they can still be the empty string for a malformed message.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.42.8)

If the From, To, Cc, and Bcc header fields are absent in the \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] header, or are present but empty, the corresponding member of the envelope is NIL.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.42.9)

If the Sender or Reply-To header fields are absent in the \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] header, or are present but empty, the server sets the corresponding member of the envelope to be the same value as the from member (the client is not expected to know how to do this).[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.42.10)

Note: \[[RFC5322](https://www.rfc-editor.org/info/rfc9051/#RFC5322)\] requires that all messages have a valid From header field. Therefore, for a well-formed message, the from, sender, and reply-to members in the envelope cannot be NIL. However, they can be NIL for a malformed or draft message.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.42.11)

FLAGS

A parenthesized list of flags that are set for this message.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.44)

INTERNALDATE

A string representing the internal date of the message.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.46)

RFC822.SIZE

A number expressing the size of a message, as described in [Section 2.3.4](https://www.rfc-editor.org/info/rfc9051/#RFC822.SIZE_message_attribute).[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.48)

UID

A number expressing the unique identifier of the message.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.50)

If the server chooses to send unsolicited FETCH responses, they MUST include UID FETCH item. Note that this is a new requirement when compared to \[[RFC3501](https://www.rfc-editor.org/info/rfc9051/#RFC3501)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-5)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-6)

### [7.6.](https://www.rfc-editor.org/info/rfc9051/#section-7.6) [Server Responses - Command Continuation Request](https://www.rfc-editor.org/info/rfc9051/#name-server-responses-command-co) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-7.6)

The command continuation request response is indicated by a "+" token instead of a tag. This form of response indicates that the server is ready to accept the continuation of a command from the client. The remainder of this response is a line of text.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.6-1)

This response is used in the AUTHENTICATE command to transmit server data to the client and request additional client data. This response is also used if an argument to any command is a synchronizing literal.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.6-2)

The client is not permitted to send the octets of the synchronizing literal unless the server indicates that it is expected. This permits the server to process commands and reject errors on a line-by-line basis. The remainder of the command, including the CRLF that terminates a command, follows the octets of the literal. If there are any additional command arguments, the literal octets are followed by a space and those arguments.[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.6-3)

Example:[¶](https://www.rfc-editor.org/info/rfc9051/#section-7.6-4)

## [8\.](https://www.rfc-editor.org/info/rfc9051/#section-8) [Sample IMAP4rev2 Connection](https://www.rfc-editor.org/info/rfc9051/#name-sample-imap4rev2-connection) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-8)

The following is a transcript of an IMAP4rev2 connection on a non-TLS port. A long line in this sample is broken for editorial clarity.[¶](https://www.rfc-editor.org/info/rfc9051/#section-8-1)

## [9\.](https://www.rfc-editor.org/info/rfc9051/#section-9) [Formal Syntax](https://www.rfc-editor.org/info/rfc9051/#name-formal-syntax) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-9)

The following syntax specification uses the Augmented Backus-Naur Form (ABNF) notation as specified in \[[ABNF](https://www.rfc-editor.org/info/rfc9051/#RFC5234)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-9-1)

In the case of alternative or optional rules in which a later rule overlaps an earlier rule, the rule that is listed earlier MUST take priority. For example, "\\Seen" when parsed as a flag is the \\Seen flag name and not a flag-extension, even though "\\Seen" can be parsed as a flag-extension. Some, but not all, instances of this rule are noted below.[¶](https://www.rfc-editor.org/info/rfc9051/#section-9-2)

Note: \[[ABNF](https://www.rfc-editor.org/info/rfc9051/#RFC5234)\] rules MUST be followed strictly; in particular:[¶](https://www.rfc-editor.org/info/rfc9051/#section-9-3)

1.  Unless otherwise noted, all alphabetic characters are case insensitive. The use of uppercase or lowercase characters to define token strings is for editorial clarity only. Implementations MUST accept these strings in a case-insensitive fashion.[¶](https://www.rfc-editor.org/info/rfc9051/#section-9-4.1)
2.  In all cases, SP refers to exactly one space. It is NOT permitted to substitute TAB, insert additional spaces, or otherwise treat SP as being equivalent to linear whitespace (LWSP).[¶](https://www.rfc-editor.org/info/rfc9051/#section-9-4.2)
3.  The ASCII NUL character, %x00, MUST NOT be used anywhere, with the exception of the OCTET production.[¶](https://www.rfc-editor.org/info/rfc9051/#section-9-4.3)

This document is a revision or rewrite of earlier documents and supercedes the protocol specification in those documents: \[[RFC3501](https://www.rfc-editor.org/info/rfc9051/#RFC3501)\], \[[RFC2060](https://www.rfc-editor.org/info/rfc9051/#RFC2060)\], \[[RFC1730](https://www.rfc-editor.org/info/rfc9051/#RFC1730)\], unpublished IMAP2bis.TXT document, \[[IMAP2](https://www.rfc-editor.org/info/rfc9051/#RFC1176)\], and \[[RFC1064](https://www.rfc-editor.org/info/rfc9051/#RFC1064)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-10-1)

## [11\.](https://www.rfc-editor.org/info/rfc9051/#section-11) [Security Considerations](https://www.rfc-editor.org/info/rfc9051/#name-security-considerations) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-11)

IMAP4rev2 protocol transactions, including electronic mail data, are sent in the clear over the network, exposing them to possible eavesdropping and manipulation unless protection is negotiated. This can be accomplished by use of the Implicit TLS port, the STARTTLS command, negotiated confidentiality protection in the AUTHENTICATE command, or some other protection mechanism.[¶](https://www.rfc-editor.org/info/rfc9051/#section-11-1)

This section applies to use of both the STARTTLS command and the Implicit TLS port.[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.1-1)

IMAP client and server implementations MUST comply with relevant TLS recommendations from \[[RFC8314](https://www.rfc-editor.org/info/rfc9051/#RFC8314)\]. If recommendations/requirements in this document conflict with recommendations from \[[RFC8314](https://www.rfc-editor.org/info/rfc9051/#RFC8314)\], for example in regards to TLS ciphersuites, recommendations from this document take precedence.[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.1-2)

Clients and servers MUST implement [TLS 1.2](https://www.rfc-editor.org/info/rfc9051/#RFC5246) \[[TLS-1.2](https://www.rfc-editor.org/info/rfc9051/#RFC5246)\] or newer. Use of TLS 1.3 \[[TLS-1.3](https://www.rfc-editor.org/info/rfc9051/#RFC8446)\] is RECOMMENDED. TLS 1.2 may be used only in cases where the other party has not yet implemented TLS 1.3. Additionally, when using TLS 1.2, IMAP implementations MUST implement the TLS\_ECDHE\_RSA\_WITH\_AES\_128\_GCM\_SHA256 cipher suite. This is important as it ensures that any two compliant implementations can be configured to interoperate. Other TLS cipher suites recommended in RFC 7525 \[[RFC7525](https://www.rfc-editor.org/info/rfc9051/#RFC7525)\] are RECOMMENDED: TLS\_DHE\_RSA\_WITH\_AES\_128\_GCM\_SHA256, TLS\_DHE\_RSA\_WITH\_AES\_256\_GCM\_SHA384, and TLS\_ECDHE\_RSA\_WITH\_AES\_256\_GCM\_SHA384. All other cipher suites are OPTIONAL. Note that this is a change from [Section 2.1](https://www.rfc-editor.org/info/rfc2595/#section-2.1) of \[[IMAP-TLS](https://www.rfc-editor.org/info/rfc9051/#RFC2595)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.1-3)

The list of mandatory-to-implement TLS 1.3 cipher suites is described in [Section 9.1](https://www.rfc-editor.org/info/rfc8446/#section-9.1) of \[[TLS-1.3](https://www.rfc-editor.org/info/rfc9051/#RFC8446)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.1-4)

During the TLS negotiation \[[TLS-1.3](https://www.rfc-editor.org/info/rfc9051/#RFC8446)\] \[[TLS-1.2](https://www.rfc-editor.org/info/rfc9051/#RFC5246)\], the client MUST check its understanding of the server hostname against the server's identity as presented in the server Certificate message, in order to prevent on-path attackers attempting to masquerade as the server. This procedure is described in \[[RFC7817](https://www.rfc-editor.org/info/rfc9051/#RFC7817)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.1-5)

Both the client and server MUST check the result of the STARTTLS command and subsequent TLS \[[TLS-1.3](https://www.rfc-editor.org/info/rfc9051/#RFC8446)\] \[[TLS-1.2](https://www.rfc-editor.org/info/rfc9051/#RFC5246)\] negotiation to see whether acceptable authentication and/or privacy was achieved.[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.1-6)

### [11.2.](https://www.rfc-editor.org/info/rfc9051/#section-11.2) [STARTTLS Command versus Use of Implicit TLS Port](https://www.rfc-editor.org/info/rfc9051/#name-starttls-command-versus-use) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-11.2)

For maximum backward compatibility, the client MUST implement both TLS negotiation on an Implicit TLS port and TLS negotiation using the STARTTLS command on a cleartext port.[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.2-1)

The server MUST implement TLS negotiation on an Implicit TLS port. The server SHOULD also implement IMAP on a cleartext port. If the server listens on a cleartext port, it MUST allow the STARTTLS command on it.[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.2-2)

Some site/firewall maintainers insist on TLS site-wide and prefer not to rely on a configuration option in each higher-level protocol. For this reason, IMAP4rev2 clients SHOULD try both ports 993 and 143 (and both IPv4 and IPv6) concurrently by default, unless overridden by either user configuration or DNS SRV records \[[RFC6186](https://www.rfc-editor.org/info/rfc9051/#RFC6186)\]. A good algorithm for implementing such concurrent connect is described in \[[RFC8305](https://www.rfc-editor.org/info/rfc9051/#RFC8305)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.2-3)

### [11.3.](https://www.rfc-editor.org/info/rfc9051/#section-11.3) [Client Handling of Unsolicited Responses Not Suitable for the Current Connection State](https://www.rfc-editor.org/info/rfc9051/#name-client-handling-of-unsolici) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-11.3)

Cleartext mail transmission (whether caused by firewall configuration errors that result in TLS stripping or weak security policies in email clients that choose not to negotiate TLS in the first place) can enable injection of responses that can confuse or even cause crashes in email clients. The following measures are recommended to minimize damage from them.[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.3-1)

-   See [Section 7.1.4](https://www.rfc-editor.org/info/rfc9051/#preauth-resp) for special security considerations related to the PREAUTH response.[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.3-2.1)
-   Many server responses and response codes are only meaningful in authenticated or even selected state. However, nothing prevents a server (or an on-path attacker) from sending such invalid responses in cleartext before STARTTLS/AUTHENTICATE commands are issued. Before authentication, clients SHOULD ignore any responses other than CAPABILITY and server status responses ([Section 7.1](https://www.rfc-editor.org/info/rfc9051/#server-status-responses)), as well as any response codes other than CAPABILITY. (In particular, some email clients are known to incorrectly process LIST responses received before authentication, or FETCH responses when no mailbox is selected.) Clients SHOULD ignore the ALERT response code until after TLS (whether using STARTTLS or TLS negotiation on an Implicit TLS port) or a SASL security layer with confidentiality protection has been successfully negotiated. Unless explicitly allowed by an IMAP extension, when not in selected state, clients MUST ignore responses / response codes related to message and mailbox status such as FLAGS, EXIST, EXPUNGE, and FETCH.[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.3-2.2)

### [11.4.](https://www.rfc-editor.org/info/rfc9051/#section-11.4) [COPYUID and APPENDUID Response Codes](https://www.rfc-editor.org/info/rfc9051/#name-copyuid-and-appenduid-respo) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-11.4)

The COPYUID and APPENDUID response codes return information about the mailbox, which may be considered sensitive if the mailbox has permissions set that permit the client to COPY or APPEND to the mailbox, but not SELECT or EXAMINE it.[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.4-1)

Consequently, these response codes SHOULD NOT be issued if the client does not have access to SELECT or EXAMINE the mailbox.[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.4-2)

### [11.5.](https://www.rfc-editor.org/info/rfc9051/#section-11.5) [LIST Command and Other Users' Namespace](https://www.rfc-editor.org/info/rfc9051/#name-list-command-and-other-user) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-11.5)

In response to a LIST command containing an argument of the Other Users' Namespace prefix, a server MUST NOT list users that have not granted list access to their personal mailboxes to the currently authenticated user. Providing such a list could compromise security by potentially disclosing confidential information of who is located on the server or providing a starting point for a list of user accounts to attack.[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.5-1)

### [11.6.](https://www.rfc-editor.org/info/rfc9051/#section-11.6) [Use of MD5](https://www.rfc-editor.org/info/rfc9051/#name-use-of-md5) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-11.6)

The BODYSTRUCTURE FETCH data item can contain the MD5 digest of the message body in the "body MD5" field (body-fld-md5 ABNF production). While MD5 is no longer considered a secure cryptographic hash \[[RFC6151](https://www.rfc-editor.org/info/rfc9051/#RFC6151)\], this field is used solely to expose the value of the Content-MD5 header field (if present in the original message), which is just a message integrity check and is not used for cryptographic purposes. Also note that other mechanisms that provide message integrity checks were defined since RFC 1864 \[[MD5](https://www.rfc-editor.org/info/rfc9051/#RFC1864)\] was published and are now more commonly used than Content-MD5. Two such mechanisms are the DKIM-Signature header field \[[RFC6376](https://www.rfc-editor.org/info/rfc9051/#RFC6376)\] and S/MIME signing \[[RFC8550](https://www.rfc-editor.org/info/rfc9051/#RFC8550)\] \[[RFC8551](https://www.rfc-editor.org/info/rfc9051/#RFC8551)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.6-1)

### [11.7.](https://www.rfc-editor.org/info/rfc9051/#section-11.7) [Other Security Considerations](https://www.rfc-editor.org/info/rfc9051/#name-other-security-consideratio) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-11.7)

A server error message for an AUTHENTICATE command that fails due to invalid credentials SHOULD NOT detail why the credentials are invalid.[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.7-1)

Use of the LOGIN command sends passwords in the clear. This can be avoided by using the AUTHENTICATE command with a \[[SASL](https://www.rfc-editor.org/info/rfc9051/#RFC4422)\] mechanism that does not use plaintext passwords, by first negotiating encryption via STARTTLS or some other protection mechanism.[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.7-2)

A server implementation MUST implement a configuration that, at the time of authentication, requires:[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.7-3)

1.  The STARTTLS command has been negotiated or TLS negotiated on an Implicit TLS port[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.7-4.1.1)
    
    OR[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.7-4.1.2)
    
2.  Some other mechanism that protects the session from password snooping has been provided[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.7-4.2.1)
    
    OR[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.7-4.2.2)
    
3.  The following measures are in place:[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.7-4.3.1)
    
    a)
    
    The LOGINDISABLED capability is advertised, and \[[SASL](https://www.rfc-editor.org/info/rfc9051/#RFC4422)\] mechanisms (such as PLAIN) using plaintext passwords are NOT advertised in the CAPABILITY list.[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.7-4.3.2.1.1)
    
    AND[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.7-4.3.2.1.2)
    
    b)
    
    The LOGIN command returns an error even if the password is correct[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.7-4.3.2.2.1)
    
    AND[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.7-4.3.2.2.2)
    
    c)
    
    The AUTHENTICATE command returns an error with all \[[SASL](https://www.rfc-editor.org/info/rfc9051/#RFC4422)\] mechanisms that use plaintext passwords, even if the password is correct.[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.7-4.3.2.3.1)
    

A server error message for a failing LOGIN command SHOULD NOT specify that the user name, as opposed to the password, is invalid.[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.7-5)

A server SHOULD have mechanisms in place to limit or delay failed AUTHENTICATE/LOGIN attempts.[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.7-6)

A server SHOULD report any authentication failure and analyze such authentication failure attempts with regard to a password brute-force attack as well as a password spraying attack \[[NCSC](https://www.rfc-editor.org/info/rfc9051/#NCSC)\]. Accounts with passwords that match well-known passwords from spraying attacks MUST be blocked, and users associated with such accounts must be requested to change their passwords. Only a password with significant strength SHOULD be accepted.[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.7-7)

Additional security considerations are discussed in the sections that define the AUTHENTICATE and LOGIN commands (see Sections [6.2.2](https://www.rfc-editor.org/info/rfc9051/#authenticate) and [6.2.3](https://www.rfc-editor.org/info/rfc9051/#login), respectively).[¶](https://www.rfc-editor.org/info/rfc9051/#section-11.7-8)

## [12\.](https://www.rfc-editor.org/info/rfc9051/#section-12) [IANA Considerations](https://www.rfc-editor.org/info/rfc9051/#name-iana-considerations) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-12)

IANA has updated the "Service Names and Transport Protocol Port Numbers" registry as follows:[¶](https://www.rfc-editor.org/info/rfc9051/#section-12-1)

1.  Registration for TCP port 143 and the corresponding "imap" service name have been updated to point to this document and \[[RFC3501](https://www.rfc-editor.org/info/rfc9051/#RFC3501)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-12-2.1)
2.  Registration for TCP port 993 and the corresponding "imaps" service name have been updated to point to this document, \[[RFC8314](https://www.rfc-editor.org/info/rfc9051/#RFC8314)\], and \[[RFC3501](https://www.rfc-editor.org/info/rfc9051/#RFC3501)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-12-2.2)
3.  UDP ports 143 and 993 have both been marked as "Reserved" in the registry.[¶](https://www.rfc-editor.org/info/rfc9051/#section-12-2.3)

Additional IANA actions are specified in the subsections that follow.[¶](https://www.rfc-editor.org/info/rfc9051/#section-12-3)

### [12.1.](https://www.rfc-editor.org/info/rfc9051/#section-12.1) [Updates to IMAP Capabilities Registry](https://www.rfc-editor.org/info/rfc9051/#name-updates-to-imap-capabilitie) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-12.1)

IMAP4 capabilities are registered by publishing a Standards Track or IESG-approved Informational or Experimental RFC. The registry is currently located at: <https://www.iana.org/assignments/imap4-capabilities>[¶](https://www.rfc-editor.org/info/rfc9051/#section-12.1-1)

As this specification revises the AUTH= prefix, STARTTLS, and LOGINDISABLED extensions, IANA has updated registry entries for these 3 extensions to point to this document and \[[RFC3501](https://www.rfc-editor.org/info/rfc9051/#RFC3501)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-12.1-2)

### [12.2.](https://www.rfc-editor.org/info/rfc9051/#section-12.2) [GSSAPI/SASL Service Name](https://www.rfc-editor.org/info/rfc9051/#name-gssapi-sasl-service-name) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-12.2)

GSSAPI/Kerberos/SASL service names are registered by publishing a Standards Track or IESG-approved Experimental RFC. The registry is currently located at: <https://www.iana.org/assignments/gssapi-service-names>[¶](https://www.rfc-editor.org/info/rfc9051/#section-12.2-1)

IANA has updated the "imap" service name previously registered in \[[RFC3501](https://www.rfc-editor.org/info/rfc9051/#RFC3501)\] to point to both this document and \[[RFC3501](https://www.rfc-editor.org/info/rfc9051/#RFC3501)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-12.2-2)

### [12.3.](https://www.rfc-editor.org/info/rfc9051/#section-12.3) [LIST Selection Options, LIST Return Options, and LIST Extended Data Items](https://www.rfc-editor.org/info/rfc9051/#name-list-selection-options-list) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-12.3)

\[[RFC5258](https://www.rfc-editor.org/info/rfc9051/#RFC5258)\] specifies IANA registration procedures for LIST selection options, LIST return options, and LIST extended data items. This document doesn't change these registration procedures. In particular, LIST selection options ([Section 6.3.9.1](https://www.rfc-editor.org/info/rfc9051/#list-select-options)) and LIST return options ([Section 6.3.9.2](https://www.rfc-editor.org/info/rfc9051/#list-return-options)) are registered using the procedure specified in [Section 9](https://www.rfc-editor.org/info/rfc5258/#section-9) of \[[RFC5258](https://www.rfc-editor.org/info/rfc9051/#RFC5258)\] (and using the registration template from [Section 9.3](https://www.rfc-editor.org/info/rfc5258/#section-9.3) of \[[RFC5258](https://www.rfc-editor.org/info/rfc9051/#RFC5258)\]). LIST extended data items are registered using the registration template from [Section 9.6](https://www.rfc-editor.org/info/rfc5258/#section-9.6) of \[[RFC5258](https://www.rfc-editor.org/info/rfc9051/#RFC5258)\]).[¶](https://www.rfc-editor.org/info/rfc9051/#section-12.3-1)

IANA has added a reference to RFC 9051 for the "OLDNAME" LIST-EXTENDED extended data item entry. This is in addition to the existing reference to \[[RFC5465](https://www.rfc-editor.org/info/rfc9051/#RFC5465)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-12.3-2)

### [12.4.](https://www.rfc-editor.org/info/rfc9051/#section-12.4) [IMAP Mailbox Name Attributes and IMAP Response Codes](https://www.rfc-editor.org/info/rfc9051/#name-imap-mailbox-name-attribute) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-12.4)

IANA has updated the "IMAP Mailbox Name Attributes" registry to point to this document in addition to \[[RFC3501](https://www.rfc-editor.org/info/rfc9051/#RFC3501)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-12.4-1)

IANA has updated the "IMAP Response Codes" registry to point to this document in addition to \[[RFC3501](https://www.rfc-editor.org/info/rfc9051/#RFC3501)\].[¶](https://www.rfc-editor.org/info/rfc9051/#section-12.4-2)

## [13\.](https://www.rfc-editor.org/info/rfc9051/#section-13) [References](https://www.rfc-editor.org/info/rfc9051/#name-references) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-13)

### [13.1.](https://www.rfc-editor.org/info/rfc9051/#section-13.1) [Normative References](https://www.rfc-editor.org/info/rfc9051/#name-normative-references) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-13.1)

\[ABNF\]

Crocker, D., Ed. and P. Overell, "Augmented BNF for Syntax Specifications: ABNF", STD 68, RFC 5234, DOI 10.17487/RFC5234, January 2008, <[https://www.rfc-editor.org/info/rfc5234](https://www.rfc-editor.org/info/rfc5234)\>.

\[BCP178\]

Saint-Andre, P., Crocker, D., and M. Nottingham, "Deprecating the "X-" Prefix and Similar Constructs in Application Protocols", BCP 178, RFC 6648, June 2012.

<[https://www.rfc-editor.org/info/bcp178](https://www.rfc-editor.org/info/bcp178)\>

\[CHARSET\]

Freed, N. and J. Postel, "IANA Charset Registration Procedures", BCP 19, RFC 2978, DOI 10.17487/RFC2978, October 2000, <[https://www.rfc-editor.org/info/rfc2978](https://www.rfc-editor.org/info/rfc2978)\>.

\[DISPOSITION\]

Troost, R., Dorner, S., and K. Moore, Ed., "Communicating Presentation Information in Internet Messages: The Content-Disposition Header Field", RFC 2183, DOI 10.17487/RFC2183, August 1997, <[https://www.rfc-editor.org/info/rfc2183](https://www.rfc-editor.org/info/rfc2183)\>.

\[I18N-HDRS\]

Yang, A., Steele, S., and N. Freed, "Internationalized Email Headers", RFC 6532, DOI 10.17487/RFC6532, February 2012, <[https://www.rfc-editor.org/info/rfc6532](https://www.rfc-editor.org/info/rfc6532)\>.

\[IMAP-IMPLEMENTATION\]

Leiba, B., "IMAP4 Implementation Recommendations", RFC 2683, DOI 10.17487/RFC2683, September 1999, <[https://www.rfc-editor.org/info/rfc2683](https://www.rfc-editor.org/info/rfc2683)\>.

\[IMAP-MULTIACCESS\]

Gahrns, M., "IMAP4 Multi-Accessed Mailbox Practice", RFC 2180, DOI 10.17487/RFC2180, July 1997, <[https://www.rfc-editor.org/info/rfc2180](https://www.rfc-editor.org/info/rfc2180)\>.

\[LANGUAGE-TAGS\]

Alvestrand, H., "Content Language Headers", RFC 3282, DOI 10.17487/RFC3282, May 2002, <[https://www.rfc-editor.org/info/rfc3282](https://www.rfc-editor.org/info/rfc3282)\>.

\[LOCATION\]

Palme, J., Hopmann, A., and N. Shelness, "MIME Encapsulation of Aggregate Documents, such as HTML (MHTML)", RFC 2557, DOI 10.17487/RFC2557, March 1999, <[https://www.rfc-editor.org/info/rfc2557](https://www.rfc-editor.org/info/rfc2557)\>.

\[MD5\]

Myers, J. and M. Rose, "The Content-MD5 Header Field", RFC 1864, DOI 10.17487/RFC1864, October 1995, <[https://www.rfc-editor.org/info/rfc1864](https://www.rfc-editor.org/info/rfc1864)\>.

\[MIME-HDRS\]

Moore, K., "MIME (Multipurpose Internet Mail Extensions) Part Three: Message Header Extensions for Non-ASCII Text", RFC 2047, DOI 10.17487/RFC2047, November 1996, <[https://www.rfc-editor.org/info/rfc2047](https://www.rfc-editor.org/info/rfc2047)\>.

\[MIME-IMB\]

Freed, N. and N. Borenstein, "Multipurpose Internet Mail Extensions (MIME) Part One: Format of Internet Message Bodies", RFC 2045, DOI 10.17487/RFC2045, November 1996, <[https://www.rfc-editor.org/info/rfc2045](https://www.rfc-editor.org/info/rfc2045)\>.

\[MIME-IMT\]

Freed, N. and N. Borenstein, "Multipurpose Internet Mail Extensions (MIME) Part Two: Media Types", RFC 2046, DOI 10.17487/RFC2046, November 1996, <[https://www.rfc-editor.org/info/rfc2046](https://www.rfc-editor.org/info/rfc2046)\>.

\[MULTIAPPEND\]

Crispin, M., "Internet Message Access Protocol (IMAP) - MULTIAPPEND Extension", RFC 3502, DOI 10.17487/RFC3502, March 2003, <[https://www.rfc-editor.org/info/rfc3502](https://www.rfc-editor.org/info/rfc3502)\>.

\[NET-UNICODE\]

Klensin, J. and M. Padlipsky, "Unicode Format for Network Interchange", RFC 5198, DOI 10.17487/RFC5198, March 2008, <[https://www.rfc-editor.org/info/rfc5198](https://www.rfc-editor.org/info/rfc5198)\>.

\[PLAIN\]

Zeilenga, K., Ed., "The PLAIN Simple Authentication and Security Layer (SASL) Mechanism", RFC 4616, DOI 10.17487/RFC4616, August 2006, <[https://www.rfc-editor.org/info/rfc4616](https://www.rfc-editor.org/info/rfc4616)\>.

\[RFC2077\]

Nelson, S., Parks, C., and Mitra., "The Model Primary Content Type for Multipurpose Internet Mail Extensions", RFC 2077, DOI 10.17487/RFC2077, January 1997, <[https://www.rfc-editor.org/info/rfc2077](https://www.rfc-editor.org/info/rfc2077)\>.

\[RFC2119\]

Bradner, S., "Key words for use in RFCs to Indicate Requirement Levels", BCP 14, RFC 2119, DOI 10.17487/RFC2119, March 1997, <[https://www.rfc-editor.org/info/rfc2119](https://www.rfc-editor.org/info/rfc2119)\>.

\[RFC2231\]

Freed, N. and K. Moore, "MIME Parameter Value and Encoded Word Extensions: Character Sets, Languages, and Continuations", RFC 2231, DOI 10.17487/RFC2231, November 1997, <[https://www.rfc-editor.org/info/rfc2231](https://www.rfc-editor.org/info/rfc2231)\>.

\[RFC3503\]

Melnikov, A., "Message Disposition Notification (MDN) profile for Internet Message Access Protocol (IMAP)", RFC 3503, DOI 10.17487/RFC3503, March 2003, <[https://www.rfc-editor.org/info/rfc3503](https://www.rfc-editor.org/info/rfc3503)\>.

\[RFC4648\]

Josefsson, S., "The Base16, Base32, and Base64 Data Encodings", RFC 4648, DOI 10.17487/RFC4648, October 2006, <[https://www.rfc-editor.org/info/rfc4648](https://www.rfc-editor.org/info/rfc4648)\>.

\[RFC4752\]

Melnikov, A., Ed., "The Kerberos V5 ("GSSAPI") Simple Authentication and Security Layer (SASL) Mechanism", RFC 4752, DOI 10.17487/RFC4752, November 2006, <[https://www.rfc-editor.org/info/rfc4752](https://www.rfc-editor.org/info/rfc4752)\>.

\[RFC5258\]

Leiba, B. and A. Melnikov, "Internet Message Access Protocol version 4 - LIST Command Extensions", RFC 5258, DOI 10.17487/RFC5258, June 2008, <[https://www.rfc-editor.org/info/rfc5258](https://www.rfc-editor.org/info/rfc5258)\>.

\[RFC5322\]

Resnick, P., Ed., "Internet Message Format", RFC 5322, DOI 10.17487/RFC5322, October 2008, <[https://www.rfc-editor.org/info/rfc5322](https://www.rfc-editor.org/info/rfc5322)\>.

\[RFC5788\]

Melnikov, A. and D. Cridland, "IMAP4 Keyword Registry", RFC 5788, DOI 10.17487/RFC5788, March 2010, <[https://www.rfc-editor.org/info/rfc5788](https://www.rfc-editor.org/info/rfc5788)\>.

\[RFC7525\]

Sheffer, Y., Holz, R., and P. Saint-Andre, "Recommendations for Secure Use of Transport Layer Security (TLS) and Datagram Transport Layer Security (DTLS)", BCP 195, RFC 7525, DOI 10.17487/RFC7525, May 2015, <[https://www.rfc-editor.org/info/rfc7525](https://www.rfc-editor.org/info/rfc7525)\>.

\[RFC7817\]

Melnikov, A., "Updated Transport Layer Security (TLS) Server Identity Check Procedure for Email-Related Protocols", RFC 7817, DOI 10.17487/RFC7817, March 2016, <[https://www.rfc-editor.org/info/rfc7817](https://www.rfc-editor.org/info/rfc7817)\>.

\[RFC8081\]

Lilley, C., "The "font" Top-Level Media Type", RFC 8081, DOI 10.17487/RFC8081, February 2017, <[https://www.rfc-editor.org/info/rfc8081](https://www.rfc-editor.org/info/rfc8081)\>.

\[RFC8098\]

Hansen, T., Ed. and A. Melnikov, Ed., "Message Disposition Notification", STD 85, RFC 8098, DOI 10.17487/RFC8098, February 2017, <[https://www.rfc-editor.org/info/rfc8098](https://www.rfc-editor.org/info/rfc8098)\>.

\[RFC8174\]

Leiba, B., "Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words", BCP 14, RFC 8174, DOI 10.17487/RFC8174, May 2017, <[https://www.rfc-editor.org/info/rfc8174](https://www.rfc-editor.org/info/rfc8174)\>.

\[RFC8314\]

Moore, K. and C. Newman, "Cleartext Considered Obsolete: Use of Transport Layer Security (TLS) for Email Submission and Access", RFC 8314, DOI 10.17487/RFC8314, January 2018, <[https://www.rfc-editor.org/info/rfc8314](https://www.rfc-editor.org/info/rfc8314)\>.

\[SASL\]

Melnikov, A., Ed. and K. Zeilenga, Ed., "Simple Authentication and Security Layer (SASL)", RFC 4422, DOI 10.17487/RFC4422, June 2006, <[https://www.rfc-editor.org/info/rfc4422](https://www.rfc-editor.org/info/rfc4422)\>.

\[SCRAM-SHA-256\]

Hansen, T., "SCRAM-SHA-256 and SCRAM-SHA-256-PLUS Simple Authentication and Security Layer (SASL) Mechanisms", RFC 7677, DOI 10.17487/RFC7677, November 2015, <[https://www.rfc-editor.org/info/rfc7677](https://www.rfc-editor.org/info/rfc7677)\>.

\[TLS-1.2\]

Dierks, T. and E. Rescorla, "The Transport Layer Security (TLS) Protocol Version 1.2", RFC 5246, DOI 10.17487/RFC5246, August 2008, <[https://www.rfc-editor.org/info/rfc5246](https://www.rfc-editor.org/info/rfc5246)\>.

\[TLS-1.3\]

Rescorla, E., "The Transport Layer Security (TLS) Protocol Version 1.3", RFC 8446, DOI 10.17487/RFC8446, August 2018, <[https://www.rfc-editor.org/info/rfc8446](https://www.rfc-editor.org/info/rfc8446)\>.

\[UTF-7\]

Goldsmith, D. and M. Davis, "UTF-7 A Mail-Safe Transformation Format of Unicode", RFC 2152, DOI 10.17487/RFC2152, May 1997, <[https://www.rfc-editor.org/info/rfc2152](https://www.rfc-editor.org/info/rfc2152)\>.

\[UTF-8\]

Yergeau, F., "UTF-8, a transformation format of ISO 10646", STD 63, RFC 3629, DOI 10.17487/RFC3629, November 2003, <[https://www.rfc-editor.org/info/rfc3629](https://www.rfc-editor.org/info/rfc3629)\>.

### [13.2.](https://www.rfc-editor.org/info/rfc9051/#section-13.2) [Informative References](https://www.rfc-editor.org/info/rfc9051/#name-informative-references) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-13.2)

\[ANONYMOUS\]

Zeilenga, K., "Anonymous Simple Authentication and Security Layer (SASL) Mechanism", RFC 4505, DOI 10.17487/RFC4505, June 2006, <[https://www.rfc-editor.org/info/rfc4505](https://www.rfc-editor.org/info/rfc4505)\>.

\[CERT-555316\]

Carnegie Mellon University, "STARTTLS plaintext command injection vulnerability", Software Engineering Institute, CERT Coordination Center, Vulnerability Note VU#555316, September 2011, <[https://www.kb.cert.org/vuls/id/555316](https://www.kb.cert.org/vuls/id/555316)\>.

\[CHARSET-REG\]

IANA, "Character Set Registrations", <[https://www.iana.org/assignments/charset-reg/](https://www.iana.org/assignments/charset-reg/)\>.

\[IMAP-DISC\]

Melnikov, A., Ed., "Synchronization Operations for Disconnected IMAP4 Clients", RFC 4549, DOI 10.17487/RFC4549, June 2006, <[https://www.rfc-editor.org/info/rfc4549](https://www.rfc-editor.org/info/rfc4549)\>.

\[IMAP-I18N\]

Newman, C., Gulbrandsen, A., and A. Melnikov, "Internet Message Access Protocol Internationalization", RFC 5255, DOI 10.17487/RFC5255, June 2008, <[https://www.rfc-editor.org/info/rfc5255](https://www.rfc-editor.org/info/rfc5255)\>.

\[IMAP-KEYWORDS-REG\]

IANA, "IMAP and JMAP Keywords", <[https://www.iana.org/assignments/imap-jmap-keywords/](https://www.iana.org/assignments/imap-jmap-keywords/)\>.

\[IMAP-MAILBOX-NAME-ATTRS-REG\]

IANA, "IMAP Mailbox Name Attributes", <[https://www.iana.org/assignments/imap-mailbox-name-attributes/](https://www.iana.org/assignments/imap-mailbox-name-attributes/)\>.

\[IMAP-MODEL\]

Crispin, M., "Distributed Electronic Mail Models in IMAP4", RFC 1733, DOI 10.17487/RFC1733, December 1994, <[https://www.rfc-editor.org/info/rfc1733](https://www.rfc-editor.org/info/rfc1733)\>.

\[IMAP-URL\]

Melnikov, A., Ed. and C. Newman, "IMAP URL Scheme", RFC 5092, DOI 10.17487/RFC5092, November 2007, <[https://www.rfc-editor.org/info/rfc5092](https://www.rfc-editor.org/info/rfc5092)\>.

\[IMAP-UTF-8\]

Resnick, P., Ed., Newman, C., Ed., and S. Shen, Ed., "IMAP Support for UTF-8", RFC 6855, DOI 10.17487/RFC6855, March 2013, <[https://www.rfc-editor.org/info/rfc6855](https://www.rfc-editor.org/info/rfc6855)\>.

\[NCSC\]

NCSC, "Spray you, spray me: defending against password spraying attacks", May 2018, <[https://www.ncsc.gov.uk/blog-post/spray-you-spray-me-defending-against-password-spraying-attacks](https://www.ncsc.gov.uk/blog-post/spray-you-spray-me-defending-against-password-spraying-attacks)\>.

\[RFC2087\]

Myers, J., "IMAP4 QUOTA extension", RFC 2087, DOI 10.17487/RFC2087, January 1997, <[https://www.rfc-editor.org/info/rfc2087](https://www.rfc-editor.org/info/rfc2087)\>.

\[RFC2177\]

Leiba, B., "IMAP4 IDLE command", RFC 2177, DOI 10.17487/RFC2177, June 1997, <[https://www.rfc-editor.org/info/rfc2177](https://www.rfc-editor.org/info/rfc2177)\>.

\[RFC2193\]

Gahrns, M., "IMAP4 Mailbox Referrals", RFC 2193, DOI 10.17487/RFC2193, September 1997, <[https://www.rfc-editor.org/info/rfc2193](https://www.rfc-editor.org/info/rfc2193)\>.

\[RFC2342\]

Gahrns, M. and C. Newman, "IMAP4 Namespace", RFC 2342, DOI 10.17487/RFC2342, May 1998, <[https://www.rfc-editor.org/info/rfc2342](https://www.rfc-editor.org/info/rfc2342)\>.

\[RFC3348\]

Gahrns, M. and R. Cheng, "The Internet Message Action Protocol (IMAP4) Child Mailbox Extension", RFC 3348, DOI 10.17487/RFC3348, July 2002, <[https://www.rfc-editor.org/info/rfc3348](https://www.rfc-editor.org/info/rfc3348)\>.

\[RFC3516\]

Nerenberg, L., "IMAP4 Binary Content Extension", RFC 3516, DOI 10.17487/RFC3516, April 2003, <[https://www.rfc-editor.org/info/rfc3516](https://www.rfc-editor.org/info/rfc3516)\>.

\[RFC3691\]

Melnikov, A., "Internet Message Access Protocol (IMAP) UNSELECT command", RFC 3691, DOI 10.17487/RFC3691, February 2004, <[https://www.rfc-editor.org/info/rfc3691](https://www.rfc-editor.org/info/rfc3691)\>.

\[RFC4314\]

Melnikov, A., "IMAP4 Access Control List (ACL) Extension", RFC 4314, DOI 10.17487/RFC4314, December 2005, <[https://www.rfc-editor.org/info/rfc4314](https://www.rfc-editor.org/info/rfc4314)\>.

\[RFC4315\]

Crispin, M., "Internet Message Access Protocol (IMAP) - UIDPLUS extension", RFC 4315, DOI 10.17487/RFC4315, December 2005, <[https://www.rfc-editor.org/info/rfc4315](https://www.rfc-editor.org/info/rfc4315)\>.

\[RFC4466\]

Melnikov, A. and C. Daboo, "Collected Extensions to IMAP4 ABNF", RFC 4466, DOI 10.17487/RFC4466, April 2006, <[https://www.rfc-editor.org/info/rfc4466](https://www.rfc-editor.org/info/rfc4466)\>.

\[RFC4731\]

Melnikov, A. and D. Cridland, "IMAP4 Extension to SEARCH Command for Controlling What Kind of Information Is Returned", RFC 4731, DOI 10.17487/RFC4731, November 2006, <[https://www.rfc-editor.org/info/rfc4731](https://www.rfc-editor.org/info/rfc4731)\>.

\[RFC4959\]

Siemborski, R. and A. Gulbrandsen, "IMAP Extension for Simple Authentication and Security Layer (SASL) Initial Client Response", RFC 4959, DOI 10.17487/RFC4959, September 2007, <[https://www.rfc-editor.org/info/rfc4959](https://www.rfc-editor.org/info/rfc4959)\>.

\[RFC5161\]

Gulbrandsen, A., Ed. and A. Melnikov, Ed., "The IMAP ENABLE Extension", RFC 5161, DOI 10.17487/RFC5161, March 2008, <[https://www.rfc-editor.org/info/rfc5161](https://www.rfc-editor.org/info/rfc5161)\>.

\[RFC5182\]

Melnikov, A., "IMAP Extension for Referencing the Last SEARCH Result", RFC 5182, DOI 10.17487/RFC5182, March 2008, <[https://www.rfc-editor.org/info/rfc5182](https://www.rfc-editor.org/info/rfc5182)\>.

\[RFC5256\]

Crispin, M. and K. Murchison, "Internet Message Access Protocol - SORT and THREAD Extensions", RFC 5256, DOI 10.17487/RFC5256, June 2008, <[https://www.rfc-editor.org/info/rfc5256](https://www.rfc-editor.org/info/rfc5256)\>.

\[RFC5465\]

Gulbrandsen, A., King, C., and A. Melnikov, "The IMAP NOTIFY Extension", RFC 5465, DOI 10.17487/RFC5465, February 2009, <[https://www.rfc-editor.org/info/rfc5465](https://www.rfc-editor.org/info/rfc5465)\>.

\[RFC5530\]

Gulbrandsen, A., "IMAP Response Codes", RFC 5530, DOI 10.17487/RFC5530, May 2009, <[https://www.rfc-editor.org/info/rfc5530](https://www.rfc-editor.org/info/rfc5530)\>.

\[RFC5819\]

Melnikov, A. and T. Sirainen, "IMAP4 Extension for Returning STATUS Information in Extended LIST", RFC 5819, DOI 10.17487/RFC5819, March 2010, <[https://www.rfc-editor.org/info/rfc5819](https://www.rfc-editor.org/info/rfc5819)\>.

\[RFC6151\]

Turner, S. and L. Chen, "Updated Security Considerations for the MD5 Message-Digest and the HMAC-MD5 Algorithms", RFC 6151, DOI 10.17487/RFC6151, March 2011, <[https://www.rfc-editor.org/info/rfc6151](https://www.rfc-editor.org/info/rfc6151)\>.

\[RFC6154\]

Leiba, B. and J. Nicolson, "IMAP LIST Extension for Special-Use Mailboxes", RFC 6154, DOI 10.17487/RFC6154, March 2011, <[https://www.rfc-editor.org/info/rfc6154](https://www.rfc-editor.org/info/rfc6154)\>.

\[RFC6186\]

Daboo, C., "Use of SRV Records for Locating Email Submission/Access Services", RFC 6186, DOI 10.17487/RFC6186, March 2011, <[https://www.rfc-editor.org/info/rfc6186](https://www.rfc-editor.org/info/rfc6186)\>.

\[RFC6376\]

Crocker, D., Ed., Hansen, T., Ed., and M. Kucherawy, Ed., "DomainKeys Identified Mail (DKIM) Signatures", STD 76, RFC 6376, DOI 10.17487/RFC6376, September 2011, <[https://www.rfc-editor.org/info/rfc6376](https://www.rfc-editor.org/info/rfc6376)\>.

\[RFC6409\]

Gellens, R. and J. Klensin, "Message Submission for Mail", STD 72, RFC 6409, DOI 10.17487/RFC6409, November 2011, <[https://www.rfc-editor.org/info/rfc6409](https://www.rfc-editor.org/info/rfc6409)\>.

\[RFC6851\]

Gulbrandsen, A. and N. Freed, Ed., "Internet Message Access Protocol (IMAP) - MOVE Extension", RFC 6851, DOI 10.17487/RFC6851, January 2013, <[https://www.rfc-editor.org/info/rfc6851](https://www.rfc-editor.org/info/rfc6851)\>.

\[RFC7162\]

Melnikov, A. and D. Cridland, "IMAP Extensions: Quick Flag Changes Resynchronization (CONDSTORE) and Quick Mailbox Resynchronization (QRESYNC)", RFC 7162, DOI 10.17487/RFC7162, May 2014, <[https://www.rfc-editor.org/info/rfc7162](https://www.rfc-editor.org/info/rfc7162)\>.

\[RFC7888\]

Melnikov, A., Ed., "IMAP4 Non-synchronizing Literals", RFC 7888, DOI 10.17487/RFC7888, May 2016, <[https://www.rfc-editor.org/info/rfc7888](https://www.rfc-editor.org/info/rfc7888)\>.

\[RFC8126\]

Cotton, M., Leiba, B., and T. Narten, "Guidelines for Writing an IANA Considerations Section in RFCs", BCP 26, RFC 8126, DOI 10.17487/RFC8126, June 2017, <[https://www.rfc-editor.org/info/rfc8126](https://www.rfc-editor.org/info/rfc8126)\>.

\[RFC8305\]

Schinazi, D. and T. Pauly, "Happy Eyeballs Version 2: Better Connectivity Using Concurrency", RFC 8305, DOI 10.17487/RFC8305, December 2017, <[https://www.rfc-editor.org/info/rfc8305](https://www.rfc-editor.org/info/rfc8305)\>.

\[RFC8438\]

Bosch, S., "IMAP Extension for STATUS=SIZE", RFC 8438, DOI 10.17487/RFC8438, August 2018, <[https://www.rfc-editor.org/info/rfc8438](https://www.rfc-editor.org/info/rfc8438)\>.

\[RFC8474\]

Gondwana, B., Ed., "IMAP Extension for Object Identifiers", RFC 8474, DOI 10.17487/RFC8474, September 2018, <[https://www.rfc-editor.org/info/rfc8474](https://www.rfc-editor.org/info/rfc8474)\>.

\[RFC8550\]

Schaad, J., Ramsdell, B., and S. Turner, "Secure/Multipurpose Internet Mail Extensions (S/MIME) Version 4.0 Certificate Handling", RFC 8550, DOI 10.17487/RFC8550, April 2019, <[https://www.rfc-editor.org/info/rfc8550](https://www.rfc-editor.org/info/rfc8550)\>.

\[RFC8551\]

Schaad, J., Ramsdell, B., and S. Turner, "Secure/Multipurpose Internet Mail Extensions (S/MIME) Version 4.0 Message Specification", RFC 8551, DOI 10.17487/RFC8551, April 2019, <[https://www.rfc-editor.org/info/rfc8551](https://www.rfc-editor.org/info/rfc8551)\>.

\[SMTP\]

Klensin, J., "Simple Mail Transfer Protocol", RFC 5321, DOI 10.17487/RFC5321, October 2008, <[https://www.rfc-editor.org/info/rfc5321](https://www.rfc-editor.org/info/rfc5321)\>.

#### [13.2.2.](https://www.rfc-editor.org/info/rfc9051/#section-13.2.2) [Historical Aspects of IMAP and Related Protocols](https://www.rfc-editor.org/info/rfc9051/#name-historical-aspects-of-imap-) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-section-13.2.2)

\[IMAP-COMPAT\]

Crispin, M., "IMAP4 Compatibility with IMAP2bis", RFC 2061, DOI 10.17487/RFC2061, December 1996, <[https://www.rfc-editor.org/info/rfc2061](https://www.rfc-editor.org/info/rfc2061)\>.

\[IMAP-HISTORICAL\]

Crispin, M., "IMAP4 Compatibility with IMAP2 and IMAP2bis", RFC 1732, DOI 10.17487/RFC1732, December 1994, <[https://www.rfc-editor.org/info/rfc1732](https://www.rfc-editor.org/info/rfc1732)\>.

\[IMAP-OBSOLETE\]

Crispin, M., "Internet Message Access Protocol - Obsolete Syntax", RFC 2062, DOI 10.17487/RFC2062, December 1996, <[https://www.rfc-editor.org/info/rfc2062](https://www.rfc-editor.org/info/rfc2062)\>.

\[IMAP-TLS\]

Newman, C., "Using TLS with IMAP, POP3 and ACAP", RFC 2595, DOI 10.17487/RFC2595, June 1999, <[https://www.rfc-editor.org/info/rfc2595](https://www.rfc-editor.org/info/rfc2595)\>.

\[IMAP2\]

Crispin, M., "Interactive Mail Access Protocol: Version 2", RFC 1176, DOI 10.17487/RFC1176, August 1990, <[https://www.rfc-editor.org/info/rfc1176](https://www.rfc-editor.org/info/rfc1176)\>.

\[IMAP2BIS\]

Crispin, M., "INTERACTIVE MAIL ACCESS PROTOCOL - VERSION 2bis", Work in Progress, Internet-Draft, draft-ietf-imap-imap2bis-02, 29 October 1993, <[https://datatracker.ietf.org/doc/html/draft-ietf-imap-imap2bis-02](https://datatracker.ietf.org/doc/html/draft-ietf-imap-imap2bis-02)\>.

\[RFC1064\]

Crispin, M., "Interactive Mail Access Protocol: Version 2", RFC 1064, DOI 10.17487/RFC1064, July 1988, <[https://www.rfc-editor.org/info/rfc1064](https://www.rfc-editor.org/info/rfc1064)\>.

\[RFC1730\]

Crispin, M., "Internet Message Access Protocol - Version 4", RFC 1730, DOI 10.17487/RFC1730, December 1994, <[https://www.rfc-editor.org/info/rfc1730](https://www.rfc-editor.org/info/rfc1730)\>.

\[RFC2060\]

Crispin, M., "Internet Message Access Protocol - Version 4rev1", RFC 2060, DOI 10.17487/RFC2060, December 1996, <[https://www.rfc-editor.org/info/rfc2060](https://www.rfc-editor.org/info/rfc2060)\>.

\[RFC3501\]

Crispin, M., "INTERNET MESSAGE ACCESS PROTOCOL - VERSION 4rev1", RFC 3501, DOI 10.17487/RFC3501, March 2003, <[https://www.rfc-editor.org/info/rfc3501](https://www.rfc-editor.org/info/rfc3501)\>.

\[RFC822\]

Crocker, D., "STANDARD FOR THE FORMAT OF ARPA INTERNET TEXT MESSAGES", STD 11, RFC 822, DOI 10.17487/RFC0822, August 1982, <[https://www.rfc-editor.org/info/rfc822](https://www.rfc-editor.org/info/rfc822)\>.

## [Appendix A.](https://www.rfc-editor.org/info/rfc9051/#appendix-A) [Backward Compatibility with IMAP4rev1](https://www.rfc-editor.org/info/rfc9051/#name-backward-compatibility-with) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-appendix-A)

An implementation that wants to remain compatible with IMAP4rev1 can advertise both IMAP4rev1 and IMAP4rev2 in its CAPABILITY response / response code. (Such server implementation is likely to also want to advertise other IMAP4rev1 extensions that were folded into IMAP4rev2; see [Appendix E](https://www.rfc-editor.org/info/rfc9051/#changesFromIMAP4rev1).) While some IMAP4rev1 responses were removed in IMAP4rev2, their presence will not break IMAP4rev2-only clients.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-A-1)

If both IMAP4rev1 and IMAP4rev2 are advertised, an IMAP client that wants to use IMAP4rev2 MUST issue an "ENABLE IMAP4rev2" command.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-A-2)

When compared to IMAP4rev1, some request data items, corresponding response data items, and responses were removed in IMAP4rev2. See [Appendix E](https://www.rfc-editor.org/info/rfc9051/#changesFromIMAP4rev1) for more details. With the exception of obsolete SEARCH and RECENT responses, servers advertising both IMAP4rev1 and IMAP4rev2 would never return such removed response data items/responses unless explicitly requested by an IMAPrev1 client.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-A-3)

Servers advertising both IMAP4rev1 and IMAP4rev2 MUST NOT generate UTF-8-quoted strings unless the client has issued "ENABLE IMAP4rev2". Consider implementation of mechanisms described or referenced in \[[IMAP-UTF-8](https://www.rfc-editor.org/info/rfc9051/#RFC6855)\] to achieve this goal.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-A-4)

Servers advertising both IMAP4rev1 and IMAP4rev2, and clients intending to be compatible with IMAP4rev1 servers, MUST be compatible with the Mailbox International Naming Convention described in [Appendix A.1](https://www.rfc-editor.org/info/rfc9051/#mailbox-i18n).[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-A-5)

Also see [Appendix D](https://www.rfc-editor.org/info/rfc9051/#body-part-64bit) for special considerations for servers that support 63-bit body part / message sizes and want to advertise support for both IMAP4rev1 and IMAP4rev2.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-A-6)

### [A.1.](https://www.rfc-editor.org/info/rfc9051/#appendix-A.1) [Mailbox International Naming Convention for Compatibility with IMAP4rev1](https://www.rfc-editor.org/info/rfc9051/#name-mailbox-international-namin) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-appendix-A.1)

Support for the Mailbox International Naming Convention described in this section is not required for IMAP4rev2-only clients and servers. It is only used for backward compatibility with IMAP4rev1 implementations.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-A.1-1)

By convention, international mailbox names in IMAP4rev1 are specified using a modified version of the UTF-7 encoding described in \[[UTF-7](https://www.rfc-editor.org/info/rfc9051/#RFC2152)\]. Modified UTF-7 may also be usable in servers that implement an earlier version of this protocol.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-A.1-2)

In modified UTF-7, printable US-ASCII characters, except for "&", represent themselves; that is, characters with octet values 0x20-0x25 and 0x27-0x7e. The character "&" (0x26) is represented by the 2-octet sequence "&-".[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-A.1-3)

All other characters (octet values 0x00-0x1f and 0x7f-0xff) are represented in modified base64, with a further modification from \[[UTF-7](https://www.rfc-editor.org/info/rfc9051/#RFC2152)\] that "," is used instead of "/". Modified base64 MUST NOT be used to represent any printing of a US-ASCII character that can represent itself. Only characters inside the modified base64 alphabet are permitted in modified base64 text.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-A.1-4)

"&" is used to shift to modified base64 and "-" to shift back to US-ASCII. There is no implicit shift from base64 to US-ASCII, and null shifts ("-&" while in base64; note that "&-" while in US-ASCII means "&") are not permitted. However, all names start in US-ASCII and MUST end in US-ASCII; that is, a name that ends with a non-ASCII ISO-10646 character MUST end with a "-".[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-A.1-5)

The purpose of these modifications is to correct the following problems with UTF-7:[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-A.1-6)

1.  UTF-7 uses the "+" character for shifting; this conflicts with the common use of "+" in mailbox names, in particular USENET newsgroup names.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-A.1-7.1)
2.  UTF-7's encoding is base64, which uses the "/" character; this conflicts with the use of "/" as a popular hierarchy delimiter.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-A.1-7.2)
3.  UTF-7 prohibits the unencoded usage of "\\"; this conflicts with the use of "\\" as a popular hierarchy delimiter.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-A.1-7.3)
4.  UTF-7 prohibits the unencoded usage of "~"; this conflicts with the use of "~" in some servers as a home directory indicator.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-A.1-7.4)
5.  UTF-7 permits multiple alternate forms to represent the same string; in particular, printable US-ASCII characters can be represented in encoded form.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-A.1-7.5)

Although modified UTF-7 is a convention, it establishes certain requirements on the server handling of any mailbox name with an embedded "&" character. In particular, server implementations MUST preserve the exact form of the modified base64 portion of a modified UTF-7 name and treat that text as case sensitive, even if names are otherwise case insensitive or case folded.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-A.1-8)

Server implementations SHOULD verify that any mailbox name with an embedded "&" character, used as an argument to CREATE, is: in the correctly modified UTF-7 syntax; has no superfluous shifts; and has no encoding in modified base64 of any printing US-ASCII character that can represent itself. However, client implementations MUST NOT depend upon the server doing this and SHOULD NOT attempt to create a mailbox name with an embedded "&" character unless it complies with the modified UTF-7 syntax.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-A.1-9)

Server implementations that export a mail store that does not follow the modified UTF-7 convention MUST convert any mailbox name that contains either non-ASCII characters or the "&" character to modified UTF-7.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-A.1-10)

-   For example, here is a mailbox name that mixes English, Chinese, and Japanese text: ~peter/mail/&U,BTFw\-/&ZeVnLIqe-[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-A.1-11.1)
-   For example, the string "&Jjo!" is not a valid mailbox name because it does not contain a shift to US-ASCII before the "!". The correct form is "&Jjo-!". The string "&U,BTFw\-&ZeVnLIqe-" is not permitted because it contains a superfluous shift. The correct form is "&U,BTF2XlZyyKng-".[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-A.1-11.2)

## [Appendix B.](https://www.rfc-editor.org/info/rfc9051/#appendix-B) [Backward Compatibility with BINARY Extension](https://www.rfc-editor.org/info/rfc9051/#name-backward-compatibility-with-) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-appendix-B)

IMAP4rev2 incorporates a subset of functionality provided by the BINARY extension \[[RFC3516](https://www.rfc-editor.org/info/rfc9051/#RFC3516)\]; in particular, it includes additional FETCH items (BINARY, BINARY.PEEK, and BINARY.SIZE) but not extensions to the APPEND command. IMAP4rev2 implementations that support full \[[RFC3516](https://www.rfc-editor.org/info/rfc9051/#RFC3516)\] functionality need to also advertise the BINARY capability in the CAPABILITY response / response code.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-B-1)

## [Appendix C.](https://www.rfc-editor.org/info/rfc9051/#appendix-C) [Backward Compatibility with LIST-EXTENDED Extension](https://www.rfc-editor.org/info/rfc9051/#name-backward-compatibility-with-l) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-appendix-C)

IMAP4rev2 incorporates most of the functionality provided by the LIST-EXTENDED extension \[[RFC5258](https://www.rfc-editor.org/info/rfc9051/#RFC5258)\]. In particular, the syntax for multiple mailbox patterns is not supported in IMAP4rev2, unless LIST-EXTENDED capability is also advertised in the CAPABILITY response / response code.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-C-1)

## [Appendix D.](https://www.rfc-editor.org/info/rfc9051/#appendix-D) [63-Bit Body Part and Message Sizes](https://www.rfc-editor.org/info/rfc9051/#name-63-bit-body-part-and-messag) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-appendix-D)

IMAP4rev2 increases allowed body part and message sizes that servers can support from 32 to 63 bits. Server implementations don't have to support 63-bit-long body parts/message sizes; however, client implementations have to expect them.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-D-1)

As IMAP4rev1 didn't support 63-bit-long body part / message sizes, there is an interoperability issue exposed by 63-bit-capable servers/mailboxes that are accessible by both IMAP4rev1 and IMAP4rev2 email clients. As IMAP4rev1 would be unable to retrieve the full content of messages bigger than 4 Gb, such servers either need to replace messages bigger that 4 Gb with messages under 4 Gb or hide them from IMAP4rev1 clients. This document doesn't prescribe any implementation strategy to address this issue.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-D-2)

## [Appendix E.](https://www.rfc-editor.org/info/rfc9051/#appendix-E) [Changes from RFC 3501 / IMAP4rev1](https://www.rfc-editor.org/info/rfc9051/#name-changes-from-rfc-3501-imap4) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-appendix-E)

Below is the summary of changes since RFC 3501:[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-1)

1.  Support for 64-bit message and body part sizes.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.1)
2.  Folded in IMAP NAMESPACE \[[RFC2342](https://www.rfc-editor.org/info/rfc9051/#RFC2342)\], UNSELECT \[[RFC3691](https://www.rfc-editor.org/info/rfc9051/#RFC3691)\], UIDPLUS \[[RFC4315](https://www.rfc-editor.org/info/rfc9051/#RFC4315)\], ESEARCH \[[RFC4731](https://www.rfc-editor.org/info/rfc9051/#RFC4731)\], SEARCHRES \[[RFC5182](https://www.rfc-editor.org/info/rfc9051/#RFC5182)\], ENABLE \[[RFC5161](https://www.rfc-editor.org/info/rfc9051/#RFC5161)\], IDLE \[[RFC2177](https://www.rfc-editor.org/info/rfc9051/#RFC2177)\], SASL-IR \[[RFC4959](https://www.rfc-editor.org/info/rfc9051/#RFC4959)\], LIST-EXTENDED \[[RFC5258](https://www.rfc-editor.org/info/rfc9051/#RFC5258)\], LIST-STATUS \[[RFC5819](https://www.rfc-editor.org/info/rfc9051/#RFC5819)\], MOVE \[[RFC6851](https://www.rfc-editor.org/info/rfc9051/#RFC6851)\], and LITERAL- extensions \[[RFC7888](https://www.rfc-editor.org/info/rfc9051/#RFC7888)\]. Also folded in IMAP ABNF extensions \[[RFC4466](https://www.rfc-editor.org/info/rfc9051/#RFC4466)\], response codes \[[RFC5530](https://www.rfc-editor.org/info/rfc9051/#RFC5530)\], the FETCH side of the BINARY extension \[[RFC3516](https://www.rfc-editor.org/info/rfc9051/#RFC3516)\], and the list of new mailbox attributes from SPECIAL-USE \[[RFC6154](https://www.rfc-editor.org/info/rfc9051/#RFC6154)\].[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.2)
3.  Added STATUS SIZE \[[RFC8438](https://www.rfc-editor.org/info/rfc9051/#RFC8438)\] and STATUS DELETED.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.3)
4.  SEARCH command now requires to return the ESEARCH response (SEARCH response is now deprecated).[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.4)
5.  Clarified which SEARCH keys have to use substring match and which don't.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.5)
6.  Clarified that the server should decode parameter value continuations as described in \[[RFC2231](https://www.rfc-editor.org/info/rfc9051/#RFC2231)\]. This requirement was hidden in \[[RFC2231](https://www.rfc-editor.org/info/rfc9051/#RFC2231)\] itself.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.6)
7.  Clarified that the COPYUID response code is returned for both MOVE and UID MOVE.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.7)
8.  Tightened requirements about COPY/MOVE commands not creating a target mailbox. Also required them to return the TRYCREATE response code, if the target mailbox doesn't exist and can be created.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.8)
9.  Added the CLOSED response code from \[[RFC7162](https://www.rfc-editor.org/info/rfc9051/#RFC7162)\]. SELECT/EXAMINE when a mailbox is already selected now requires a CLOSED response code to be returned.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.9)
10.  SELECT/EXAMINE are now required to return an untagged LIST response.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.10)
11.  UNSEEN response code on SELECT/EXAMINE is now deprecated.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.11)
12.  RECENT response on SELECT/EXAMINE, \\Recent flag, RECENT STATUS, and SEARCH NEW items are now deprecated.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.12)
13.  Clarified that the server doesn't need to send a new PERMANENTFLAGS response code when a new keyword was successfully added and the server advertised \\\* earlier for the same mailbox.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.13)
14.  For future extensibility, extended ABNF for tagged-ext-simple to allow for bare number64.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.14)
15.  Added SHOULD level requirement on IMAP servers to support $MDNSent, $Forwarded, $Junk, $NonJunk, and $Phishing keywords.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.15)
16.  Mailbox names and message headers now allow for UTF-8. Support for modified UTF-7 in mailbox names is not required, unless compatibility with IMAP4rev1 is desired.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.16)
17.  Removed the CHECK command. Clients should use NOOP instead.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.17)
18.  RFC822, RFC822.HEADER, and RFC822.TEXT FETCH data items were deprecated. Clients should use the corresponding BODY\[\] variants instead.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.18)
19.  LSUB command was deprecated. Clients should use LIST (SUBSCRIBED) instead.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.19)
20.  IDLE command can now return updates not related to the currently selected mailbox state.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.20)
21.  All unsolicited FETCH updates are required to include UID.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.21)
22.  Clarified that client implementations MUST ignore response codes that they do not recognize. (Changed from a SHOULD to a MUST.)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.22)
23.  resp-text ABNF non-terminal was updated to allow for empty text.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.23)
24.  After ENABLE, IMAP4rev2 human-readable response text can include non-ASCII encoded in UTF-8.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.24)
25.  Updated to use modern TLS-related recommendations as per \[[RFC7525](https://www.rfc-editor.org/info/rfc9051/#RFC7525)\], \[[RFC7817](https://www.rfc-editor.org/info/rfc9051/#RFC7817)\], and \[[RFC8314](https://www.rfc-editor.org/info/rfc9051/#RFC8314)\].[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.25)
26.  Added warnings about use of ALERT response codes and PREAUTH response.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.26)
27.  Replaced DIGEST-MD5 SASL mechanism with SCRAM-SHA-256. DIGEST-MD5 was deprecated.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.27)
28.  Clarified that any command received from the client resets server autologout timer.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.28)
29.  Revised IANA registration procedure for IMAP extensions and removed "X" convention in accordance with \[[BCP178](https://www.rfc-editor.org/info/rfc9051/#BCP178)\].[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.29)
30.  Loosened requirements on servers when closing connections to be more aligned with existing practices.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-E-2.30)

## [Appendix F.](https://www.rfc-editor.org/info/rfc9051/#appendix-F) [Other Recommended IMAP Extensions](https://www.rfc-editor.org/info/rfc9051/#name-other-recommended-imap-exte) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-appendix-F)

Support for the following extensions is recommended for all IMAP clients and servers. While they significantly reduce bandwidth and/or number of round trips used by IMAP in certain situations, the EXTRA WG decided that requiring them as a part of IMAP4rev2 would push the bar to implement too high for new implementations. Also note that the absence of any IMAP extension from this list doesn't make it somehow deficient or not recommended for use with IMAP4rev2.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-F-1)

1.  Quick Mailbox Resynchronization (QRESYNC) and CONDSTORE extensions \[[RFC7162](https://www.rfc-editor.org/info/rfc9051/#RFC7162)\]. They make discovering changes to IMAP mailboxes more efficient, at the expense of storing a bit more state.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-F-2.1)
2.  OBJECTID extension \[[RFC8474](https://www.rfc-editor.org/info/rfc9051/#RFC8474)\] helps with preserving the IMAP client cache when messages are moved/copied or mailboxes are renamed.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-F-2.2)

## [Acknowledgements](https://www.rfc-editor.org/info/rfc9051/#name-acknowledgements) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-name-acknowledgements)

Earlier draft versions of this document were edited by Mark Crispin. Sadly, he is no longer available to help with this work. Editors of this revision are hoping that Mark would have approved.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-G-1)

Chris Newman has contributed text on I18N and use of UTF-8 in messages and mailbox names.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-G-2)

Thank you to Tony Hansen for helping with the index generation. Thank you to Murray Kucherawy, Timo Sirainen, Bron Gondwana, Stephan Bosch, Robert Sparks, Arnt Gulbrandsen, Benjamin Kaduk, Daniel Migaul, Roman Danyliw, and Éric Vyncke for extensive feedback.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-G-3)

This document incorporates text from \[[RFC2342](https://www.rfc-editor.org/info/rfc9051/#RFC2342)\] (by Mike Gahrns and Chris Newman), \[[RFC3516](https://www.rfc-editor.org/info/rfc9051/#RFC3516)\] (by Lyndon Nerenberg), \[[RFC4315](https://www.rfc-editor.org/info/rfc9051/#RFC4315)\] (by Mark Crispin), \[[RFC4466](https://www.rfc-editor.org/info/rfc9051/#RFC4466)\] (by Cyrus Daboo), \[[RFC4731](https://www.rfc-editor.org/info/rfc9051/#RFC4731)\] (by Dave Cridland), \[[RFC4959](https://www.rfc-editor.org/info/rfc9051/#RFC4959)\] (by Rob Siemborski and Arnt Gulbrandsen), \[[RFC5161](https://www.rfc-editor.org/info/rfc9051/#RFC5161)\] (by Arnt Gulbrandsen), \[[RFC5465](https://www.rfc-editor.org/info/rfc9051/#RFC5465)\] (by Arnt Gulbrandsen and Curtis King), \[[RFC5530](https://www.rfc-editor.org/info/rfc9051/#RFC5530)\] (by Arnt Gulbrandsen), \[[RFC5819](https://www.rfc-editor.org/info/rfc9051/#RFC5819)\] (by Timo Sirainen), \[[RFC6154](https://www.rfc-editor.org/info/rfc9051/#RFC6154)\] (by Jamie Nicolson), \[[RFC6851](https://www.rfc-editor.org/info/rfc9051/#RFC6851)\] (by Arnt Gulbrandsen and Ned Freed), and \[[RFC8438](https://www.rfc-editor.org/info/rfc9051/#RFC8438)\] (by Stephan Bosch), so work done by authors/editors of these documents is appreciated. Note that editors of this document were redacted from the above list.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-G-4)

The CHILDREN return option was originally proposed by Mike Gahrns and Raymond Cheng in \[[RFC3348](https://www.rfc-editor.org/info/rfc9051/#RFC3348)\]. Most of the information in [Section 6.3.9.5](https://www.rfc-editor.org/info/rfc9051/#children) is taken directly from their original specification \[[RFC3348](https://www.rfc-editor.org/info/rfc9051/#RFC3348)\].[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-G-5)

Thank you to Damian Poddebniak, Fabian Ising, Hanno Boeck, and Sebastian Schinzel for pointing out that the ENABLE command should be a member of "command-auth" and not "command-any" ABNF production, as well as pointing out security issues associated with ALERT, PREAUTH, and other responses received before authentication.[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-G-6)

## [Index](https://www.rfc-editor.org/info/rfc9051/#name-index) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-name-index)

[$](https://www.rfc-editor.org/info/rfc9051/#rfc.index.u36) [+](https://www.rfc-editor.org/info/rfc9051/#rfc.index.u43) [\-](https://www.rfc-editor.org/info/rfc9051/#rfc.index.u45) [\\](https://www.rfc-editor.org/info/rfc9051/#rfc.index.u92) [A](https://www.rfc-editor.org/info/rfc9051/#rfc.index.u65) [B](https://www.rfc-editor.org/info/rfc9051/#rfc.index.u66) [C](https://www.rfc-editor.org/info/rfc9051/#rfc.index.u67) [D](https://www.rfc-editor.org/info/rfc9051/#rfc.index.u68) [E](https://www.rfc-editor.org/info/rfc9051/#rfc.index.u69) [F](https://www.rfc-editor.org/info/rfc9051/#rfc.index.u70) [H](https://www.rfc-editor.org/info/rfc9051/#rfc.index.u72) [I](https://www.rfc-editor.org/info/rfc9051/#rfc.index.u73) [K](https://www.rfc-editor.org/info/rfc9051/#rfc.index.u75) [L](https://www.rfc-editor.org/info/rfc9051/#rfc.index.u76) [M](https://www.rfc-editor.org/info/rfc9051/#rfc.index.u77) [N](https://www.rfc-editor.org/info/rfc9051/#rfc.index.u78) [O](https://www.rfc-editor.org/info/rfc9051/#rfc.index.u79) [P](https://www.rfc-editor.org/info/rfc9051/#rfc.index.u80) [R](https://www.rfc-editor.org/info/rfc9051/#rfc.index.u82) [S](https://www.rfc-editor.org/info/rfc9051/#rfc.index.u83) [T](https://www.rfc-editor.org/info/rfc9051/#rfc.index.u84) [U](https://www.rfc-editor.org/info/rfc9051/#rfc.index.u85)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-1)

-   -   $Forwarded (predefined flag)
        
        [Section 2.3.2](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-6.2)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.1.2.1.1.4.1.2.1)
        
        $Junk (predefined flag)
        
        [Section 2.3.2](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-6.6)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.1.2.1.1.8.1.2.1)
        
        $MDNSent (predefined flag)
        
        [Section 2.3.2](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-6.4)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.1.2.1.1.12.1.2.1)
        
        $NotJunk (predefined flag)
        
        [Section 2.3.2](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-6.8)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.1.2.1.1.16.1.2.1)
        
        $Phishing (predefined flag)
        
        [Section 2.3.2, Paragraph 6.10.1](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-6.10.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.1.2.1.1.20.1.2.1)
        
-   -   +FLAGS <flag list>
        
        [Section 6.4.6](https://www.rfc-editor.org/info/rfc9051/#section-6.4.6-5.6)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.2.2.1.1.4.1.2.1)
        
        +FLAGS.SILENT <flag list>
        
        [Section 6.4.6](https://www.rfc-editor.org/info/rfc9051/#section-6.4.6-5.8)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.2.2.1.1.8.1.2.1)
        
-   -   \-FLAGS <flag list>
        
        [Section 6.4.6](https://www.rfc-editor.org/info/rfc9051/#section-6.4.6-5.10)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.3.2.1.1.4.1.2.1)
        
        \-FLAGS.SILENT <flag list>
        
        [Section 6.4.6](https://www.rfc-editor.org/info/rfc9051/#section-6.4.6-5.12)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.3.2.1.1.8.1.2.1)
        
-   -   \\All (mailbox name attribute)
        
        [Section 7.3.1](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-9.2)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.4.2.1.1.4.1.2.1)
        
        \\Answered (system flag)
        
        [Section 2.3.2](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-3.4)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.4.2.1.1.8.1.2.1)
        
        \\Archive (mailbox name attribute)
        
        [Section 7.3.1](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-9.4)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.4.2.1.1.12.1.2.1)
        
        \\Deleted (system flag)
        
        [Section 2.3.2](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-3.8)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.4.2.1.1.16.1.2.1)
        
        \\Draft (system flag)
        
        [Section 2.3.2](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-3.10)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.4.2.1.1.20.1.2.1)
        
        \\Drafts (mailbox name attribute)
        
        [Section 7.3.1](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-9.6)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.4.2.1.1.24.1.2.1)
        
        \\Flagged (mailbox name attribute)
        
        [Section 7.3.1](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-9.8)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.4.2.1.1.28.1.2.1)
        
        \\Flagged (system flag)
        
        [Section 2.3.2](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-3.6)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.4.2.1.1.32.1.2.1)
        
        \\HasChildren (mailbox name attribute)
        
        [Section 7.3.1](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-4.8)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.4.2.1.1.36.1.2.1)
        
        \\HasNoChildren (mailbox name attribute)
        
        [Section 7.3.1](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-4.10)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.4.2.1.1.40.1.2.1)
        
        \\Junk (mailbox name attribute)
        
        [Section 7.3.1](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-9.10)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.4.2.1.1.44.1.2.1)
        
        \\Marked (mailbox name attribute)
        
        [Section 7.3.1](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-4.12)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.4.2.1.1.48.1.2.1)
        
        \\Noinferiors (mailbox name attribute)
        
        [Section 7.3.1](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-4.4)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.4.2.1.1.52.1.2.1)
        
        \\NonExistent (mailbox name attribute)
        
        [Section 7.3.1, Paragraph 4.2.1](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-4.2.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.4.2.1.1.56.1.2.1)
        
        \\Noselect (mailbox name attribute)
        
        [Section 7.3.1](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-4.6)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.4.2.1.1.60.1.2.1)
        
        \\Recent (system flag)
        
        [Section 2.3.2](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-3.12)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.4.2.1.1.64.1.2.1)
        
        \\Remote (mailbox name attribute)
        
        [Section 7.3.1](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-4.18)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.4.2.1.1.68.1.2.1)
        
        \\Seen (system flag)
        
        [Section 2.3.2](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-3.2)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.4.2.1.1.72.1.2.1)
        
        \\Sent (mailbox name attribute)
        
        [Section 7.3.1](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-9.12)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.4.2.1.1.76.1.2.1)
        
        \\Subscribed (mailbox name attribute)
        
        [Section 7.3.1](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-4.16)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.4.2.1.1.80.1.2.1)
        
        \\Trash (mailbox name attribute)
        
        [Section 7.3.1](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-9.14)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.4.2.1.1.84.1.2.1)
        
        \\Unmarked (mailbox name attribute)
        
        [Section 7.3.1](https://www.rfc-editor.org/info/rfc9051/#section-7.3.1-4.14)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.4.2.1.1.88.1.2.1)
        
-   -   ALERT (response code)
        
        [Section 7.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.2)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.5.2.1.1.4.1.2.1)
        
        ALL (fetch item)
        
        [Section 6.4.5](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-6.2)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.5.2.1.1.8.1.2.1)
        
        ALL (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.4)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.5.2.1.1.12.1.2.1)
        
        ALL (search result option)
        
        [Section 6.4.4, Paragraph 6.6.1](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-6.6.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.5.2.1.1.16.1.2.1)
        
        ALL (search return item name)
        
        [Section 7.3.4, Paragraph 7.6.1](https://www.rfc-editor.org/info/rfc9051/#section-7.3.4-7.6.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.5.2.1.1.20.1.2.1)
        
        ALREADYEXISTS (response code)
        
        [Section 7.1, Paragraph 4.4.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.4.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.5.2.1.1.24.1.2.1)
        
        ANSWERED (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.6)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.5.2.1.1.28.1.2.1)
        
        APPEND (command)
        
        [Section 6.3.12](https://www.rfc-editor.org/info/rfc9051/#section-6.3.12)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.5.2.1.1.32.1.2.1)
        
        APPENDUID (response code)
        
        [Section 7.1, Paragraph 4.6.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.6.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.5.2.1.1.36.1.2.1)
        
        AUTHENTICATE (command)
        
        [Section 6.2.2](https://www.rfc-editor.org/info/rfc9051/#authenticate)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.5.2.1.1.40.1.2.1)
        
        AUTHENTICATIONFAILED (response code)
        
        [Section 7.1, Paragraph 4.8.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.8.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.5.2.1.1.44.1.2.1)
        
        AUTHORIZATIONFAILED (response code)
        
        [Section 7.1, Paragraph 4.10.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.10.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.5.2.1.1.48.1.2.1)
        
-   -   BAD (response)
        
        [Section 7.1.3](https://www.rfc-editor.org/info/rfc9051/#section-7.1.3)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.6.2.1.1.4.1.2.1)
        
        BADCHARSET (response code)
        
        [Section 7.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.12)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.6.2.1.1.8.1.2.1)
        
        BCC <string> (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.8)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.6.2.1.1.12.1.2.1)
        
        BEFORE <date> (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.10)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.6.2.1.1.16.1.2.1)
        
        BINARY.PEEK\[<section-binary>\]<<partial>> (fetch item)
        
        [Section 6.4.5](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.4)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.6.2.1.1.20.1.2.1)
        
        BINARY.SIZE\[<section-binary>\] (fetch item)
        
        [Section 6.4.5, Paragraph 9.6.1](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.6.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.6.2.1.1.24.1.2.1)
        
        BINARY.SIZE\[<section-binary>\] (fetch result)
        
        [Section 7.5.2, Paragraph 4.4.1](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.4.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.6.2.1.1.28.1.2.1)
        
        BINARY\[<section-binary>\]<<number>> (fetch result)
        
        [Section 7.5.2, Paragraph 4.2.1](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.2.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.6.2.1.1.32.1.2.1)
        
        BINARY\[<section-binary>\]<<partial>> (fetch item)
        
        [Section 6.4.5, Paragraph 9.2.1](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.2.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.6.2.1.1.36.1.2.1)
        
        BODY (fetch item)
        
        [Section 6.4.5](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.8)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.6.2.1.1.40.1.2.1)
        
        BODY (fetch result)
        
        [Section 7.5.2](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.6)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.6.2.1.1.44.1.2.1)
        
        BODY <string> (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.12)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.6.2.1.1.48.1.2.1)
        
        BODY.PEEK\[<section>\]<<partial>> (fetch item)
        
        [Section 6.4.5](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.12)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.6.2.1.1.52.1.2.1)
        
        BODYSTRUCTURE (fetch item)
        
        [Section 6.4.5](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.14)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.6.2.1.1.56.1.2.1)
        
        BODYSTRUCTURE (fetch result)
        
        [Section 7.5.2, Paragraph 4.10.1](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.10.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.6.2.1.1.60.1.2.1)
        
        BODY\[<section>\]<<origin octet>> (fetch result)
        
        [Section 7.5.2, Paragraph 4.8.1](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.8.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.6.2.1.1.64.1.2.1)
        
        BODY\[<section>\]<<partial>> (fetch item)
        
        [Section 6.4.5, Paragraph 9.10.1](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.10.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.6.2.1.1.68.1.2.1)
        
        BYE (response)
        
        [Section 7.1.5](https://www.rfc-editor.org/info/rfc9051/#section-7.1.5)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.6.2.1.1.72.1.2.1)
        
        Body Structure (message attribute)
        
        [Section 2.3.6](https://www.rfc-editor.org/info/rfc9051/#section-2.3.6)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.6.2.1.1.76.1.2.1)
        
-   -   CANNOT (response code)
        
        [Section 7.1, Paragraph 4.14.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.14.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.7.2.1.1.4.1.2.1)
        
        CAPABILITY (command)
        
        [Section 6.1.1](https://www.rfc-editor.org/info/rfc9051/#capability-command)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.7.2.1.1.8.1.2.1)
        
        CAPABILITY (response code)
        
        [Section 7.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.16)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.7.2.1.1.12.1.2.1)
        
        CAPABILITY (response)
        
        [Section 7.2.2](https://www.rfc-editor.org/info/rfc9051/#capability-resp)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.7.2.1.1.16.1.2.1)
        
        CC <string> (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.14)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.7.2.1.1.20.1.2.1)
        
        CLIENTBUG (response code)
        
        [Section 7.1, Paragraph 4.18.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.18.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.7.2.1.1.24.1.2.1)
        
        CLOSE (command)
        
        [Section 6.4.1](https://www.rfc-editor.org/info/rfc9051/#section-6.4.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.7.2.1.1.28.1.2.1)
        
        CLOSED (response code)
        
        [Section 7.1, Paragraph 4.20.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.20.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.7.2.1.1.32.1.2.1)
        
        CONTACTADMIN (response code)
        
        [Section 7.1, Paragraph 4.22.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.22.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.7.2.1.1.36.1.2.1)
        
        COPY (command)
        
        [Section 6.4.7](https://www.rfc-editor.org/info/rfc9051/#copy-command)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.7.2.1.1.40.1.2.1)
        
        COPYUID (response code)
        
        [Section 7.1, Paragraph 4.24.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.24.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.7.2.1.1.44.1.2.1)
        
        CORRUPTION (response code)
        
        [Section 7.1, Paragraph 4.26.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.26.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.7.2.1.1.48.1.2.1)
        
        COUNT (search result option)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-6.8)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.7.2.1.1.52.1.2.1)
        
        COUNT (search return item name)
        
        [Section 7.3.4](https://www.rfc-editor.org/info/rfc9051/#section-7.3.4-7.8)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.7.2.1.1.56.1.2.1)
        
        CREATE (command)
        
        [Section 6.3.4](https://www.rfc-editor.org/info/rfc9051/#section-6.3.4)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.7.2.1.1.60.1.2.1)
        
-   -   DELETE (command)
        
        [Section 6.3.5](https://www.rfc-editor.org/info/rfc9051/#section-6.3.5)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.8.2.1.1.4.1.2.1)
        
        DELETED (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.16)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.8.2.1.1.8.1.2.1)
        
        DELETED (status item)
        
        [Section 6.3.11](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11-9.10)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.8.2.1.1.12.1.2.1)
        
        DRAFT (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.18)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.8.2.1.1.16.1.2.1)
        
-   -   ENABLE (command)
        
        [Section 6.3.1](https://www.rfc-editor.org/info/rfc9051/#enable-command)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.9.2.1.1.4.1.2.1)
        
        ENVELOPE (fetch item)
        
        [Section 6.4.5](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.16)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.9.2.1.1.8.1.2.1)
        
        ENVELOPE (fetch result)
        
        [Section 7.5.2, Paragraph 4.42.1](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.42.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.9.2.1.1.12.1.2.1)
        
        ESEARCH (response)
        
        [Section 7.3.4](https://www.rfc-editor.org/info/rfc9051/#section-7.3.4)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.9.2.1.1.16.1.2.1)
        
        EXAMINE (command)
        
        [Section 6.3.3](https://www.rfc-editor.org/info/rfc9051/#section-6.3.3)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.9.2.1.1.20.1.2.1)
        
        EXPIRED (response code)
        
        [Section 7.1, Paragraph 4.28.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.28.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.9.2.1.1.24.1.2.1)
        
        EXPUNGE (command)
        
        [Section 6.4.3](https://www.rfc-editor.org/info/rfc9051/#section-6.4.3)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.9.2.1.1.28.1.2.1)
        
        EXPUNGE (response)
        
        [Section 7.5.1](https://www.rfc-editor.org/info/rfc9051/#expunge-response)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.9.2.1.1.32.1.2.1)
        
        EXPUNGEISSUED (response code)
        
        [Section 7.1, Paragraph 4.30.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.30.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.9.2.1.1.36.1.2.1)
        
        Envelope Structure (message attribute)
        
        [Section 2.3.5](https://www.rfc-editor.org/info/rfc9051/#section-2.3.5)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.9.2.1.1.40.1.2.1)
        
-   -   FAST (fetch item)
        
        [Section 6.4.5](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-6.4)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.10.2.1.1.4.1.2.1)
        
        FETCH (command)
        
        [Section 6.4.5](https://www.rfc-editor.org/info/rfc9051/#fetch-command)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.10.2.1.1.8.1.2.1)
        
        FETCH (response)
        
        [Section 7.5.2](https://www.rfc-editor.org/info/rfc9051/#fetch-response)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.10.2.1.1.12.1.2.1)
        
        FLAGGED (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.20)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.10.2.1.1.16.1.2.1)
        
        FLAGS (fetch item)
        
        [Section 6.4.5](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.18)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.10.2.1.1.20.1.2.1)
        
        FLAGS (fetch result)
        
        [Section 7.5.2](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.44)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.10.2.1.1.24.1.2.1)
        
        FLAGS (response)
        
        [Section 7.3.5](https://www.rfc-editor.org/info/rfc9051/#flags-resp)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.10.2.1.1.28.1.2.1)
        
        FLAGS <flag list> (store command data item)
        
        [Section 6.4.6](https://www.rfc-editor.org/info/rfc9051/#section-6.4.6-5.2)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.10.2.1.1.32.1.2.1)
        
        FLAGS.SILENT <flag list> (store command data item)
        
        [Section 6.4.6](https://www.rfc-editor.org/info/rfc9051/#section-6.4.6-5.4)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.10.2.1.1.36.1.2.1)
        
        FROM <string> (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.22)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.10.2.1.1.40.1.2.1)
        
        FULL (fetch item)
        
        [Section 6.4.5](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-6.6)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.10.2.1.1.44.1.2.1)
        
        Flags (message attribute)
        
        [Section 2.3.2](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.10.2.1.1.48.1.2.1)
        
-   -   HASCHILDREN (response code)
        
        [Section 7.1, Paragraph 4.32.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.32.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.11.2.1.1.4.1.2.1)
        
        HEADER (part specifier)
        
        [Section 6.4.5.1, Paragraph 5](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5.1-5)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.11.2.1.1.8.1.2.1)
        
        HEADER <field-name> <string> (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.24)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.11.2.1.1.12.1.2.1)
        
        HEADER.FIELDS (part specifier)
        
        [Section 6.4.5.1, Paragraph 5](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5.1-5)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.11.2.1.1.16.1.2.1)
        
        HEADER.FIELDS.NOT (part specifier)
        
        [Section 6.4.5.1, Paragraph 5](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5.1-5)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.11.2.1.1.20.1.2.1)
        
-   -   IDLE (command)
        
        [Section 6.3.13](https://www.rfc-editor.org/info/rfc9051/#idle)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.12.2.1.1.4.1.2.1)
        
        INTERNALDATE ( fetch item)
        
        [Section 6.4.5](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.20)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.12.2.1.1.8.1.2.1)
        
        INTERNALDATE (fetch result)
        
        [Section 7.5.2](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.46)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.12.2.1.1.12.1.2.1)
        
        INUSE (response code)
        
        [Section 7.1, Paragraph 4.34.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.34.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.12.2.1.1.16.1.2.1)
        
        Internal Date (message attribute)
        
        [Section 2.3.3](https://www.rfc-editor.org/info/rfc9051/#section-2.3.3)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.12.2.1.1.20.1.2.1)
        
-   -   KEYWORD <flag> (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.26)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.13.2.1.1.4.1.2.1)
        
        Keyword (type of flag)
        
        [Section 2.3.2, Paragraph 4](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-4)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.13.2.1.1.8.1.2.1)
        
-   -   LARGER <n> (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.28)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.14.2.1.1.4.1.2.1)
        
        LIMIT (response code)
        
        [Section 7.1, Paragraph 4.36.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.36.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.14.2.1.1.8.1.2.1)
        
        LIST (command)
        
        [Section 6.3.9](https://www.rfc-editor.org/info/rfc9051/#list-cmd)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.14.2.1.1.12.1.2.1)
        
        LIST (response)
        
        [Section 7.3.1](https://www.rfc-editor.org/info/rfc9051/#list-resp)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.14.2.1.1.16.1.2.1)
        
        LOGOUT (command)
        
        [Section 6.1.3](https://www.rfc-editor.org/info/rfc9051/#section-6.1.3)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.14.2.1.1.20.1.2.1)
        
-   -   MAX (search result option)
        
        [Section 6.4.4, Paragraph 6.4.1](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-6.4.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.15.2.1.1.4.1.2.1)
        
        MAX (search return item name)
        
        [Section 7.3.4, Paragraph 7.4.1](https://www.rfc-editor.org/info/rfc9051/#section-7.3.4-7.4.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.15.2.1.1.8.1.2.1)
        
        MAY (specification requirement term)
        
        [Section 1.2](https://www.rfc-editor.org/info/rfc9051/#section-1.2)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.15.2.1.1.12.1.2.1)
        
        MESSAGES (status item)
        
        [Section 6.3.11](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11-9.2)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.15.2.1.1.16.1.2.1)
        
        MIME (part specifier)
        
        [Section 6.4.5.1, Paragraph 7](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5.1-7)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.15.2.1.1.20.1.2.1)
        
        MIN (search result option)
        
        [Section 6.4.4, Paragraph 6.2.1](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-6.2.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.15.2.1.1.24.1.2.1)
        
        MIN (search return item name)
        
        [Section 7.3.4, Paragraph 7.2.1](https://www.rfc-editor.org/info/rfc9051/#section-7.3.4-7.2.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.15.2.1.1.28.1.2.1)
        
        MOVE (command)
        
        [Section 6.4.8](https://www.rfc-editor.org/info/rfc9051/#section-6.4.8)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.15.2.1.1.32.1.2.1)
        
        MUST (specification requirement term)
        
        [Section 1.2](https://www.rfc-editor.org/info/rfc9051/#section-1.2)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.15.2.1.1.36.1.2.1)
        
        MUST NOT (specification requirement term)
        
        [Section 1.2](https://www.rfc-editor.org/info/rfc9051/#section-1.2)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.15.2.1.1.40.1.2.1)
        
        Message Sequence Number (message attribute)
        
        [Section 2.3.1.2](https://www.rfc-editor.org/info/rfc9051/#section-2.3.1.2)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.15.2.1.1.44.1.2.1)
        
-   -   NAMESPACE (command)
        
        [Section 6.3.10](https://www.rfc-editor.org/info/rfc9051/#section-6.3.10)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.16.2.1.1.4.1.2.1)
        
        NAMESPACE (response)
        
        [Section 7.3.2](https://www.rfc-editor.org/info/rfc9051/#section-7.3.2)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.16.2.1.1.8.1.2.1)
        
        NO (response)
        
        [Section 7.1.2](https://www.rfc-editor.org/info/rfc9051/#section-7.1.2)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.16.2.1.1.12.1.2.1)
        
        NONEXISTENT (response code)
        
        [Section 7.1, Paragraph 4.38.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.38.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.16.2.1.1.16.1.2.1)
        
        NOOP (command)
        
        [Section 6.1.2](https://www.rfc-editor.org/info/rfc9051/#section-6.1.2)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.16.2.1.1.20.1.2.1)
        
        NOPERM (response code)
        
        [Section 7.1, Paragraph 4.40.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.40.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.16.2.1.1.24.1.2.1)
        
        NOT <search-key> (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.30)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.16.2.1.1.28.1.2.1)
        
        NOT RECOMMENDED (specification requirement term)
        
        [Section 1.2](https://www.rfc-editor.org/info/rfc9051/#section-1.2)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.16.2.1.1.32.1.2.1)
        
-   -   OK (response)
        
        [Section 7.1.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.17.2.1.1.4.1.2.1)
        
        ON <date> (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.32)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.17.2.1.1.8.1.2.1)
        
        OPTIONAL (specification requirement term)
        
        [Section 1.2](https://www.rfc-editor.org/info/rfc9051/#section-1.2); [Section 1.2](https://www.rfc-editor.org/info/rfc9051/#section-1.2)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.17.2.1.1.12.1.2.1)
        
        OR <search-key1> <search-key2> (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.34)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.17.2.1.1.16.1.2.1)
        
        OVERQUOTA (response code)
        
        [Section 7.1, Paragraph 4.42.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.42.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.17.2.1.1.20.1.2.1)
        
-   -   PARSE (response code)
        
        [Section 7.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.44)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.18.2.1.1.4.1.2.1)
        
        PERMANENTFLAGS (response code)
        
        [Section 7.1, Paragraph 4.46.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.46.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.18.2.1.1.8.1.2.1)
        
        PREAUTH (response)
        
        [Section 7.1.4](https://www.rfc-editor.org/info/rfc9051/#preauth-resp)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.18.2.1.1.12.1.2.1)
        
        PRIVACYREQUIRED (response code)
        
        [Section 7.1, Paragraph 4.48.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.48.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.18.2.1.1.16.1.2.1)
        
        Permanent Flag (class of flag)
        
        [Section 2.3.2, Paragraph 9](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-9)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.18.2.1.1.20.1.2.1)
        
        Predefined keywords
        
        [Section 2.3.2, Paragraph 5](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-5)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.18.2.1.1.24.1.2.1)
        
-   -   READ-ONLY (response code)
        
        [Section 7.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.50)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.19.2.1.1.4.1.2.1)
        
        READ-WRITE (response code)
        
        [Section 7.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.52)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.19.2.1.1.8.1.2.1)
        
        RECOMMENDED (specification requirement term)
        
        [Section 1.2](https://www.rfc-editor.org/info/rfc9051/#section-1.2)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.19.2.1.1.12.1.2.1)
        
        RENAME (command)
        
        [Section 6.3.6](https://www.rfc-editor.org/info/rfc9051/#section-6.3.6)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.19.2.1.1.16.1.2.1)
        
        REQUIRED (specification requirement term)
        
        [Section 1.2](https://www.rfc-editor.org/info/rfc9051/#section-1.2)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.19.2.1.1.20.1.2.1)
        
        RFC822.SIZE (fetch item)
        
        [Section 6.4.5](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.22)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.19.2.1.1.24.1.2.1)
        
        RFC822.SIZE (fetch result)
        
        [Section 7.5.2](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.48)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.19.2.1.1.28.1.2.1)
        
        RFC822.SIZE (message attribute)
        
        [Section 2.3.4](https://www.rfc-editor.org/info/rfc9051/#RFC822.SIZE_message_attribute)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.19.2.1.1.32.1.2.1)
        
-   -   SAVE (search result option)
        
        [Section 6.4.4, Paragraph 6.10.1](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-6.10.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.20.2.1.1.4.1.2.1)
        
        SEARCH (command)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.20.2.1.1.8.1.2.1)
        
        SEEN (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.36)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.20.2.1.1.12.1.2.1)
        
        SELECT (command)
        
        [Section 6.3.2](https://www.rfc-editor.org/info/rfc9051/#section-6.3.2)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.20.2.1.1.16.1.2.1)
        
        SENTBEFORE <date> (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.38)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.20.2.1.1.20.1.2.1)
        
        SENTON <date> (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.40)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.20.2.1.1.24.1.2.1)
        
        SENTSINCE <date> (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.42)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.20.2.1.1.28.1.2.1)
        
        SERVERBUG (response code)
        
        [Section 7.1, Paragraph 4.54.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.54.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.20.2.1.1.32.1.2.1)
        
        SHOULD (specification requirement term)
        
        [Section 1.2](https://www.rfc-editor.org/info/rfc9051/#section-1.2)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.20.2.1.1.36.1.2.1)
        
        SHOULD NOT (specification requirement term)
        
        [Section 1.2](https://www.rfc-editor.org/info/rfc9051/#section-1.2)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.20.2.1.1.40.1.2.1)
        
        SINCE <date> (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.44)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.20.2.1.1.44.1.2.1)
        
        SIZE (status item)
        
        [Section 6.3.11](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11-9.12)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.20.2.1.1.48.1.2.1)
        
        SMALLER <n> (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.46)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.20.2.1.1.52.1.2.1)
        
        STARTTLS (command)
        
        [Section 6.2.1](https://www.rfc-editor.org/info/rfc9051/#STARTTLS)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.20.2.1.1.56.1.2.1)
        
        STATUS (command)
        
        [Section 6.3.11](https://www.rfc-editor.org/info/rfc9051/#status-command)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.20.2.1.1.60.1.2.1)
        
        STATUS (response)
        
        [Section 7.3.3](https://www.rfc-editor.org/info/rfc9051/#section-7.3.3)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.20.2.1.1.64.1.2.1)
        
        STORE (command)
        
        [Section 6.4.6](https://www.rfc-editor.org/info/rfc9051/#section-6.4.6)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.20.2.1.1.68.1.2.1)
        
        SUBJECT <string> (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.48)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.20.2.1.1.72.1.2.1)
        
        SUBSCRIBE (command)
        
        [Section 6.3.7](https://www.rfc-editor.org/info/rfc9051/#section-6.3.7)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.20.2.1.1.76.1.2.1)
        
        Session Flag (class of flag)
        
        [Section 2.3.2, Paragraph 9](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-9)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.20.2.1.1.80.1.2.1)
        
        System Flag (type of flag)
        
        [Section 2.3.2, Paragraph 2](https://www.rfc-editor.org/info/rfc9051/#section-2.3.2-2)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.20.2.1.1.84.1.2.1)
        
-   -   TEXT (part specifier)
        
        [Section 6.4.5.1, Paragraph 5](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5.1-5)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.21.2.1.1.4.1.2.1)
        
        TEXT <string> (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.50)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.21.2.1.1.8.1.2.1)
        
        TO <string> (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.52)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.21.2.1.1.12.1.2.1)
        
        TRYCREATE (response code)
        
        [Section 7.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.56)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.21.2.1.1.16.1.2.1)
        
-   -   UID (command)
        
        [Section 6.4.9](https://www.rfc-editor.org/info/rfc9051/#uid-commands)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.22.2.1.1.4.1.2.1)
        
        UID (fetch item)
        
        [Section 6.4.5](https://www.rfc-editor.org/info/rfc9051/#section-6.4.5-9.24)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.22.2.1.1.8.1.2.1)
        
        UID (fetch result)
        
        [Section 7.5.2](https://www.rfc-editor.org/info/rfc9051/#section-7.5.2-4.50)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.22.2.1.1.12.1.2.1)
        
        UID <sequence set> (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.54)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.22.2.1.1.16.1.2.1)
        
        UIDNEXT (response code)
        
        [Section 7.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.58)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.22.2.1.1.20.1.2.1)
        
        UIDNEXT (status item)
        
        [Section 6.3.11](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11-9.4)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.22.2.1.1.24.1.2.1)
        
        UIDNOTSTICKY (response code)
        
        [Section 7.1, Paragraph 4.60.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.60.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.22.2.1.1.28.1.2.1)
        
        UIDVALIDITY (response code)
        
        [Section 7.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.62)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.22.2.1.1.32.1.2.1)
        
        UIDVALIDITY (status item)
        
        [Section 6.3.11](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11-9.6)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.22.2.1.1.36.1.2.1)
        
        UNANSWERED (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.56)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.22.2.1.1.40.1.2.1)
        
        UNAVAILABLE (response code)
        
        [Section 7.1, Paragraph 4.64.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.64.1)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.22.2.1.1.44.1.2.1)
        
        UNDELETED (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.58)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.22.2.1.1.48.1.2.1)
        
        UNDRAFT (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.60)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.22.2.1.1.52.1.2.1)
        
        UNFLAGGED (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.62)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.22.2.1.1.56.1.2.1)
        
        UNKEYWORD <flag> (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.64)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.22.2.1.1.60.1.2.1)
        
        UNKNOWN-CTE (response code)
        
        [Section 7.1](https://www.rfc-editor.org/info/rfc9051/#section-7.1-4.66)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.22.2.1.1.64.1.2.1)
        
        UNSEEN (search key)
        
        [Section 6.4.4](https://www.rfc-editor.org/info/rfc9051/#section-6.4.4-15.66)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.22.2.1.1.68.1.2.1)
        
        UNSEEN (status item)
        
        [Section 6.3.11](https://www.rfc-editor.org/info/rfc9051/#section-6.3.11-9.8)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.22.2.1.1.72.1.2.1)
        
        UNSELECT (command)
        
        [Section 6.4.2](https://www.rfc-editor.org/info/rfc9051/#section-6.4.2)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.22.2.1.1.76.1.2.1)
        
        UNSUBSCRIBE (command)
        
        [Section 6.3.8](https://www.rfc-editor.org/info/rfc9051/#section-6.3.8)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.22.2.1.1.80.1.2.1)
        
        Unique Identifier (UID) (message attribute)
        
        [Section 2.3.1.1](https://www.rfc-editor.org/info/rfc9051/#uid-def)[¶](https://www.rfc-editor.org/info/rfc9051/#appendix-H-2.22.2.1.1.84.1.2.1)
        

## [Authors' Addresses](https://www.rfc-editor.org/info/rfc9051/#name-authors-addresses) [Skip to TOC](https://www.rfc-editor.org/info/rfc9051/#toc-name-authors-addresses)

Alexey Melnikov (editor)

Isode Ltd

14 Castle Mews

Hampton, Middlesex

TW12 2NP

United Kingdom

Barry Leiba (editor)

Futurewei Technologies