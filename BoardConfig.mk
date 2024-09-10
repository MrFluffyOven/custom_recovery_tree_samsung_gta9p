#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/samsung/gta9p

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

# Architecture
TARGET_IS_64_BIT := true
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := kryo300
TARGET_BOARD_SUFFIX := _64

# Architecture | 2nd
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a75

# APEX
DEXPREOPT_GENERATE_APEX_IMAGE := true

# Bootloader
TARGET_NO_RADIOIMAGE := true
TARGET_NO_BOOTLOADER := true
TARGET_BOOTLOADER_BOARD_NAME := holi

# Display
TARGET_SCREEN_DENSITY := 240
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1200
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_HAS_FLIPPED_SCREEN := true

# Board Commandline
BOARD_KERNEL_CMDLINE += \
	console=ttyMSM0,115200n8 \
	earlycon=msm_geni_serial,0x04C8C000 \
	androidboot.hardware=qcom \
	androidboot.console=ttyMSM0 \
	androidboot.memcg=1 \
	lpm_levels.sleep_disabled=1 \
	video=vfb:640x400,bpp=32,memsize=3072000 \
	msm_rtb.filter=0x237 \
	service_locator.enable=1 \
	androidboot.usbcontroller=4e00000.dwc3 \
	swiotlb=0 \
	loop.max_part=7 \
	cgroup.memory=nokmem,nosocket \
	iptable_raw.raw_before_defrag=1 \
	ip6table_raw.raw_before_defrag=1 \
	firmware_class.path=/vendor/firmware_mnt/image \
	androidboot.selinux=permissive

# Kernel
TARGET_KERNEL_ARCH := $(TARGET_ARCH)
BOARD_KERNEL_IMAGE_NAME := Image
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/$(BOARD_KERNEL_IMAGE_NAME)
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img

BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_MKBOOTIMG_ARGS := \
	--dtb $(TARGET_PREBUILT_DTB) \
	--board SRPWD25B001 \
	--ramdisk_offset 0x02000000 \
	--kernel_offset 0x00008000 \
	--second_offset 0x00000000 \
	--dtb_offset 0x01f00000 \
	--header_version 2 \
	--tags_offset 0x01e00000
BOARD_CUSTOM_BOOTIMG_MK := $(DEVICE_PATH)/mkbootimg.mk
BOARD_CUSTOM_BOOTIMG := true

# Partitions | size
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x6000000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x60E1000
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 0x6000000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 0xEFD9A000
BOARD_USERDATAIMAGE_PARTITION_SIZE:= 0x1AF00FB000
BOARD_PRODUCTIMAGE_PARTITION_SIZE := 0x630D8000
BOARD_SYSTEM_EXTIMAGE_PARTITION_SIZE := 0x1349B000
BOARD_VENDORIMAGE_PARTITION_SIZE := 0x3D244000
BOARD_CACHEIMAGE_PARTITION_SIZE := 0xC800000
BOARD_ODMIMAGE_PARTITION_SIZE := 0x177000

# Partitions | type
BOARD_SYSTEMIMAGE_PARTITION_TYPE := erofs
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := erofs

# Partitions | copyout
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_ODM := odm

# Partitions | super
BOARD_SUPER_PARTITION_SIZE := 0x25E300000
BOARD_SUPER_PARTITION_GROUPS := samsung_dynamic_partitions
BOARD_SAMSUNG_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext vendor product odm
BOARD_SAMSUNG_DYNAMIC_PARTITIONS_SIZE := 9122611200 # TODO: Fix hardcoded value
BOARD_SUPPRESS_SECURE_ERASE := true

# Platforms/Hardwares
BOARD_USES_QCOM_HARDWARE := true
TARGET_BOARD_PLATFORM := holi
TARGET_BOARD_PLATFORM_GPU := adreno619
QCOM_BOARD_PLATFORMS += $(TARGET_BOARD_PLATFORM)

# Recovery
RECOVERY_SDCARD_ON_DATA := true
BOARD_INCLUDE_RECOVERY_DTBO := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TARGET_USES_UEFI := true
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery.fstab
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

 # Root
BOARD_ROOT_EXTRA_FOLDERS := \
    carrier \
    efs \
    omr \
    optics \
    prism \
    spu \
    persist \
    sec_efs

# Security patch level
VENDOR_SECURITY_PATCH := 2099-12-31
PLATFORM_SECURITY_PATCH := $(VENDOR_SECURITY_PATCH)
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# Encryption & Misc
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
BOARD_USES_METADATA_PARTITION := true
BOARD_USES_QCOM_FBE_DECRYPTION := true

# Debug
TARGET_USES_LOGD := true
TWRP_INCLUDE_LOGCAT := true
TWRP_EVENT_LOGGING := true
TARGET_RECOVERY_DEVICE_MODULES += debuggerd
TW_RECOVERY_ADDITIONAL_RELINK_FILES += $(TARGET_OUT_EXECUTABLES)/debuggerd

# Fix for copying *.ko
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# TWRP Configuration
TW_THEME := portrait_hdpi
TW_EXTRA_LANGUAGES := true
TW_SCREEN_BLANK_ON_BOOT := true
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_CUSTOM_CPU_TEMP_PATH := "/sys/class/thermal/thermal_zone4/temp"
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_USE_TOOLBOX := true
TW_EXCLUDE_TWRPAPP := true
TW_INCLUDE_NTFS_3G := true
TW_HAS_DOWNLOAD_MODE := true
TW_MAX_BRIGHTNESS := 200
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_LIBRESETPROP := true
TW_NO_REBOOT_BOOTLOADER := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXCLUDE_APEX := true
TW_INCLUDE_FASTBOOTD := true
TW_PREPARE_DATA_MEDIA_EARLY := true
TW_SKIP_ADDITIONAL_FSTAB := true
TW_FORCE_KEYMASTER_VER := true
#TW_LOAD_VENDOR_MODULES := "adsp_loader_dlkm.ko apr_dlkm.ko q6_dlkm.ko q6_notifier_dlkm.ko q6_pdr_dlkm.ko snd_event_dlkm.ko dispcc-holi.ko usbtouchscreen.ko xhci-plat-hcd.ko sx933x_937x_sar.ko i2c-hid.ko hx9023s.ko eud.ko sensors_class.ko xhci-hcd.ko"
TW_LOAD_VENDOR_MODULES := $(strip $(shell cat $(DEVICE_PATH)/recovery/root/lib/modules/modules.load))
#TW_LOAD_VENDOR_BOOT_MODULES := true
#TW_LOAD_VENDOR_MODULES_EXCLUDE_GKI := true

# Maintainer/Version
include $(DEVICE_PATH)/version.mk

