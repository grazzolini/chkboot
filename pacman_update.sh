#!/bin/bash
#
# Courtesy of https://wiki.archlinux.org/index.php/LUKS#Securing_the_unencrypted_boot_partition

echo "Pacman update [1] Quickcheck before updating" & 
/usr/local/bin/chkboot_user.sh	
sudo /usr/local/bin/chkboot.sh
sync							# sync disks with any results 
/usr/local/bin/chkboot_user.sh	
echo "Pacman update [2] Syncing repos for pacman" 
sudo pacman -Syu
sudo /usr/local/bin/chkboot.sh
sync	
/usr/local/bin/chkboot_user.sh	
echo "Pacman update [3] All done, let's roll on ..."
