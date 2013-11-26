 #!/bin/bash

# check files under /boot for changes
# Author: ju (ju at heisec dot de)
# 
# License: GPLv2 or later

# Note: this will NOT protect against BIOS trojans or
# (kernel) rootkits that mimmick the old files

# format of the ouput file is:
# filename   inode    sha1    BLOCKS: ...

# Todo: 
## backup files


# the boot device - check "mount" for /boot
bdev=/dev/sda1
bdisk=/dev/sda
bdir=/boot
chkdir="/var/chkboot"

now=`date +"%y%m%d-%H%M"`

# some filenames
new="$chkdir/bootfiles-$now"
lastfiles="$chkdir/bootfiles-last"
diff="$chkdir/bootfiles-diff"
diffn="$chkdir/bootfiles-diff-$now"
mbr="$chkdir/mbr-$now"
lastmbr="$chkdir/mbr-last"

mkdir -p $chkdir 2>/dev/null 

# read MBR
dd if=$bdisk of=$mbr bs=512 count=1 2>/dev/null

# get file infos
savdir=`pwd`; cd $bdir
files=`find . -xdev -type f`
# remove files to skip
files=`echo $files | sed "s/.\/grub\/grubenv//"`
for f in $files; do 
    hash=`sha1sum -b $f | awk '{print $1}'`
    inode=`stat --printf="%i\n" $f`
    blcks=`
         debugfs -R "stat $f"  $bdev 2>/dev/null |\
         grep -A 1 -e 'BLOCKS:' -e 'EXTENTS' | tail -1 
      `
    echo "$f $inode $hash $blcks"
done > $new

# no output?
[ -s "$new" ] || ( logger -t chk_boot "no output" ; exit )

# initialise 
if [ ! -s "$lastmbr" ] ; then
    logger -t chk_boot  "Created new $mbr" 
    ln -s -f $mbr $lastmbr
fi
if [ ! -s "$lastfiles" ] ; then
    logger -t chk_boot  "Created new $new" 
    ln -s -f $new $lastfiles
    exit
fi

# check for changes
changed=0
( diff $lastfiles $new >> $diffn ) || changed=1
( diff $lastmbr $mbr >> $diffn ) || changed=1

# do alerting
if [ $changed != 0 ] ; then
    echo "Changes found `date`
      This can happen after for example kernel updates. 
      To accept the changes, delete $diff

    " >> $diff
    cat $diffn >> $diff
    logger -t chk_boot  "ALERT: Found changes $diffn" 
    # our duty is done, acept new standard
    ln -s -f $new $lastfiles
    ln -s -f $mbr $lastmbr
    exit 1
else
    logger -t chk_boot  "no changes found" 
    rm -f $mbr $diffn $new
fi 

cd $savdir