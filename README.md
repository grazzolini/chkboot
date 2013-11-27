chkboot is a set of scripts that are meant to be run on a system with an
encrypted disk drive. Due to the nature of disk encryption, in order to get
the operating system to boot, there needs to be a portion of it which remains
un-encrypted. These scripts check that those files have not changed between
reboots. Since the scripts and the data they generate are stored on the
encrypted part of the disk, any attempts to modify the boot partition between
reboots will be detected.


Description:
------------

chkboot.sh: checks all files under /boot for changes of sha1 hash, inode
and occupied blocks on the hard drive drive. Also checks MBR. Configuration
file is /etc/chkboot.conf. Info files are written to /var/chkboot, events to
syslog. Needs root.

chkboot_user.sh: checks for the file /var/chkboot/bootfiles-diff and displays
it. Needs zenity.


Installation:
-------------

Copy both scripts to /usr/local/bin and make them executable:
`chmod a+x /usr/local/bin/chkboot*`

`chkboot.sh` needs to be executed at system startup for
example by adding the following to /etc/rc.local

`/usr/local/bin/chkboot.sh &`

`chkboot_user.sh` need to be excuted after login. Add it
to the autostarts via the menu.


Credits
-------

chkboot originally appeared in an article titled "Boot-Sicherung" in [c't
magazin's March 2012 issue] [1]. The original author is Juergen Schmidt, ju at
heisec.de. The original source code can be found either at the first commit of
this repository, or at the [original URL] [2].

[1]: http://www.heise.de/ct/inhalt/2012/03/146/
[2]: ftp://ftp.heise.de/pub/ct/listings/1203-146.zip
