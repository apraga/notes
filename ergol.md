Idéalement, on veut ergoL avec en plus 
- angle-mod pour les clavier iso
- des raccourcis pour ctr & co
  Tout cela est donné par kanata + arsenik  https://ergol.org/claviers/arsenik/
  Mais sous windows, kanata ne fonctionne pas bien. Donc on utilise les layers-tap et home row mais sans angle-mod
  (Il y a une version portabl d'ergol qui fonctionne bien sous windows)
  On perd un peu en confort mais on gagne en portabilité

Dans `~/.config/systemd/user/kanata.service`

[Unit]
Description=Kanata keyboard remapper
Documentation=https://github.com/jtroo/kanata

[Service]
Environment=PATH=_usr/local/bin:/usr/local/sbin:/usr/bin:/bin
Environment=DISPLAY=:0
Environment=HOME=/home/alex
Type=simple
ExecStart=/home/alex_.cargo/bin/kanata --cfg  /home/alex/ergol/kanata.kbd
Restart=no

[Install]
WantedBy=default.target