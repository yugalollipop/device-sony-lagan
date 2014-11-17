PRODUCT_VENDOR_KERNEL_HEADERS := device/sony/lagan/kernel-headers

TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_BOARD_PLATFORM := msm8960
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := krait
TARGET_CPU_SMP := true
TARGET_GLOBAL_CFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_NO_RADIOIMAGE := true
TARGET_NO_RECOVERY := true
TARGET_NO_KERNEL := false

BOARD_KERNEL_BOOTIMG := true
BOARD_KERNEL_BASE := 0x80200000
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x02000000
BOARD_KERNEL_CMDLINE := androidboot.hardware=sony user_debug=31 msm_rtb.filter=0x3F ehci-hcd.park=3 vmalloc=400M
BOARD_KERNEL_PAGESIZE := 2048

USE_OPENGL_RENDERER := true

BOARD_USES_GENERIC_AUDIO := false
BOARD_USES_ALSA_AUDIO := true
BOARD_USES_LEGACY_ALSA_AUDIO:= false
USE_PROPRIETARY_AUDIO_EXTENSIONS := false

BLUETOOTH_HCI_USE_MCT := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/sony/lagan
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_QCOM := true

TARGET_SYSTEM_PROP := device/sony/lagan/system.prop

TARGET_USES_ION := true
USE_DEVICE_SPECIFIC_CAMERA := true

BOARD_HAS_QCOM_WLAN := true
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_qcwcn
BOARD_WLAN_DEVICE := qcwcn
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_qcwcn
HOSTAPD_VERSION := VER_0_8_X
WIFI_DRIVER_FW_PATH_AP  := "ap"
WIFI_DRIVER_FW_PATH_P2P := "p2p"
WIFI_DRIVER_FW_PATH_STA := "sta"
WIFI_DRIVER_MODULE_ARG := ""
WIFI_DRIVER_MODULE_NAME := "wlan"
WIFI_DRIVER_MODULE_PATH := "/system/lib/modules/wlan.ko"
WPA_SUPPLICANT_VERSION := VER_0_8_X

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false

BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 131072

BOARD_SEPOLICY_DIRS += \
       device/sony/lagan/sepolicy

BOARD_SEPOLICY_UNION += \
	bluetooth_loader.te \
	bootanim.te \
	bridge.te \
	camera.te \
	conn_init.te \
	device.te \
	domain.te \
	file_contexts \
	file.te \
	hci_attach.te \
	hostapd.te \
	init.te \
	kickstart.te \
	mediaserver.te \
	mpdecision.te \
	netd.te \
	netmgrd.te \
	property_contexts \
	property.te \
	qcfqd.te \
	qmux.te \
	radio.te \
	rild.te \
	rmt.te \
	sensors.te \
	surfaceflinger.te \
	system_app.te \
	system_server.te \
	tad_static.te \
	taimport.te \
	ta_qmi_client.te \
	tee.te \
	te_macros \
	thermald.te \
	ueventd.te

BOARD_CHARGER_ENABLE_SUSPEND := true
