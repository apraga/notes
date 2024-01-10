```{=org}
#+filetags: personal
```
# Proton mail bridge

    proton-mail-bridge -n

# Mbsync

> IMAPAccount proton Host 127.0.0.1 Port 1143 User USER Pass PASSWD
> SSLType STARTTLS SSLVersions TLSv1.2 CertificateFile
> \~/.config/protonmail/bridge/cert.pem
>
> IMAPStore proton-remote Account proton
>
> MaildirStore proton-local Subfolders Verbatim
>
> Path \~/mail/proton/
>
> Channel proton Far :proton-remote: Near :proton-local: Patterns \*
> Create Both Expunge Both SyncState \*
