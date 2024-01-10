```{=org}
#+filetags: cs freebsd
```
# Bepo

Récupérer le fichier
<http://download.tuxfamily.org/dvorak/devel/fr-dvorak-bepo-kbdmap-1.0rc2.tgz>

``` example
mv /home/alex/Downloads/fr-dvorak-bepo-kbdmap-1.0rc2/fr-dvorak-bepo.kbd //usr/share/vt/keymaps/fr.dvorak.bepo
```

# rc.conf

/etc/rc.conf

``` example
hostname="ecchi"
keymap="fr.dvorak.bepo" # Uses vt so in /usr/share/vt/keymaps
ifconfig_re0="DHCP"
# Static IP to be connectable in MAM
#ifconfig_re0="inet 192.168.1.90 netmask 255.255.255.0"
#defaultrouter="192.168.1.254" # found by the first list on netstat -r
sshd_enable="YES"
ntpd_enable="YES"
powerd_enable="YES"
# Dbus
sysrc_dbus_enable="YES"
hald_enable="YES" # For kobo
# Set dumpdev to "AUTO" to enable crash dumps, "NO" to disable
dumpdev="AUTO"
zfs_enable="YES"
kld_list="nvidia-modeset"
# Cups
cupsd_enable="YES"
devfs_system_ruleset="system"
musicpd_enable="YES"
# Usenet
nzbget_enable="YES"
nzbhydra2_enable="YES"
# NFS for Kodi
# Order is important : rpcbind first, then nfs and mountd
rpcbind_enable="YES"
nfs_server_enable="YES"
weak_mountd_authentication="yes"
mountd_enable="YES"
nfs_client_enable="YES"
dbus_enable="YES"
dbus_enable="YES"
fuse_load="YES"
```

# /etc/sysctl.conf

``` example
# Allow users to mount
vfs.usermount=1
```

# /boot/loader.conf

kern.geom.label.gptid.enable=\"0\" opensolaris~load~`"YES"
openzfs_{load}`{.verbatim}\"YES\" vboxdrv~load~=\"YES\"

hw.usb.no~bootwait~=1

# Brother printer

/etc/devfs.rules :

``` example
[system=10]
add path 'unlpt*' mode 0660 group cups
add path 'ulpt*' mode 0660 group cups
add path 'lpt*' mode 0660 group cups
add path 'usb/1.3.0' mode 0660 group cups
```

Installer brlaser et cups-filter

# ZFS notes

OpenZFS est utilisation avec 12.2 mais ne pas mettre à jour le root
avant la version 13 ! Par défaut, les autres pool ne sont pas importées
donc il faut rajouter zfs import -a dans /etc/rc.d/zfs.

# /etc/fstab

``` example
# Device        Mountpoint               FStype Options     Dump    Pass#
/dev/ada0p2     none                 swap   sw      0       0
# Linux
/dev/ada3p2         /linux-root          ext2fs  rw      0       0
/dev/ada3p4         /linux               ext2fs  rw      0       0
# For OpenJDK
fdesc               /dev/fd              fdescfs rw      0       0
proc                /proc                procfs  rw      0       0
# Linux emulation
linproc             /compat/linux/proc   linprocfs  rw, late      0       0
linsys              /compat/linux/sys    linsysfs rw,late     0       0
tmpfs               /compat/linux/dev/shm  tmpfs   rw,mode=1777    0       0
# Ubuntu jail
devfs           /compat/ubuntu/dev      devfs           rw,late                      0       0
tmpfs           /compat/ubuntu/dev/shm  tmpfs           rw,late,size=1g,mode=1777    0       0
fdescfs         /compat/ubuntu/dev/fd   fdescfs         rw,late,linrdlnk             0       0
linprocfs       /compat/ubuntu/proc     linprocfs       rw,late                      0       0
linsysfs        /compat/ubuntu/sys      linsysfs        rw,late                      0       0
/tmp            /compat/ubuntu/tmp      nullfs          rw,late                      0       0
/home           /compat/ubuntu/home     nullfs          rw,late                      0       0
```

# xorg (nvidia)

/usr/local/etc/X11/xorg.conf.d/driver-nvidia.conf

``` example
Section "Device"
    Identifier "NVIDIA card"
    Driver "nvidia"
EndSection
```

# nzbget

Cf backups nzbget.conf

# nzbhydra

Copying indexers must be done by hand... Cf backups
/usr/local/nzbhydra2/nzbhydra.yml

# crontab

``` example
MAILTO=""
*/5 *   *   *   *   /bin/sh /usr/home/alex/scripts/mbsync_notmuch.sh
0   */3 *   *   *   /usr/local/bin/fish /usr/home/alex/backups/backup.fish
0 * * * * DISPLAY=:0 $HOME/projects/simple-dwall/simple-dwall.fish
@reboot /usr/local/bin/tmux new-session -d -s rtorrent '/usr/local/bin/rtorrent'
@reboot /usr/local/bin/emacs --daemon
```

# backup

``` example
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

# Duplicity needs a passphrase. Use pass &quot;backup/duplicity&quot;
set -x PASSPHRASE (cat /home/alex/.pass.txt)

# #------- Raspberry: backup -----
# Save books
rclone sync pi:/media/books/ /media/books/
# Save torrents and config files(encrypted)
# Warning : --include implyies everything is excluded so we need /** at the end
# Don't forget the / in the folder too..
set tmp ~/backups/raspberry-tmp/
rclone sync --include &quot;/home/alex/Downloads/torrents/**&quot; \
    --include &quot;/home/alex/Downloads/session/**&quot; \
    --include &quot;/usr/local/etc/**&quot;  \
    --include &quot;/etc/**&quot;  \
    --include &quot;/boot/loader.conf&quot;  pi:/ $tmp
# Encrypt it
duplicity $tmp file:///home/alex/backups/raspberry

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
```

# Sci-hub et DNS resolv.conf

## Sous linux

On edite directement /etc/resolv.conf

1.  nameserver 208.67.222.222 #nameserver 208.67.220.220

nameserver 8.8.8.8 nameserver 8.8.4.4

1.  nameserver 194.158.122.10 #nameserver 194.158.122.15

```{=html}
<!-- -->
```
1.  nameserver 192.168.1.254

## Freebsd

/etc/resolv.conf est réécrit par dhclient. On met les nouveau DNS dans
/etc/resolvconf.conf. Pour scihub :

``` example
name_servers=208.67.222.222
name_servers=208.67.220.220
```

Puis

``` example
resolvconf -u
```

# musicpd

Changer le chemin en /data/music dans /usr/local/etc/musicpd.conf Puis

``` example
mkdir /var/mpd/.mpd/playlists
touch /var/mpd/.mpd/database
chown -R mpd /var/mpd/
service musicpd onestart
```

# KILL Windows as guest

*Plante régulièrement =\> virtualbox plutôt* Guide
<https://github.com/churchers/vm-bhyve/wiki/Running-Windows>
<https://srobb.net/vm-bhyve.html>

``` example
sudo pkg install vm-bhyve
sudo pkg install bhyve-firmware
sudo zfs create zroot/windows
```

Ajouter à /etc/rc.conf
vm~enable~`"YES" vm_{dir}`{.verbatim}\"zfs:zroot/windows\"

sudo vm init sudo cp \'\'usr/local/share/examples/vm-bhyve/windows.conf
*zroot/windows*.templates\'\' sudo vm switch add public re0 sudo vm
create -t windows winguest

sudo pkg install tigervnc-viewer

sudo vm configure winguest

vm install myguest \~/Downloads/Win10~20H2v2Frenchx64~.iso vncviewer
localhost:5900

Appuyer sur une touche pour lancer l\'install

# Latest au lieu de quartely

/etc/pkg/FreeBSD.conf

``` example
# $FreeBSD$
#
# To disable this repository, instead of modifying or removing this file,
# create a /usr/local/etc/pkg/repos/FreeBSD.conf file:
#
#   mkdir -p /usr/local/etc/pkg/repos
#   echo &quot;FreeBSD: { enabled: no }&quot; &gt; /usr/local/etc/pkg/repos/FreeBSD.conf
#

FreeBSD: {
  url: &quot;pkg+http://pkg.FreeBSD.org/${ABI}/latest&quot;,
  mirror_type: &quot;srv&quot;,
  signature_type: &quot;fingerprints&quot;,
  fingerprints: &quot;/usr/share/keys/pkg&quot;,
  enabled: yes
```

}

# raspberry

loader.conf

``` example
# Configure USB OTG; see usb_template(4).
hw.usb.template=3
umodem_load=&quot;YES&quot;
# Multiple console (serial+efi gop) enabled.
boot_multicons=&quot;YES&quot;
boot_serial=&quot;YES&quot;
# Disable the beastie menu and color
beastie_disable=&quot;YES&quot;
loader_color=&quot;NO&quot;
```

/etc/rc.conf

``` example
hostname=&quot;generic&quot;
#ifconfig_DEFAULT=&quot;DHCP&quot;
# Static ip for MAM
ifconfig_genet0=&quot;inet 192.168.1.78 netmask 255.255.255.0&quot;
defaultrouter=&quot;192.168.1.254&quot;
sshd_enable=&quot;YES&quot;
sendmail_enable=&quot;NONE&quot;
sendmail_submit_enable=&quot;NO&quot;
sendmail_outbound_enable=&quot;NO&quot;
sendmail_msp_queue_enable=&quot;NO&quot;
growfs_enable=&quot;YES&quot;
ntpd_enable=&quot;YES&quot;
powerd_enable=&quot;YES&quot;
powerd_flags=&quot;-r 1&quot;
```

/etc/ssh/sshd~config~

``` example
Port 666
PermitRootLogin no
AuthorizedKeysFile  .ssh/authorized_keys
Subsystem   sftp    /usr/libexec/sftp-server
```

\~/.rtorrent.rc

``` example
# Global upload and download rate in KiB. &quot;0&quot; for unlimited.
download_rate = 3500
upload_rate = 1000

# Default directory to save the downloaded torrents.
#directory = /Data/Music

# Connectable on MAM
network.port_range.set = 49164-49164
# Default session directory. Make sure you don't run multiple instance
# of rtorrent using the same session directory. Perhaps using a
# relative path?
session =  ~/Downloads/session

## Watch a directory for new torrents, and stop those that have been
## deleted.
schedule = watch_directory_fantasy, 10, 10, &quot;load.start=~/Downloads/torrents/books/fantasy/*.torrent,d.directory.set=/media/books/fantasy&quot;
schedule = watch_directory_litterature, 10, 10, &quot;load.start=~/Downloads/torrents/books/litterature/*.torrent,d.directory.set=/media/books/litterature&quot;
schedule = watch_directory_medecine, 10, 10, &quot;load.start=~/Downloads/torrents/books/medecine/*.torrent,d.directory.set=/media/books/medecine&quot;
schedule = watch_directory_horror, 10, 10, &quot;load.start=~/Downloads/torrents/books/horror/*.torrent,d.directory.set=/media/books/horror&quot;
schedule = watch_directory_thriller, 10, 10, &quot;load.start=~/Downloads/torrents/books/thriller/*.torrent,d.directory.set=/media/books/thriller&quot;
schedule = watch_directory_history, 10, 10, &quot;load.start=~/Downloads/torrents/books/history/*.torrent,d.directory.set=/media/books/history&quot;
schedule = watch_directory_cs, 10, 10, &quot;load.start=~/Downloads/torrents/books/cs/*.torrent,d.directory.set=/media/books/cs&quot;
schedule = watch_directory_science, 10, 10, &quot;load.start=~/Downloads/torrents/books/science/*.torrent,d.directory.set=/media/books/science&quot;


schedule = untied_directory,5,5,stop_untied=

# Close torrents when diskspace is low.
schedule = low_diskspace,5,60,close_low_diskspace=100M

encoding.add = utf8

# Use 'tmux -d rtorrent -s rtorrent ' instead
# system.daemon.set = true
```

\~/.config/fish/fish.config

``` example
# Vim binding
fish_vi_key_bindings

# Bepo bindings for vim
for key in h l k j
    bind -e --user $key
    bind -e --user -M visual $key
end

bind --user c backward-char
bind --user r forward-char
bind --user s up-line
bind --user t down-line

bind --user -M visual c backward-char
bind --user -M visual r forward-char
bind --user -M visual s up-line
bind --user -M visual t down-line

# Alt-s uses doas instead of sudo
for mode in insert default visual
    bind --user -s -M $mode \es __fish_prepend_doas
end

alias tma=&quot;tmux a -d -t&quot;
alias tms=&quot;tmux new-session -s&quot;
alias ttorr=&quot;tmux a -d -t rtorrernt&quot;

# Allow tramp connection from emacs
if test &quot;$TERM&quot; = &quot;dumb&quot;
    exec sh
end
```

# poudrier config

/usr/local/etc/poudriere.conf

``` example
ZPOOL=zroot
ZROOTFS=/poudriere
FREEBSD_HOST=ftp://ftp.freebsd.org
RESOLV_CONF=/etc/resolv.conf
BASEFS=/usr/local/poudriere
USE_PORTLINT=no
USE_TMPFS=yes
DISTFILES_CACHE=/usr/ports/distfiles
SVN_HOST=svn.FreeBSD.org
CCACHE_DIR=/usr/obj/ccache
# By default : 1 build per CPU but 1 thread per build.
# for large ports, this is not enough
ALLOW_MAKE_JOBS=yes
```
