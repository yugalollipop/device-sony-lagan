#!/bin/sh

#
# This script is used to automatically install
# the gapps copy located on /sdcard (hopefully mounted)
# IF gapps is not already installed on the device
#

MD5_GAPPS="ba621958d88ae2a65af56b26fa506065"
PTH_GAPPS="/data/media/0/gapps_44_yuga_1.tgz"

# only install gapps package if md5sum matches this: (cannot use sdcard as we are not multiuser yet)
echo "$MD5_GAPPS  $PTH_GAPPS" > /dev/.yg_gapps_md5

cd /

if ! grep -q '^tmpfs /data' /proc/mounts ; then
    if [ ! -f /system/app/SetupWizard.apk ] ; then
        if /system/xbin/md5sum -c /dev/.yg_gapps_md5 ; then
            # ok, md5sum of file is correct: let's install gapps
            mount -o remount,rw /system
            /system/xbin/tar -xvf $PTH_GAPPS
            sync
            echo s > /proc/sysrq-trigger
            echo u > /proc/sysrq-trigger
            echo b > /proc/sysrq-trigger
        fi
    fi
fi

# tell init to continue
touch /dev/.yginstall_done

# we MAY get started again if we are in encryption mode
# we are therefore removing the trigger after some time
sleep 3
rm /dev/.yginstall_done
rm /dev/.yg_gapps_md5
