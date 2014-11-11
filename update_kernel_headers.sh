#!/bin/sh
set -x 

CLEAN_HEADERS='../../../bionic/libc/kernel/tools/clean_header.py -k ../../../kernel/sony/apq8064 ../../../kernel/sony/apq8064/include/linux/'

mkdir -p kernel-headers/linux

for x in msm_mdp.h msm_ion.h msm_rotator.h msm_charm.h ; do
	../../../bionic/libc/kernel/tools/clean_header.py -k ../../../kernel/sony/apq8064 ../../../kernel/sony/apq8064/include/linux/$x > kernel-headers/linux/$x
done

# the UAPI of 5.0 expects a 3.14 (?) kernel - and does not match our definition of ion.h: fix it forcefully
$CLEAN_HEADERS/ion.h  | sed 's/_LINUX_ION_H/_UAPI_LINUX_ION_H/' > ../../../bionic/libc/kernel/uapi/linux/ion.h

