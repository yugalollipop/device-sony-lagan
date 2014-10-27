#!/bin/sh
set -x 

mkdir -p kernel-headers/linux

for x in msm_mdp.h msm_ion.h msm_rotator.h ; do
	../../../bionic/libc/kernel/tools/clean_header.py -k ../../../kernel/sony/kernel_10_4_B_0_569 ../../../kernel/sony/kernel_10_4_B_0_569/include/linux/$x > kernel-headers/linux/$x
done
