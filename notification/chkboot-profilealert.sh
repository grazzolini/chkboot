# chkboot-profilealert.sh: copy to /etc/profile.d/chkboot-profilealert.sh
#
# author: ju (ju at heisec dot de)
# contributors: inhies, prurigro
#
# license: GPLv2

source /etc/default/chkboot.conf

# only try to display chkboot changes if the 'proofile' alert style has been selected
if [ ! $(echo "${CHKBOOT_STYLES}" | grep -c "profile") = 0 ]; then
    # run whatever issues exist then return the response
    chkboot-check
    return "$?"
fi
