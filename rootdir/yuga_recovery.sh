#!/bin/sh

export PATH="/sbin"

EVENT_FILE="/dev/input/event9"
EVENT_OUT="/dev/.yuga_recovery_do"
INIT_GOON="/dev/.recovery_aborted"

fancyass () {
echo "Executing"
	for x in `busybox_static seq 200 -5 0` ; do
		echo $x
		busybox_static echo $x > /sys/class/leds/lm3533-blue/brightness
		busybox_static echo $x > /sys/class/leds/lm3533-red/brightness
		busybox_static echo $x > /sys/class/leds/lm3533-green/brightness
		busybox_static sleep 0.03
	done
}

# stolen from CM :-)
busybox_static cat $EVENT_FILE > $EVENT_OUT &

# play some silly LED animation
fancyass
busybox_static pkill -f "busybox_static cat $EVENT_FILE"

if [ -s $EVENT_OUT ] ; then
	echo 150 > /sys/class/leds/lm3533-blue/brightness
	
	cd /
	busybox_static mount -o remount,rw /
	cd recovery
	busybox_static mkdir tmp proc sys
	busybox_static mount --bind /dev /recovery/dev
	busybox_static umount /proc
	busybox_static umount /sys
	busybox_static cpio -i < /recovery/ramdisk-recovery.cpio
	busybox_static chroot /recovery /init
fi

busybox_static touch $INIT_GOON

