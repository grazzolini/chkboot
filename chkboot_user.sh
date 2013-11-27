#!/bin/bash

# small script to check if files under /boot changed
# Author: ju (ju at heisec dot de)
# 
# License: GPLv2 or later

. /etc/chkboot.conf

if [[ -s $chgfile ]] ; then 
	# Check to see if we are running in X
	if [ "$DISPLAY" ]; then
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
			zenity --info --title "Error" --text "Could not delete $chgfile" 
			exit 1
		fi

	else
		echo "ALERT: Boot changes"
		cat $chgfile

		echo "Do you want to delete $chgfile (Yes/no)?"
		echo -n "You must answer 'Yes' (Capital 'Y' lower case 'es'): "
		read answer

		if [ "$answer" != "Yes" ]; then 
			exit 2
		fi

		# invalidate existing sudo password
		sudo -K
		echo "Enter your password to confirm those changes" 
		sudo rm $chgfile

		if [[ $? == 0 ]] ; then
			echo "Deleted $chgfile" 
		else
			echo "Could not delete $chgfile"
			exit 2
		fi
	fi
fi

