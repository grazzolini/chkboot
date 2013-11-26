Software for teh article "Boot-Sicherung" in c't
magazine 3/12, S. 146

Autor: Juergen Schmidt, ju at heisec.de
Lizenz: GPLv2 oder später

Content:
======
                 SHA1-Hash
chkboot.sh      4a8a81306074f94cd12e8fe75f019ba3a70cc422  
chkboot_user.sh 82c826cd2c5310cd6b90ee278ee3d0f69d7dcd24  


Description:
=========
chkboot.sh:  checks all files under /boot for changes
of sha1 hash, inode and occupied blocks on the hard
drive drive. Also checks MBR. Info files are written to
/var/chkboot, events to syslog. Needs root 

chkboot_user.sh: checks for the file
/var/chkboot/bootfiles-diff and displays it. Needs zenity


Installation:
=============

copy both scripts to /usr/local/bin kopieren; perhaps
you need to make them executable: "chmod a+x /usr/local/bin/chkboot*" 

chkboot.sh needs to be executed at system startup for
example by adding the following to /etc/rc.local

/usr/local/bin/chkboot.sh &

chkboot_user.sh need to be excuted after login. Add it
to the autostarts via the menu.
