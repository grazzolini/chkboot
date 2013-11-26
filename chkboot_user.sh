#!/bin/bash

# small script to check if files under /boot changed
# Author: ju (ju at heisec dot de)
# 
# License: GPLv2 or later

chgfile=/var/chkboot/bootfiles-diff

if [[ -s $chgfile ]] ; then 
    cat $chgfile | zenity --title "ALERT: Boot changes" --text-info --width 500 --height 300
    if [[ $? != 0 ]] ; then
	exit 2 # aborted by user
    fi
    # invalidate existing sudo password
    sudo -K
    gksudo -m "Enter your password to confirm those changes" "rm $chgfile"
    if [[ $? == 0 ]] ; then
	zenity --info --title "Confirmation" --text "Deleted $chgfile" 
    else
	# zenity --info --title "Error" --text "Could not delete $chgfile" 
	exit 2
    fi
fi

