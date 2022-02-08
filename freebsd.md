Accéder à un dossier partagé depuis Windows
===========================================

Impossible d\'utiliser mount~smbfs~ mais smbclient
//DESKTOP-G1M6J9S/test

Pour envoyer des fichiers : smbclient //DESKTOP-G1M6J9S/test -c \"prompt
off; mput \*\"

TODO: comment envoyer un dossier complet ??

On récupérer le nom du server (netbios) avec nbtscan IP

Scrub zfs
=========

Dans /etc/defaults/periodic, le faire tous les 35 jours avec:

    daily_scrub_zfs_enable=&quot;NO&quot;
    daily_scrub_zfs_pools=&quot;&quot;            # empty string selects all pools
    daily_scrub_zfs_default_threshold=&quot;35&quot;

Emacs nativecomp
================

Installer texinfo Editer le makefile de lang/gcc10: Ajouter \".jit\" :
LANGUAGES:= c,c++,objc,fortran,jit Ajouter --enable-host-shared à
CONFIGURE~ARGS~ Puis make install Copier à la main libgccjit.h sudo cp
work/gcc-10.2.0/gcc/jit/libgccjit.h *usr/local/include*

Compiler emacs git clone <git://git.savannah.gnu.org/emacs.git> -b
feature/native-comp cd emacs ./autogen.sh

CC=gcc10 ./configure --with-native-compilation --with-x-toolkit=lucid
make -j\$(nproc) make install

Enfin, éviter la mise à jour de GCC10 avec pkg lock gcc10

Mise à jour -CURRENT sur rasbperry pi 4
=======================================

From advice on discord \#embedded)
----------------------------------

The first time: i use git pull --ff-only in /usr/src then the ususl make
buildworld & friends To set up src, in /usr do git clone
<https://git/freebsd.org/src.git> cd /usr/src git checkout main

subsequently, cd /usr/src && git pull --ff-only Then make bulidword,
buildkernel as in
<https://docs.freebsd.org/en/books/handbook/cutting-edge/#makeworld>

See also:
<https://gist.github.com/grahamperrin/e7a266154793d0e039f9a7d52396f8d7#one-off-2021-03-10>

HOLD Trying to cross compile
----------------------------

### Procedure

According to
<https://forums.freebsd.org/threads/trying-to-perform-a-cross-compile-to-upgrade-in-a-raspberry-4-b.77430/>

Pour accéder au pi en local, sshfs: sudo pkg install fusefs-sshfs
kldload fusefs doas -u root sysctl vfs.usermount=1 Pour plus tard :

-   mettre fuse~load~=\"YES\" dans /boot/loader.conf
-   mettre vfs.usermount=1 dans /etc/sysctl.conf

sshfs -o idmap=user -p 666 alex\@192.168.1.78: /raspberry

Récupérer src cd \~/softwares/raspberry-update/ git clone -o freebsd -b
main <https://git.freebsd.org/src.git> src

Preparation mkdir obj setenv MAKEOBJDIRPREFIX
\~/softwares/raspberry-update/obj/

Build world: cd src/ time make -j 4 TARGET=arm64 TARGET~ARCH~=aarch64
buildworld =\> 2h30 time make -j 4 TARGET=arm64 TARGET~ARCH~=aarch64
buildkernel KERNCONF=GENERIC-NODEBUG =\> 10min (!)

On a besoin de lancer les commandes comme root donc on authorise le root
login dans /etc/ssh/sshd~config~ et on re-mount sudo umount *raspberry
sshfs -o idmap=user -p 666 root\@192.168.1.78:* *raspberry Le \"*\" est
important, sinon on va installer dans /root ... On fait une sauvegarde
du kernel avant !!! ssh raspberry sudo cp /book/kernel /book/kernel.save

Go: make TARGET~ARCH~=aarch64 DESTDIR=/raspberry/
KERNCONF=GENERIC-NODEBUG installkernel

On redémarre et On croise les doigts

Avant:

    uname -a
    FreeBSD generic 14.0-CURRENT FreeBSD 14.0-CURRENT #0 main-n245255-483c6da3a20: Thu Mar  4 08:04:51 UTC 2021     root@releng1.nyi.freebsd.org:/usr/obj/usr/src/arm64.aarch64/sys/GENERIC  arm64

### KILL Latest 1663120ae452fe3783c74ce40522caf0e2327608 fails

### KILL Version actuelle sans debug 483c6da3a20

(avec les optimisations de
<span class="spurious-link" target="Utiliser la config de f451">*Utiliser
la config de f451*</span>

``` {.shell}
git clone -o freebsd -b main https://git.freebsd.org/src.git src
git checkout -b 483c6da3a20
mkdir obj
setenv MAKEOBJDIRPREFIX ~/softwares/raspberry-update/obj/
time make -j 4 TARGET=arm64 TARGET_ARCH=aarch64 buildkernel KERNCONF=GENERIC-NODEBUG
```

=\> 10min

``` {.shell}
sshfs -o idmap=user -p 666 root@192.168.1.78:/ /raspberry
```

On backup /book/kernel avant puis

``` {.shell}
make TARGET_ARCH=aarch64 DESTDIR=/raspberry/ KERNCONF=GENERIC-NODEBUG  installkernel
```

### <span class="todo TODO">TODO</span> Causes d\'echec :

-   Impossible de faire buildkernel sans buildworld ?

<span class="todo TODO">TODO</span> Faire son propre serveur freebsd-update ??server
------------------------------------------------------------------------------------

Voir si c\'est possible
<https://docs.freebsd.org/en/articles/freebsd-update-server/>

<span class="todo TODO">TODO</span> Compilation sur le pi
---------------------------------------------------------

Selon les conseils de f451 sur discord (4-5 h de compilation au total)

=== <span class="todo TODO">TODO</span> Utiliser un disque en usb3
plutôt que le cache =\> y mettre /usr/src et /usr/obj ===

### Workflow de f451

make -j10 cleanworld && make -j10 cleandir && make -j10 clean && make
-j6 buildworld && make -j6 buildkernel && make installkernel && make
installworld && mergemaster -Ui (merge all the changes) then make
check-old yes \| make delete-old yes \| make delete-old-libs reboot

### <span class="done DONE">DONE</span> Utiliser la config de f451

1.  <span class="done DONE">DONE</span> /etc/src.conf
    <https://user.fm/files/v2-68d74fd0b799cc134536c72c766466bd/etc.src.conf.txt>

        KERNCONF=[redacted]
        WITHOUT_DEBUG_FILES=
        WITH_CCACHE_BUILD=
        WITH_OPENSSL_KTLS=

        WITHOUT_APM=
        WITHOUT_ASSERT_DEBUG=
        WITHOUT_BLUETOOTH=
        WITHOUT_CUSE=
        WITHOUT_DICT=
        WITHOUT_DMAGENT=
        WITHOUT_FLOPPY=
        WITHOUT_FREEBSD_UPDATE=
        WITHOUT_HAST=
        WITHOUT_IPFILTER=
        WITHOUT_IPFW=
        WITHOUT_ISCSI=
        WITHOUT_KERNEL_SYMBOLS=
        WITHOUT_LLVM_TARGET_ALL=
        WITH_LLVM_TARGET_AARCH64=
        WITH_LLVM_TARGET_ARM=
        WITHOUT_LPR=
        WITHOUT_NDIS=
        WITHOUT_NETGRAPH=
        WITHOUT_NIS=
        WITHOUT_OFED=
        WITHOUT_PORTSNAP=
        WITHOUT_PPP=
        WITHOUT_RADIUS_SUPPORT=
        WITH_RATELIMIT=
        WITHOUT_RBOOTD=
        WITHOUT_ROUTED=
        WITH_SORT_THREADS=
        WITH_SVN=
        WITHOUT_TALK=
        WITHOUT_TESTS=
        WITHOUT_TFTP=
        WITHOUT_UNBOUND=
        #
        CFLAGS.clang+= -mcpu=cortex-a72
        CXXFLAGS.clang+= -mcpu=cortex-a72
        CPPFLAGS.clang+= -mcpu=cortex-a72
        ACFLAGS.arm64cpuid.S+= -mcpu=cortex-a72+crypto
        ACFLAGS.aesv8-armx.S+= -mcpu=cortex-a72+crypto
        ACFLAGS.ghashv8-armx.S+= -mcpu=cortex-a72+crypto

2.  KILL /boot/msdos/config.txt (si ventilation !!)
    <https://user.fm/files/v2-a5fdc9db09f97646da0a29e86e7615c2/config.txt>

        arm_control=0x200
        dtparam=audio=on,i2c_arm=on,spi=on
        dtoverlay=mmc
        dtoverlay=pwm
        dtoverlay=disable-bt
        device_tree_address=0x4000
        kernel=u-boot.bin
        over_voltage=6
        arm_freq=2000
        sdram_freq_min=3200

3.  <span class="done DONE">DONE</span> /etc/rc.conf
    powerd~enable~=\"YES\" powerd~flags~=\"-r 1\"

4.  <span class="done DONE">DONE</span> /etc/make.conf
        MAKE_JOBS_NUMBER=6
        WITH_CCACHE_BUILD=YES
        CCACHE_DIR=/var/cache/ccache
        WITH_MANCOMPRESS=YES
        OPTIONS_UNSET+=DEBUG
        OPTIONS_SET+=OPTIMIZED_CFLAGS
        OPTIONS_SET+=DOCS EXAMPLES MANPAGES

5.  <span class="done DONE">DONE</span> Changer la taille de /tmp
    En tant que root !! unmount /tmp vi /etc/fstab Mettre 500M au lieu
    de 50M

### <span class="todo TODO">TODO</span> Vérifier refroidessement

### <span class="done DONE">DONE</span> Installer ccache-static

### <span class="todo TODO">TODO</span> MAJ

Attention, ne pas utiliser -j6 sinon on s\'expose à des erreurs \"out of
swap space\". La bonne commande est:

    make -j3 buildworld &amp;&amp; make -j3 buildkernel KERNCONF=GENERIC-NODEBUG

Temps de compilation

-   buildworld : 10h (2h30 avec 6 threads puis échec + 7.6h)
-   buildkernel : 1H

Devrait diminuer pour les prochaines compilations car le kernel sera
NODEBUG

Echec avec just installkernel

On récupéère les dernières sources et on recommence

    cd /usr/src &amp;&amp; git pull --ff-only &amp;&amp; make -j10 cleanworld &amp;&amp; make -j10 cleandir &amp;&amp; make -j10 clean
    git checkout main
     make -j4 buildkernel KERNCONF=GENERIC-NODEBUG

Steam
=====

[Instructions](https://euroquis.nl//freebsd/2021/04/06/steam-freebsd)

    doas pkg install linux-steam-utils
    doas pkg install linux-nvidia-libs

Create a steam user, Add it to video and operator group

    doas adduser
    sysrc linux_enable=yes

Dans /etc/fstab

    linprocfs /compat/linux/proc     linprocfs rw 0 0
    linsysfs  /compat/linux/sys      linsysfs  rw 0 0
    tmpfs     /compat/linux/dev/shm  tmpfs     rw 0 0
    fdescfs   /dev/fd                fdescfs   rw 0 0

    doas mount -a
    chown steam /compat/linux/dev/shm

[Liste des jeux
compatibles](https://github.com/shkhln/linuxulator-steam-utils/wiki/Compatibility)

Backup
======

Rsync pour google drive, mega et hubic :
----------------------------------------

En résumé :

1.  on récupére le pi localement avec rsync (impossible avec duplicity):
    rtorrent + config
2.  on encrypte les backup du pi et celles de la config freebsd du
    desktop avec duplicity
3.  on fait un symlink pour les upload sur le cloud
4.  on backup le tout sur google, hubic et mega avec rsync

Code:

    #!/usr/local/bin/fish
    # 3 steps procedure :
    #   1. Backup from the pi using rsync
    #   2. Encrypt cofig files (rasperry + local) using duplicity
    #   2. Backup to the cloud using rsync
    #
    # Backup data either in clear or encrypted
    # - google -&gt; to google drive (clear)
    # - hubic -&gt; to Hubic and Mega(clear)
    # - local config files -&gt; google and hubic (encrypted)
    # - raspberry config files -&gt; google and hubic (encrypted)
    # - local rtorrent -&gt; google and hubic (encrypted)
    # - raspberry rtorrent -&gt; google and hubic (encrypted)
    set root &quot;/home/alex/backups&quot;

    # Duplicity needs a passphrase
    set -x PASSPHRASE (cat /home/alex/pass.txt)

    # #------- Raspberry: backup -----
    # Save books
    # rclone sync pi:/media/books/ /media/books/
    # Save torrents and config files(encrypted)
    # Warning : --include implyies everything is excluded so we need /** at the end
    # Don't forget the / in the folder too..
    set piLocal raspberry-local/
    rclone sync --include &quot;/home/alex/Downloads/torrents/**&quot; \
        --include &quot;/home/alex/Downloads/session/**&quot; \
        --include &quot;/usr/local/etc/**&quot;  \
        --include &quot;/etc/**&quot;  \
        --include &quot;/boot/loader.conf&quot;  pi:/ $piLocal
    # Encrypt it
    duplicity $piLocal file:///home/alex/backups/raspberry

    #------- Local backup (encrypted) ----------------
    # 1. Create encrypted local version
    #
    # This requires setenv PASSPHRASE in doas.conf !!
    # Due to permission, we need separate folder for doas command
    doas duplicity --include /usr/local/etc/ --include /etc/ \
        --include /boot/loader.conf --exclude '**' \
        / file:///home/alex/backups/desktop/root

    duplicity --include /home/alex/Downloads/torrents \
        --include /home/alex/Downloads/session \
        --exclude '**'  \
        /home/alex/Downloads file:///home/alex/backups/desktop/rtorrent

    #------------ Backup all encnrypted and non encrypted

    # Backup is then made with rsync because there is a symlink
    # desktop -&gt; google/desktop
    # desktop -&gt; hubic /desktop
    #--- All
    # Google drive and mega can be managed with rclone
    rclone -L sync --exclude 'Coopétition/' --drive-import-formats .xlsx $root/google/  google:
    rclone -L sync $root/google backblaze:unixStorage
    rclone -L sync $root/hubic hubic:
    rclone -L sync $root/hubic mega:

    #--- Passphrase
    /usr/local/bin/pass git push

Maintenir un port
=================

-   Tester avec poudrière
-   portlint Makefile
-   Faire un PR sur bugzilla
    -   titre: x11/kitty: Update to XX
    -   remplir URL du changelog
    -   cocher "maintainer approval"

Haskell
-------

Incrémenter la version dans le Makefile Générer la liste des dépendences
avec: make makesum make cabal-extract cabal-extract-deps make
make-use-cabal-revs Mettre à jour le Makefile et lancer les tests avec
poudrière

Python
------

Pour tester avec plusieurs versions de python:

echo 'DEFAULT\_VERSIONS+= python=3.6' \>
/usr/local/etc/poudriere.d/python36-make.conf poudriere testport -z
python36 -j 130Ramd64 -o textproc/py-sphinxext-opengraph

Par exemple : 3.6, 3.7, 3.8, 3.9. 3.10

KILL Freebsd 2020
-----------------

### Nvidia 950 : 

/etc/rc.conf: dbus~enable~=\"YES\" linux~enable~=\"YES\" \# for nvidia
kld~list~=\"nvidia-modeset\" \#nvidia does not work

Et faire un xorg.conf dans
/usr/local/etc/X11/xorg.conf.d/driver-nvidia.conf Section \"Device\"
Identifier \"NVIDIA card\" Driver \"nvidia\" EndSection Source:
<https://forums.freebsd.org/threads/howto-setup-xorg-with-nvidias-driver.52311/>

### Bepo: télécharger ici

<https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=160227>

Attention, ne pas le mettre dans *usr/share/syscons/keymaps* mais
*usr/share/vt/keymaps* ! Puis dans /etc/rc.conf
keymap=\"fr-dvorak-bepo\"

### <span class="todo TODO">TODO</span> Non résolu : grub avec Zfs on root

### Emacs as daemon

On peut utiliser rc.d (voir la discussion ici
<https://forums.freebsd.org/threads/running-emacs-as-a-daemon.78392/#post-489850>)
mais cela ralentit le démarrage. Le plus simple est d\'utiliser crontab
avec \@reboot :

\@reboot /usr/local/bin/emacs --daemon

### Nzbget

Fichiers sont dans /usr/local/share/nzbget Éditer le fichier
/usr/local/etc/nzbget.conf ( NB root qui s\'en occupe pour partager les
fichiers avec Linux) Dans /etc/rc.conf: nzbget~enable~=\"YES

### Micro USB blue snowball

Volume : mixtui + F6 pour choisir le micro + F4 pour volume Discord : ok
sous firefox

Possible sosu chrome mais avec sndio

1.  Chercher le numéro avec cat /dev/sndstat

Installed devices: pcm0: \<NVIDIA (0x0072) (HDMI/DP 8ch)\> (play) pcm1:
\<NVIDIA (0x0072) (HDMI/DP 8ch)\> (play) pcm2: \<NVIDIA (0x0072)
(HDMI/DP 8ch)\> (play) pcm3: \<NVIDIA (0x0072) (HDMI/DP 8ch)\> (play)
pcm4: \<Realtek ALC887 (Rear Analog 7.1/2.0)\> (play/rec) default pcm5:
\<Realtek ALC887 (Front Analog)\> (play/rec) pcm6: \<Realtek ALC887
(Rear Digital)\> (play) pcm7: \<Realtek ALC887 (Onboard Digital)\>
(play) pcm8: \<USB audio\> (rec) No devices installed from userspace

1.  sndiod -f rsnd/8
2.  Test micro avec aucat -o test.wav (+ control-c) mplayer test.wav

Attention, semble faire du statique avec la version firefox ... Donc non
compatible. Si permanent : sndiod~enable~ = \"YES\" sndiod~flags~ = \"-f
rsnd/1 -F rsnd/3\"

/etc/rc.conf

### Mpd

<https://forums.freebsd.org/threads/howto-desktop-musicpd-mpd-configuration.54600/>
Ajouter au crontab : *usr/local/bin/musicpd \~*.mpd/musicpd.conf

### Printer HL110

Télécharger driver cups et lpd au format .deb
<https://support.brother.com/g/b/downloadlist.aspx?c=us_ot&lang=en&prod=hl1110_us_eu_as&os=128>

Dans cupswrapper et lpr : tar xvzf data.tar.gz -C / Install **psutils**
and **linux~base~-c7**: Puis (root) on lance les commande dans postinst
(modifiée)

``` {.shell}
 sed -i.bak 's/chown lp/chown root/' /opt/brother/Printers/HL1110/inf/setupPrintcap
 sed -i.bak 's/chgrp lp/chgrp daemon/' /opt/brother/Printers/HL1110/inf/setupPrintcap
/opt/brother/Printers/HL1110/inf/setupPrintcap HL1110 -i USB
/opt/brother/Printers/HL1110/inf/braddprinter -i HL1110
 echo \[psconvert2\]   >>/opt/brother/Printers/HL1110/inf/brHL1110func
 echo pstops=/usr/local/bin/pstops  >> /opt/brother/Printers/HL1110/inf/brHL1110func
 echo \[psconvert2\]   >>/opt/brother/Printers/HL1110/inf/brHL1110func
 ln -s /opt/brother/Printers/HL1110/inf/brHL1110rc       /etc/opt/brother/Printers/HL1110/inf/brHL1110rc

# No need for that
#  echo "#! /bin/sh"  > /usr/local/bin/brprintconflsr3_HL1110
# echo "/opt/brother/Printers/HL1110/lpd/brprintconflsr3 -P HL1110" '$''*'           >>/usr/local/bin/brprintconflsr3_HL1110
#  chmod 755 /usr/local/bin/brprintconflsr3_HL1110
```

Because it complaints that
/usr/local/libexec/cups/filter/brother~ldwrapperHL1110~ does not exist :

    ln -s /opt/brother/Printers/HL1110/cupswrapper/brother_lpdwrapper_HL1110  /usr/local/libexec/cups/filter
