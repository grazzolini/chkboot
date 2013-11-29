Introduction:
-------------
chkboot is a set of scripts that are meant to be run on a system with an
encrypted disk drive. Due to the nature of disk encryption, in order to get
the operating system to boot, there needs to be a portion of it which remains
un-encrypted. These scripts check that those files have not changed between
reboots. Since the scripts and the data they generate are stored on the
encrypted part of the disk, any attempts to modify the boot partition between
reboots will be detected.

Description:
------------
`chkboot`: When run as root, this generates sha256sum hashes of each boot file
and the MBR of the boot partition if it exists, then compares the values of
these hashes against previously generated hashes if they exist, and any files
that don't match get added to a list. A timestamped log of all files that have
had changes made to them is kept, but the short term list meant to alert the
user is erased the next time `chkbot` is run.

`chkboot-diffcheck.sh`: This file is installed to /etc/profile.d/ so it will
run each time you login to a shell. When the file showing a list of changes made
to the boot partition exists, each new shell the user logs into will alert them
and list the changed files. When the user has reviewed the changed files, they
can run `chkbot` to remove the file showing changes assuming no additional ones
are detected, and the notice will no longer appear.

`chkboot-pacman-update`: This script uses a combination of the two scripts above
to savely update the system by first checking for previously unresolved changes,
then checks to make sure there aren't any new changes before then allowing the
system to update. If there then any changes following the updates, `chkboot`
runs one more time to autoresolve the issue, as changes caused by package
management are expected and are not an issue.
*Note that without modification, this script only works with Archlinux

Installation:
-------------
Copy `chkboot` and `chkboot-pacman-update` to a location in $PATH and set
their permissions to 755:
    ]$ install -d -m755 chkboot /usr/bin/chkboot
    ]$ install -d -m755 chkboot-pacman-update /usr/bin/chkboot-pacman-update

Copy `chkboot-diffcheck.sh` to /etc/profile.d/ and set its permissions to 755:
    ]$ install -d -m755 chkboot-diffcheck.sh /etc/profile.d/chkboot-diffcheck.sh

Copy `chkboot.conf` to /etc/default/ and set its permissions to 644:
    ]$ install -d -m644 chkboot.conf /etc/default/chkboot.conf

Copy `chkboot.service` to /usr/lib/systemd/system/ and set its permissions to 644:
    ]$ install -d -m644 chkboot.service /usr/lib/systemd/system/chkboot.service
    *Note that this should only be used in combination with systemd

Credits
-------
Author: Ju (ju at heisec dot de)

chkboot originally appeared in an article titled "Boot-Sicherung" in [c't
magazin's March 2012 issue] [1]. The original author is Juergen Schmidt, ju at
heisec.de. The original source code can be found either at the first commit of
this repository, or at the [original URL] [2].

[1]: http://www.heise.de/ct/inhalt/2012/03/146/
[2]: http://ftp.heise.de/pub/ct/listings/1203-146.zip

Additional authors:
Inhies (https://github.com/inhies/)
Prurigro (https://github.com/prurigro/)
