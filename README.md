Introduction
------------

chkboot is a set of scripts that are meant to be run on a system with an
encrypted disk drive. Due to the nature of disk encryption, in order to get
the operating system to boot, there needs to be a portion of it which remains
un-encrypted. These scripts check that those files have not changed between
reboots. Since the scripts and the data they generate are stored on the
encrypted part of the disk, any attempts to modify the boot partition between
reboots will be detected.


Description
-----------

`chkboot`: When run as root, this generates sha256sum hashes of each boot file
and the MBR of the boot partition if it exists, then compares the values of
these hashes against previously generated hashes if they exist, and any files
that don't match get added to a list. A timestamped log of all files that have
had changes made to them is kept, but the short term list meant to alert the
user is erased the next time `chkboot` is run.

`chkboot-check`: This file can be run by anyone who can view /var/lib/chkboot,
and will display a warning a the list of changed files if any were detected last
time chkboot was run.

`chkboot.conf`: Contans settings for your configuration, including which
alert types will be used. Alert types are currently on shell login via
'/etc/profile.d' and in the vterm header by modifying '/etc/issue'

`INITCPIO SUPPORT`: If your system uses initcpio, add 'chkboot' to the end of
your modules array to have chkboot run automatically when you upgrade linux.

`SYSTEMD SUPPORT`: If your system uses systemd, you should enable the chkboot
service to have your boot partitioned checked every time your system starts.

Package building
----------------

**Note:** This should work properly on Debian 8 (Jessie) and Debian 9 (Stretch).

First install the packages for building:

    ~# apt-get install git devscripts

Then clone this repository:

    ~$ git clone https://github.com/philippmeisberger/chkboot.git

Build the package:

    ~$ cd ./chkboot/
    ~$ dpkg-buildpackage -uc -us

Installation
------------

Install package:

    ~# dpkg -i ../chkboot*.deb

Install zenity for graphical notifications about boot changes:

     ~# apt-get install zenity

Install missing dependencies:

    ~# apt-get -f install

__IMPORTANT__: Create an autostart entry that calls chkboot-desktopalert script to be notified about changes after login. For XFCE just copy the `/usr/share/chkboot/chkboot.desktop` to `$HOME/.config/xfce/autostart/` directory. Every time this user logs in and boot changes are detected a message will be shown. *NOTE:* `zenity` or `xmessage` must be installed for this.

Manual Installation
-------------------

### Everything should be installed as shown below

```
install -D -m644 chkboot/chkboot.conf /etc/default/chkboot.conf
install -D -m755 chkboot/chkboot /usr/bin/chkboot
install -D -m755 chkboot/chkboot-check /usr/bin/chkboot-check
install -D -m755 chkboot/chkboot-profilealert.sh /etc/profile.d/chkboot-profilealert.sh
install -D -m755 chkboot-desktopalert /usr/bin/chkboot-desktopalert
```

To make `chkboot` run on startup on BSD-style init-based systems (e.g. Debian,
Ubuntu), add the following line to `/etc/rc.local`:

```
/usr/bin/chkboot &
```

### REQUIRES INITCPIO:

Add `chkboot` to the end of the 'HOOKS' array in `/etc/mkinitcpio.conf`

```
install -D -m644 chkboot/chkboot-initcpio /usr/lib/initcpio/install/chkboot
```

### REQUIRES SYSTEMD

Run `systemctl --system daemon-reload` and then `systemctl enable chkboot`

### OPTIONAL:

`chkboot-bootcheck` can be installed elsewhere and added to the startup sequence
with another system:

```
install -D -m644 chkboot/debian/chkboot.service /usr/lib/systemd/system/chkboot.service
install -D -m755 chkboot/chkboot-bootcheck /usr/lib/systemd/scripts/chkboot-bootcheck
```

``chkboot-desktopalert`` notifies the desktop user about the change and can be
included as startup script in the desktop environment or window manager.

Credits
-------

Maintainer: Grazzolini (https://github.com/grazzolini)

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

Contributors:
sercxanto (https://github.com/sercxanto/)
Philipp Meisberger (https://github.com/philippmeisberger/chkboot)
