#!/bin/sh
set -x 

mkdir -p kernel-headers/linux

for x in msm_mdp.h msm_ion.h msm_rotator.h msm_charm.h ; do
	../../../bionic/libc/kernel/tools/clean_header.py -k ../../../kernel/sony/apq8064 ../../../kernel/sony/apq8064/include/linux/$x > kernel-headers/linux/$x
done
