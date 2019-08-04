#
# Copyright (C) 2018-2019 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#
$(call inherit-product, device/oneplus/sm8150-common/common.mk)

# Vendor properties
-include $(LOCAL_PATH)/vendor_props.mk
$(call inherit-product-if-exists, vendor/gapps/arm64/arm64-vendor.mk)
$(call inherit-product, vendor/omni/config/phone-xxhdpi-4096-dalvik-heap.mk)
$(call inherit-product, vendor/omni/config/phone-xxhdpi-2048-hwui-memory.mk)

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay
    
#from build treble includes
PRODUCT_COPY_FILES += \
    system/core/rootdir/init.zygote64_32.rc:root/init.zygote64_32.rc \
    system/core/rootdir/init.zygote32_64.rc:root/init.zygote32_64.rc

TARGET_SUPPORTS_32_BIT_APPS := true
TARGET_SUPPORTS_64_BIT_APPS := true

PRODUCT_PACKAGES += \
    libinit_oneplus7pro

# SP-NDK:
PRODUCT_PACKAGES += \
    libvulkan \

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.build.version.all_codenames=$(PLATFORM_VERSION_ALL_CODENAMES) \
    ro.build.version.codename=$(PLATFORM_VERSION_CODENAME) \
    ro.build.version.release=$(PLATFORM_VERSION) \
    ro.build.version.sdk=$(PLATFORM_SDK_VERSION)

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    system \
    vbmeta

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

PRODUCT_PACKAGES += \
    otapreopt_script \
    brillo_update_payload \
    update_engine \
    update_engine_sideload \
    update_verifier

# Boot control
PRODUCT_PACKAGES_DEBUG += \
    bootctl

PRODUCT_STATIC_BOOT_CONTROL_HAL := \
    bootctrl.msmnile \
    libcutils \
    libgptutils \
    libz \

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

PRODUCT_PACKAGES += \
    omni_charger_res_images \
    animation.txt \
    font_charger.png

PRODUCT_PACKAGES += \
    com.android.future.usb.accessory

# Live Wallpapers
PRODUCT_PACKAGES += \
    LiveWallpapers \
    LiveWallpapersPicker \
    VisualizationWallpapers \
    librs_jni

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.verified_boot.xml

# Prebuilt
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,device/oneplus/oneplus7pro/prebuilt/system,system) \
    $(call find-copy-subdir-files,*,device/oneplus/oneplus7pro/prebuilt/root,root)


PRODUCT_AAPT_CONFIG := xxhdpi
PRODUCT_AAPT_PREF_CONFIG := xxhdpi
PRODUCT_CHARACTERISTICS := nosdcard

# audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \

# Lights
PRODUCT_PACKAGES += \
    lights.oneplus7pro

PRODUCT_PACKAGES += \
    android.hardware.light-V2.0-java \
    android.hardware.light@2.0-impl

PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/media_codecs_google_video.xml

# NFC - NCI
#PRODUCT_PACKAGES += \
    NfcNci \
    libnfc_nci_jni \
    Tag \
    com.android.nfc_extras

PRODUCT_PACKAGES += \
    android.hardware.nfc@1.1 \
    android.hardware.nfc@1.0

# NFC - NQ (NXP)
PRODUCT_PACKAGES += \
    Tag \
    com.android.nfc_extras

PRODUCT_PACKAGES += \
    libwifi-hal-qcom \
    wificond \
    wifilogd \
    libwpa_client \
    hostapd \
    wpa_supplicant \
    wpa_supplicant.conf

PRODUCT_PACKAGES += \
    libcld80211 \
    lib_driver_cmd_qcwcn

# Camera
PRODUCT_PACKAGES += \
    vendor.lineage.camera.motor@1.0 \
    vendor.lineage.camera.motor@1.0-service.oneplus_msmnile \
    OnePlusCameraHelper

# Device init scripts
PRODUCT_PACKAGES += \
    fstab.qcom \
    init.display.guacamole.rc \
    vendor.qti.hardware.wifi@1.0 \
    android.hardware.vibrator@1.2-service.oneplus7pro

# Temporary handling
#
# Include config.fs get only if legacy device/qcom/<target>/android_filesystem_config.h
# does not exist as they are mutually exclusive.  Once all target's android_filesystem_config.h
# have been removed, TARGET_FS_CONFIG_GEN should be made unconditional.
DEVICE_CONFIG_DIR := $(dir $(firstword $(subst ]],, $(word 2, $(subst [[, ,$(_node_import_context))))))
ifeq ($(wildcard device/oneplus/oneplus7pro/android_filesystem_config.h),)
  TARGET_FS_CONFIG_GEN := device/oneplus/oneplus7pro/config.fs
else
  $(warning **********)
  $(warning TODO: Need to replace legacy $(DEVICE_CONFIG_DIR)android_filesystem_config.h with config.fs)
  $(warning **********)
endif

