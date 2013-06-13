#!/bin/sh

#
# This script is used to automatically install
# the gapps copy located on /sdcard (hopefully mounted)
# IF gapps is not already installed on the device
#


# only install gapps package if md5sum matches this: (cannot use sdcard as we are not multiuser yet)
echo "1db7dfd860a6c2a5fd3adab154276335  /data/media/0/gapps.yuga.tgz" > /dev/.yg_md5
cd /

if ! grep -q '^tmpfs /data' /proc/mounts ; then
    if [ ! -f /system/app/SetupWizard.apk ] ; then
        if /system/xbin/md5sum -c /dev/.yg_md5 ; then
            # ok, md5sum of file is correct: let's install gapps
            mount -o remount,rw /system
            /system/xbin/tar -xvf /data/media/0/gapps.yuga.tgz
            sync
            reboot
        fi
    fi
fi

# tell init to continue
touch /dev/.yginstall_done

# we MAY get started again if we are in encryption mode
# we are therefore removing the trigger after some time
sleep 3
rm /dev/.yginstall_done
rm /dev/.yg_md5
