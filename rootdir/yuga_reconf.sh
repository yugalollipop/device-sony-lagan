#!/bin/sh

cat /data/misc/.pabx_settings_fsc /sys/devices/i2c-0/0-0036/leds/lm3533-lcd-bl/fsc
cat /data/misc/.pabx_settings_vibra /sys/devices/virtual/timed_output/vibrator/vib_level
cat /data/misc/.pabx_settings_double_tap /sys/devices/virtual/input/input1/wakeup_gesture
