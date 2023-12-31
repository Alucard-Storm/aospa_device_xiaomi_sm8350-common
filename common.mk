#
# Copyright (C) 2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Enable virtual A/B OTA
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Inherit proprietary targets
$(call inherit-product, vendor/xiaomi/sm8350-common/sm8350-common-vendor.mk)

# Setup dalvik vm configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# API
PRODUCT_SHIPPING_API_LEVEL := 30

# Platform
TARGET_BOARD_PLATFORM := lahaina

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=erofs \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script

# Additional native libraries
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/public.libraries.txt:$(TARGET_COPY_OUT_VENDOR)/etc/public.libraries.txt

# Blur
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.surface_flinger.supports_background_blur=1

# Boot animation
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080

# Boot control
PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-impl-qti \
    android.hardware.boot@1.1-impl-qti.recovery \
    android.hardware.boot@1.1-service

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-impl \
    android.hardware.camera.provider@2.4-service_64 \
    vendor.qti.hardware.camera.device@1.0.vendor \
    vendor.qti.hardware.camera.postproc@1.0.vendor \
    libcamera2ndk_vendor \
    libion.vendor

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml

# Device Settings
PRODUCT_PACKAGES += \
    XiaomiParts

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/parts/privapp-permissions-parts.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-parts.xml

# Dexperopt
PRODUCT_DEXPREOPT_SPEED_APPS += SystemUIGoogle  # For internal
PRODUCT_DEXPREOPT_SPEED_APPS += SystemUI  # For AOSP
PRODUCT_DEXPREOPT_SPEED_APPS += Settings

# Compile SystemUI on device with `speed`.
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.systemuicompilerfilter=speed

# Display
TARGET_GRALLOC_HANDLE_HAS_NO_RESERVED_SIZE := true

PRODUCT_PACKAGES += \
    disable_configstore

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm@1.4.vendor \
    android.hardware.drm-service.clearkey

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.3-service.xiaomi

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml

# Fstab
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/charger_fstab.qcom:$(TARGET_COPY_OUT_VENDOR)/etc/charger_fstab.qcom

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.qcom:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.default \
    $(LOCAL_PATH)/rootdir/etc/fstab.qcom:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.default \
    $(LOCAL_PATH)/rootdir/etc/fstab.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.default

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0.vendor

# GPS
LOC_HIDL_VERSION := 4.0

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/gps/flp.conf:$(TARGET_COPY_OUT_VENDOR)/etc/flp.conf \
    $(LOCAL_PATH)/configs/gps/gps.conf:$(TARGET_COPY_OUT_VENDOR)/etc/gps.conf

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-service

PRODUCT_PACKAGES += \
    libhidltransport.vendor \
    libhwbinder.vendor

# HotwordEnrollement
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/privapp-permissions-hotword.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-hotword.xml

# Init scripts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/init.batterysecret.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.batterysecret.rc \
    $(LOCAL_PATH)/rootdir/etc/init.mi_thermald.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.mi_thermald.rc \
    $(LOCAL_PATH)/rootdir/etc/init.lahaina.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.lahaina.rc \
    $(LOCAL_PATH)/rootdir/etc/init.qcom.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.qcom.usb.rc \
    $(LOCAL_PATH)/rootdir/etc/init.target.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.target.rc

# IFAA manager
PRODUCT_PACKAGES += \
    IFAAService

# IR
PRODUCT_PACKAGES += \
    android.hardware.ir@1.0-impl \
    android.hardware.ir@1.0-service

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.consumerir.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.consumerir.xml

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.1.vendor

# Inherit several Android Go Configurations(Beneficial for everyone, even on non-Go devices)
PRODUCT_USE_PROFILE_FOR_BOOT_IMAGE := true
PRODUCT_DEX_PREOPT_BOOT_IMAGE_PROFILE_LOCATION := frameworks/base/config/boot-image-profile.txt

# Lights 
PRODUCT_PACKAGES += \
    lights.lahaina

# Media
PRODUCT_PACKAGES += \
    libstagefright_omx \
    libstagefright_foundation \
    libsfplugin_ccodec_utils.vendor

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media/lahaina/media_codecs_lahaina_vendor.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_lahaina_vendor.xml \
    $(LOCAL_PATH)/configs/media/lahaina/media_codecs_lahaina.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_lahaina.xml \
    $(LOCAL_PATH)/configs/media/lahaina/media_codecs_performance_lahaina_vendor.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance_lahaina_vendor.xml \
    $(LOCAL_PATH)/configs/media/lahaina/media_codecs_performance_lahaina.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance_lahaina.xml \
    $(LOCAL_PATH)/configs/media/lahaina/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml \
    $(LOCAL_PATH)/configs/media/lahaina/media_codecs_system_default_lahaina.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_system_default_lahaina.xml \
    $(LOCAL_PATH)/configs/media/lahaina/media_codecs_with_dolby_lahaina.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_with_dolby_lahaina.xml \
    $(LOCAL_PATH)/configs/media/lahaina/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    $(LOCAL_PATH)/configs/media/lahaina/media_profiles_lahaina.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_lahaina.xml \
    $(LOCAL_PATH)/configs/media/lahaina/media_profiles_V1_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml \
    $(LOCAL_PATH)/configs/media/lahaina/media_profiles_vendor.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_vendor.xml \
    $(LOCAL_PATH)/configs/media/lahaina/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media/shima/media_codecs_performance_shima_v1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance_shima_v1.xml \
    $(LOCAL_PATH)/configs/media/shima/media_codecs_system_default_shima.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_system_default_shima.xml \
    $(LOCAL_PATH)/configs/media/shima/media_codecs_with_dolby_shima.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_with_dolby_shima.xml \
    $(LOCAL_PATH)/configs/media/shima/media_codecs_shima_v1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_shima_v1.xml \
    $(LOCAL_PATH)/configs/media/shima/media_profiles_shima_v1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_shima_v1.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media/yupik/media_codecs_performance_yupik_v1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance_yupik_v1.xml \
    $(LOCAL_PATH)/configs/media/yupik/media_codecs_system_default_yupik.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_system_default_yupik.xml \
    $(LOCAL_PATH)/configs/media/yupik/media_codecs_with_dolby_yupik.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_with_dolby_yupik.xml \
    $(LOCAL_PATH)/configs/media/yupik/media_codecs_yupik_v1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_yupik_v1.xml \
    $(LOCAL_PATH)/configs/media/yupik/media_profiles_yupik_v1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_yupik_v1.xml

# Network
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.ipsec_tunnels.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.ipsec_tunnels.xml

# Net
PRODUCT_PACKAGES += \
    android.system.net.netd@1.1.vendor

# Neural Network
PRODUCT_PACKAGES += \
    android.hardware.neuralnetworks@1.3.vendor
# Overlay
PRODUCT_PACKAGES += \
    LahainaCarrierConfigResCommonOverlay \
    LahainaFrameworksResCommonOverlay \
    LahainaSettingsResCommonOverlay \
    LahainaSystemUIResCommonOverlay \
    LahainaWifiResCommonOverlay

# Partitions
PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Paranoid Doze
PRODUCT_PACKAGES += \
    ParanoidDoze

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.sensor.pickup=xiaomi.sensor.pickup \
    ro.sensor.pickup.lower.value=2

# QTI
TARGET_COMMON_QTI_COMPONENTS := \
    adreno \
    alarm \
    audio \
    av \
    bt \
    gps \
    init \
    display \
    media \
    nfc \
    overlay \
    telephony \
    usb \
    wfd \
    wlan \
    perf

# Recovery
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/init.recovery.qcom.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.qcom.rc

# RenderScript HAL
PRODUCT_PACKAGES += \
    android.hardware.renderscript@1.0-impl

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors@2.1-service.xiaomi-multihal \
    android.frameworks.sensorservice@1.0 \
    android.frameworks.sensorservice@1.0.vendor \
    vendor.qti.hardware.display.mapper@1.1.vendor \
    libjsoncpp \
    libjsoncpp_ndk

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.hifi_sensors.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.hifi_sensors.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml

# Storage
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.fuse.passthrough.enable=true

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/xiaomi \
    hardware/google/interfaces \
    hardware/google/pixel

# Speed profile services and wifi-service to reduce RAM and storage
PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed-profile

# Ueventd
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/ueventd.lahaina.rc:$(TARGET_COPY_OUT_VENDOR)/etc/ueventd.lahaina.rc

# Update engine
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

# Vibrator
PRODUCT_PACKAGES += \
    vendor.qti.hardware.vibrator.service.xiaomi_sm8350

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/vibrator/excluded-input-devices.xml:$(TARGET_COPY_OUT_VENDOR)/etc/excluded-input-devices.xml

# Verified boot
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/android.software.verified_boot.xml \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.verified_boot.xml

# VNDK
PRODUCT_PACKAGES += \
    android.hardware.common-V1-ndk_platform.vendor

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/wifi/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/WCNSS_qcom_cfg.ini

# WiFi Display
PRODUCT_PACKAGES += \
    libwfdaac_vendor
