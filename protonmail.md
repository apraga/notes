Installer proton-mail-bridge 

Configurer pass ou installer gnome-keyring ??
Il semble falloir utiliser
dbus-update-activation-environment --all

proton-mail-bridge --cli
login (adresse mail proton) (mot de passe proton) (Two factor password)

Il faut exporter le certificat (avec proton-mail-gui car je n'ai pas trouvé comment lui faire accepter en ligne de commande..)
Choisir un dossier (~/.config/protonmail)


# Synchronisation des mails avec mBsync

> IMAPAccount protonmail
> Host 127.0.0.1
> Port 1143
> User MYUSER
> Pass  BRIDGEPASS
> SSLType STARTTLS
> # Export it with the cli and "export-tils" followwed by a path to a directory
> CertificateFile \~/.config/protonmail/cert.pem
> 
IMAPStore pm-remote
Account protonmail
> MaildirStore pm-local
> Path ~_mail_
> Inbox ~_mail/INBOX_
> 
> Channel pm-inbox
> Far :pm-remote:
> Near :pm-local:
> Patterns "INBOX"
> Create Both
> Expunge Both
> SyncState *
> 
> Channel pm-sent
> Far :pm-remote:"Sent"
> Near :pm-local:"sent"
> Create Both
> Expunge Both
> SyncState *
> 
> Group protonmail
> Channel pm-inbox
> Channel pm-sent


# InterfaceNotmuch (recherche etc)
Définire /home/alex/mail puis =notmuch new=



# Client mail

Échec de la configuration de SMTP directement dans aerc ou neomutt. Le
plus simple est d'utiliser msmtp


## Mmstp




> account proton
> host 127.0.0.1
> port 1025
> from USER@proton.me
> user USER@proton.me
> password BRIDGEPASS
> auth login
> account default: proton

Puis =chmod 600 .msmtprc= TODO: utiliser pass avec passwrdeval


## Aerc

Activer le flag notmuch lors de l'installation (gentoo). Configuration :
suivre le tutorial et éditer ~/.config/aerc/account.conf

> [Proton]
> source        = notmuch://~/mail
> query-map = ~/.config/aerc/map.conf
> outgoing      = msmtp
> default       = INBOX
> from          = "Alexis Praga" alexis.praga@proton.me
> copy-to = Sent
> cache-headers = true
> start-tls = false
