#!/usr/bin/env bash

# chkboot-bootcheck.sh: copy this somewhere and have it run on boot, before a user logs in. 
#
# author: ju (ju at heisec dot de)
# contributors: inhies, prurigro
#
# license: GPLv2

ISSUE_MSG="ALERT: BOOT FILES MODIFIED"

source /etc/default/chkboot.conf

if [[ -s "${CHKBOOT_DATA}/${CHANGES_ALERT}" ]]; then
    grep -q -e "$ISSUE_MSG" /etc/issue || sed -i.bak "$ a $ISSUE_MSG\n" /etc/issue
else
    sed -i.bak "/$ISSUE_MSG/,+1d" /etc/issue
fi
