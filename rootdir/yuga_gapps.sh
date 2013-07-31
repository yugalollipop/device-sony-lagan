#!/bin/sh

#
# This script is used to automatically install
# the gapps copy located on /sdcard (hopefully mounted)
# IF gapps is not already installed on the device
#

MD5_GAPPS="156256f9257e9cea9e0f9bdbcd898135"
PTH_GAPPS="/data/media/0/gapps.yuga43_shaky.tgz"

MD5_SU="8c164c27cc0fa819348a7f553fc51367"
PTH_SU="/data/media/0/superuser43_beta2.tgz"

# only install gapps package if md5sum matches this: (cannot use sdcard as we are not multiuser yet)
echo "$MD5_GAPPS  $PTH_GAPPS" > /dev/.yg_gapps_md5
echo "$MD5_SU  $PTH_SU"       > /dev/.yg_su_md5

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

    if [ ! -f /system/xbin/su_force_until_gapps_replaced ] ; then
        if /system/xbin/md5sum -c /dev/.yg_su_md5 ; then
            # superuser not installed and tar-md5 matches: doit!
            mount -o remount,rw /system
            /system/xbin/tar -xvf $PTH_SU
            mount -o remount,rw /system
            # no need to reboot just for this
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
rm /dev/.yg_su_md5
