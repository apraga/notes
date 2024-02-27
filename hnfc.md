Pour firefox, on ajoute le certificat dans le navigateur
Pour mettre à jour gentoo, merge
Pour pouvoir faire des git clone, crééer le fichier suivant pour activer "usafe legacy renegociation" (ne marche pas toujours)

```~/.unsafe-ssl-hnfc.cnf
openssl_conf = openssl_init

[openssl_init]
ssl_conf = ssl_sect

[ssl_sect]
system_default = system_default_sect

[system_default_sect]
Options = UnsafeLegacyRenegotiation
```
puis

    $env.OPENSSL_CONF = /home/alex/.unsafe-ssl-hnfc.cnf

Note: il y a régulièrement des erreurs de transfert...
