+++
title = "Streaming media with FreeBSD"
date = 2021-03-01
+++

Here, I\'ll explain how to configure FreeBSD to share media content over
the network using NFS, and how to configure Kodi to access it from your
TV.

## Server

First define which folders will be accessible to whom. In
`/etc/exports`{.verbatim}, I share /media to everyone on my network
(192.168.1.\*\*)

```bash
/media  -alldirs -maproot=root -network=192.168.1.0/24
```

Note the syntax is different from Linux !

Then simply activate NFS by adding in `/etc/rc.conf`{.verbatim} :

```bash
# NFS for Kodi
# Order is important : rpcbind first, then nfs and mountd
rpcbind_enable="YES"
nfs_server_enable="YES"
weak_mountd_authentication="yes"
mountd_enable="YES"
nfs_client_enable="YES"
```

NB: The Kodi wiki mentions lockd and statd but it is unnecessary.

Reboot or start the service (start rpcbind first, otherwise it will not
work !)

```bash
$ service rpcbind start
$ service nfsd start
```

Check the export is working :

```bash
$ showmount -e
Exports list on localhost:
/media                             192.168.1.0
```

## TV

We will use the Kodi application. Add a new source by choosing NFS and
entering by hand : (the folder is not found automatically)

```bash
nfs://192.168.1.XXX/media
```

where XXX is the end of the server IP. Profit !
