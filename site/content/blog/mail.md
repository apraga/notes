+++
title = "Command-line mail"
date = 2020-10-01
+++

Today, we will see how to get mails, read them, and answer them, inside
a terminal. We will need four utilities for that :

-   one to synchronize our local mails with the server :
    `mbsync`{.verbatim},
-   a mail client for viewing them : emacs with `notmuch`{.verbatim}
-   an agent for sending mails : `msmtp`{.verbatim} a good choice (or
    sendmail, which should be installed by default on most Linux and BSD
    distribution )

Install each of this utilities according to the usual way of your
distribution. The following tutorial assumes you have two accounts, one
of them being Gmail.

## Mbsync and Gmail

Here we will configure a gmail account using `~/.msmtprc`{.verbatim}.
Let\'s break down the configuration file. First, for increased security,
generate an app password using
<https://myaccount.google.com/apppasswords> and encrypt it with gpg:

```bash
#---------------------------------
# Gmail
#---------------------------------
IMAPAccount gmail
# Address to connect to
Host imap.gmail.com
User alexis.praga@gmail.com
PassCmd "gpg2 -q --for-your-eyes-only --no-tty -d ~/.gmailpass.gpg"
# Use SSL
SSLType IMAPS
CertificateFile /usr/local/share/certs/ca-root-nss.crt

IMAPStore gmail-remote
Account gmail
```

Then define the folders for your mail. `~mail/gmail`{.verbatim} contains
an Inbox and an Archive folder. It must be of the `maildir`{.verbatim}
format. Using the fish shell syntax:

```bash
for i in cur new tmp
  mkdir -p ~/mail/gmail/inbox/$i
  mkdir -p ~/mail/gmail/archive/$i
end
```

Now, return to `~/.mbsyncrc`{.verbatim}:

```bash
MaildirStore gmail-local
# Important: we need to be able to move files. The "native" setting results in duplicates and errors+++
AltMap yes
Subfolders Verbatim
# The trailing "/" is important
Path ~/mail/gmail/
Inbox ~/mail/gmail/inbox
```

Then the hard part: how to synchronize folders with gmail ? I\'ve chosen
to put incoming mail in `inbox`{.verbatim} and everything else in
`archive`{.verbatim}

```bash
# Exclude everything under the internal [Gmail] folder, except the interesting folders
# ALl (and I mean all) mail is in All mail.
# With this setup, we have duplicates in inbox and in all mail (that's ok, should not be much)
# There is no need for sent folder as it is also in all mail+++
# We also need deleted messages because the iPhone do not delete mail but create
# this label instead+++ So we have to get it here, delete et sync with the
# server
Channel gmail-default
Far :gmail-remote:
Near :gmail-local:
# Select some mailboxes to sync
Patterns "INBOX"
Create Near
# Save the synchronization state files in the relevant directory
SyncState *

# Name translation
Channel gmail-archive
Far :gmail-remote:"[Gmail]/All Mail"
Near :gmail-local:archive
Create Near
SyncState *

Channel gmail-trash
Far :gmail-remote:"Deleted Messages"
Near :gmail-local:trash
Create Near
SyncState *

# Get all the channels together into a group.
Group googlemail
Channel gmail-default
Channel gmail-archive
Channel gmail-trash
```

A second account can be set the same way :

```bash
#---------------------------------
# Free
#---------------------------------
IMAPAccount free
# Address to connect to
Host imap.free.fr
User alexis.praga@free.fr
# The file is encrypted with "gpg -e"
PassCmd "gpg2 -q --for-your-eyes-only --no-tty -d ~/.freepass.gpg"
# Use SSL
SSLType IMAPS
CertificateFile /usr/local/share/certs/ca-root-nss.crt

IMAPStore free-remote
Account free

MaildirStore free-local
# Important: we need to be able to move files. The "native" setting results in duplicates and errors+++
AltMap yes
Subfolders Verbatim
# The trailing "/" is important
Path ~/mail/free/
Inbox ~/mail/free/inbox

Channel free-default
Far :free-remote:
Near :free-local:
Patterns "INBOX"
Create Near
SyncState *

# Name translation
Channel free-archive
Far :free-remote:"Archive"
Near :free-local:archive
Create Near
SyncState *

# Name translation
Channel free-sent
Far :free-remote:"Sent"
Near :free-local:sent
Create Near
SyncState *

# Get all the channels together into a group.
Group freemail
Channel free-default
Channel free-archive
```

## Msmtp

To send mail, I use the gmail account for that :

```bash
# Set default values for all following accounts.
defaults
auth           on
tls            on
tls_trust_file /usr/local/share/certs/ca-root-nss.crt
logfile        ~/.msmtp.log

# Gmail
account        gmail
host           smtp.gmail.com
port           587
from           horse1@gmail.com
user           john.doe
password       XXXXXXX

# Set a default account
account default : gmail
```

Change the permissions :

```bash
$ chmod 600 ~/.msmtprc
```

Then, you can try sending mail with the following command :

```bash
$ cat test.mail | msmtp -a default account1@gmail.com 
```

where test.mail is an simple file like this one (there must be an empty
line after the subject):

```bash
To: account1@gmail.com
From: fake@gmail.com
Subject: Test &lt;br/&gt; 

Hello !
```

## Notmuch and emacs

Notmuch is an awesome tool to manage your mail. Basically, it does not
touch your mail but rather operates on tags. So an incoming mail will be
tagged as `inbox`{.verbatim} and if you delete it, it will be replaced
by the `deleted`{.verbatim} tag. It allows for fast indexing and quick
search of your mail. The only drawback is that it does **not** move your
mail. So deleting for real must be done manually.

Anway, it\'s awesome and you should use it in 2021 !

Configuration is pretty straightforward. The first time, run

```bash
notmuch
notmuch new
```

and follow the instructions.

Then I have a script running as a cron job to synchronize my mail and
move mails in the proper folder (`inbox`{.verbatim},
`archive`{.verbatim}) or delete it :

```bash
#!/usr/local/bin/fish

# Combine mbsync and notmuch because mbsync may fail and we still want notmuch to run (as we keep getting quota errors)
# So we must have the two command here

mbsync -a

set args --output=files --format=text0

# Tagsent mails (by default, there are not tagged)
set filter "(folder:gmail/inbox or folder:free/inbox or tag:inbox) and from:\"Alexis Praga\""
notmuch tag +sent +archived -inbox --  $filter

# Move archived mail from inbox to archive folder
set filter tag:archived folder:gmail/inbox
notmuch search $args $filter  | xargs -0 -J {} mv {} ~/mail/gmail/archive/cur

set filter tag:archived folder:free/inbox
notmuch search $args $filter  | xargs -0 -J {} mv {} ~/mail/free/archive/cur

# Really delete "deleted messages" from gmail
set filter "folder:gmail/trash"
notmuch tag +deleted --  $filter

# delete mails as notmuch cannot do it
set filter "(folder:free/inbox or folder:gmail/inbox or folder:gmail/trash) and tag:deleted"
notmuch search $args $filter  | xargs -0 -J {} mv {} ~/mail/trash/cur

# Get new mail
notmuch new

❯ crontab -l
MAILTO=""
*/5 * * * * $HOME/scripts/mbsync_notmuch.sh
```

Then I can read the email inside emacs with the `notmuch`{.verbatim}
plugin.

## What about gnus ?

I\'ve tried it two times because the concept was appealing: manage your
mail as a newserver is cool. The major drawback is the lack of
integration for notmuch. You can make it work with `mairix`{.verbatim}
but its super slow.
