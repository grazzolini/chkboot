# Apt Hooks for chkboot

Hooks required to clear any modification made to /boot by apt.

## How it works?

On first install, chkboot Debian package take the following actions:
  - register a trigger on /boot and initramfs update (stored in
    `/var/lib/dpkg/triggers/`)
  - install a function to create a flag file on trigger activation in
    `/var/lib/dpkg/info/chkboot.postinst`
  - install an apt hook in `/etc/apt/apt.conf.d/05chkboot` to run the update
    script
  - install an update script in `/usr/lib/chkboot/chkboot-update`

Then, on trigger activation:
  - flag file is created in `/var/lib/chkboot/needs-update`
  - apt hook calls the update script
  - update script clear modifications

Note: The hook and update script are actually called at every apt invocation.
Clearing the modification is only done if the flag file exists, from when the
trigger is activated.

## Files

The update script and the apt hook are installed alongside chkboot. The trigger
and the function to create the flag files are located in the Debian packaging
files.
