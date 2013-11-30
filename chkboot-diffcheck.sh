#!/usr/bin/env bash

# chkboot-diffcheck.sh: copy to /etc/profile.d/chkboot-diffcheck.sh and change its permissions to executable
#
# author: ju (ju at heisec dot de)
# contributors: inhies, prurigro
#
# license: GPLv2

source /etc/default/chkboot.conf

if [[ -s "${CHKBOOT_DATA}/${CHANGES_ALERT}" ]]; then
    echo -e "\e[0;${HIGHLIGHT_COLOUR};47m"
    echo "ALERT: Changes have been detected in your boot files!"
    echo "The following list of files contained in have changed since the last time this script was run (filename inode sha256 BLOCKS):"
    cat "${CHKBOOT_DATA}/${CHANGES_ALERT}"
    echo -e "\nThis notification will continue to appear until you either run \"chkboot\" again as root or restart your computer"
    echo -e "\e[0m"

    return 1
fi
