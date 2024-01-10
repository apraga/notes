```{=org}
#+filetags: emacs mail
```
# KILL Global

A bit slow with imap Offline usage : notmuch does not work ... See
<https://ding.gnus.narkive.com/kJo5yKca/nnir-and-notmuch> We have to use
mairix

But works well with news !
<https://emacs.stackexchange.com/questions/38739/how-can-i-subscribe-to-se-rss-feed-using-gnus>
In the end, slower than notmuch inside emacs (start + search) but I
prefer it to read news. Trying it at the moment

# KILL Mairix config

Mairixrc

``` example
base=~/Mail/
maildir=gmail/inbox:gmail/archive:free/inbox:free/archive:archive
mformat=maildir
database=~/.mairix/database
mfolder=~/.mairix/mfolder
```

Warning: not recursive !

Follow the manual instruction. Important: do not answer \"no\" for
hidden folder (maildir++) !

``` example
(setq user-mail-address#&quot;XX&quot;
      user-full-name#&quot;Alexis Praga&quot;)

(setq gnus-select-method '(nnnil &quot;&quot;))
(setq gnus-secondary-select-methods
      ;; Reading FSS feeds (not all of them works)
      '((nntp &quot;news.gwene.org&quot;)
;; Too slow, we prefer notmuch
         (nnmaildir &quot;free&quot;
                    (directory &quot;~/Mail/free/&quot;))
         (nnmaildir &quot;gmail&quot;
                    (directory &quot;~/Mail/gmail/&quot;)))))


;; Does not work
;;(setq nnir-search-engine 'notmuch)
;; This start a notmuch request but with the wrong arguments...
;; &quot;(push (cons 'nnmaildir 'notmuch) nnir-method-default-engines)
;;
(setq message-send-mail-function 'message-send-mail-with-sendmail)
  (setq sendmail-program &quot;/usr/bin/msmtp&quot;)

(setq mm-text-html-renderer 'gnus-w3m)
(setq gnus-inhibit-images nil)
```

# KILL What about sent mails

Initially, I wanted a copy in a maildir folder. It turns out it\'s
already on Gmail server in both all mail and sent mail. I\'m not sure
anymore to need a specific \"sent\" folder for gmail. So I only sync the
\"sent\" folder on my Free account
