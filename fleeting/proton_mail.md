```{=org}
#+filetags: personal
```
# Gentoo + sway

Installer proton-mail-bridge
Configurer pass
Installer gnome-keyring ??
Il semble falloir utiliser

dbus-update-activation-environment --all

Puis 

proton-mail-bridge --cli

>> login
>> (adresse mail proton)
>> (mot de passe proton)
>> (Two factor password)

Il faut exporter le certificat 

>> export-tils-cert
>> /home/alex/.config/bridge-v3/

Attention, il faut un dossier et non un fichier !
    proton-mail-bridge -n

# Synchronisation des mails avec mBsync

    IMAPAccount protonmail
    Host 127.0.0.1
    Port 1143
    User MYUSER
    Pass  BRIDGEPASS
    SSLType STARTTLS
    # Export it with the cli and "export-tils" followwed by a path to a directory
    CertificateFile \~/.config/protonmail/bridge-v3/cert.pem

    IMAPStore pm-remote
    Account protonmail

    MaildirStore pm-local
    Path ~/mail/
    Inbox ~/mail/INBOX/

    Channel pm-inbox
    Far :pm-remote:
    Near :pm-local:
    Patterns "INBOX"
    Create Both
    Expunge Both
    SyncState *

    Channel pm-sent
    Far :pm-remote:"Sent"
    Near :pm-local:"sent"
    Create Both
    Expunge Both
    SyncState *

    Group protonmail
    Channel pm-inbox
    Channel pm-sent

    IMAPAccount proton 
    Host 127.0.0.1 
    Port 1143 
    User USER 
    Pass PASSWD
    SSLType STARTTLS 
    SSLVersions TLSv1.2 
    CertificateFile \~/.config/protonmail/bridge/cert.pem
 
    IMAPStore proton-remote 
    Account proton
    MaildirStore proton-local 
    Subfolders Verbatim
    > 
    Path \~/mail/proton/
    > 
    Channel proton Far :proton-remote: Near :proton-local: Patterns \*
     Create Both Expunge Both SyncState \*

# Interface : Notmuch (recherche etc)

Définire /home/alex/mail puis `notmuch new`


# Client mail

Échec de la configuration de SMTP directement dans aerc ou neomutt. Le plus simple est d'utiliser msmtp 

## Mmstp
.msmtprc


    account proton
    host 127.0.0.1
    port 1025
    from USER@proton.me
    user USER@proton.me
    password BRIDGEPASS
    auth login

    account default: proton

Puis `chmod 600 .msmtprc`
TODO: utiliser pass avec passwrdeval

## Aerc

Activer le flag notmuch lors de l'installation (gentoo). 
Configuration : suivre le tutorial et éditer ~/.config/aerc/account.conf

    [Proton]
    source        = notmuch://~/mail
    query-map = ~/.config/aerc/map.conf
    outgoing      = msmtp
    default       = INBOX
    from          = "Alexis Praga" <alexis.praga@proton.me>
    copy-to = Sent
    cache-headers = true
    start-tls = false
