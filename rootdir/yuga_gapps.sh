#!/bin/sh

#
# This script is used to automatically install
# the gapps copy located on /sdcard (hopefully mounted)
# IF gapps is not already installed on the device
#

# only install gapps package if md5sum matches this: (cannot use sdcard as we are not multiuser yet)
echo "856962e2eac0289f956f21800110a7f6  /data/media/0/gapps.yuga.tgz" > /dev/.yg_md5

cd /

if [ ! -f /system/app/SetupWizard.apk ] ; then
    if /system/xbin/md5sum -c /dev/.yg_md5 ; then
        # ok, md5sum of file is correct: let's install gapps
        mount -o remount,rw /system
        /system/xbin/tar -xvf /data/media/0/gapps.yuga.tgz
        sync
        reboot
    fi
fi

rm /dev/.yg_md5
touch /dev/.yginstall_done
