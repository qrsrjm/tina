#############################################################################
############################# h8 configuration. ############################
#############################################################################
CONFIG_MEMORY_DRIVER = $(OPTION_MEMORY_DRIVER_ION)
CONFIG_DRAM_INTERFACE = $(OPTION_DRAM_INTERFACE_DDR3_32BITS)
CONFIG_VE_IPC = $(OPTION_VE_IPC_DISABLE)
CONFIG_CMCC = $(OPTION_CMCC_NO)
CONFIG_DTV = $(OPTION_DTV_NO)
CONFIG_IS_CAMERA_DECODER = $(OPTION_IS_CAMERA_DECODER_NO)
ifdef TARGET_BUSINESS_PLATFORM  
    ifeq (cmccwasu , $(TARGET_BUSINESS_PLATFORM))
        CONFIG_CMCC = $(OPTION_CMCC_YES)
    endif
endif
CONFIG_DEINTERLACE = $(OPTION_SW_DEINTERLACE)
USE_NEW_DISPLAY := 0
GPU_TYPE_MALI := 0
DROP_3D_SECOND_VIDEO_STREAM := 0
MUTE_DRM_WHEN_HDMI_FLAG := 0
ENABLE_SUBTITLE_DISPLAY_IN_CEDARX := 0
LINUX_VERSION = $(LINUX_VERSION_3_4)
USE_NEW_BDMV_STREAM := 0
PLAYREADY_DRM_INVOKE := 0
H265_4K_CHECK_SCALE_DOWN := 0
NON_H265_4K_NOT_SCALE_DOWN := 0
SUPPORT_H265 := 0
ANTUTU_NOT_SUPPORT := 1
ENABLE_MEDIA_BOOST := 0
DROP_DELAY_FRAME = $(DROP_DELAY_FRAME_720P)
ROTATE_PIC_HW := 0
VE_PHY_OFFSET := 0x40000000
ZEROCOPY_PIXEL_FORMAT = $(ZEROCOPY_PIXEL_FORMAT_YV12)
GPU_Y_C_ALIGN = $(GPU_Y32_C16_ALIGN)
SEND_3_BLACK_FRAME_TO_GPU := 1
ZEROCOPY_DYNAMIC_CHECK := 1
GRALLOC_PRIV := 0
VIDEO_DIRECT_ACCESS_DE := 2
KEY_PARAMETER_GET := 0
DISPLAY_CMD_SETVIDEOSIZE_POSITION := 0
DEINTERLACE_IOWR := 0
DEINTERLACE_FORMAT = $(DEINTERLACE_FORMAT_NV12)
NEW_DISPLAY_DOUBLE_STREAM_NEED_NV21 := 1
OUTPUT_PIXEL_FORMAT = $(OUTPUT_PIXEL_FORMAT_YV12)
NOT_DROP_FRAME := 0
SOUND_DEVICE_SET_RAW_FLAG := 0
NATIVE_WIN_DISPLAY_CMD_GETDISPFPS := 0
IMG_NV21_4K_ALIGN := 0
DEINTERLACE_ADDR_64 := 0

########## configure CONFIG_MEMORY_DRIVER ##########
LOCAL_CFLAGS += -DCONFIG_MEMORY_DRIVER=$(CONFIG_MEMORY_DRIVER)

########## configure CONFIG_DRAM_INTERFACE ##########
LOCAL_CFLAGS += -DCONFIG_DRAM_INTERFACE=$(CONFIG_DRAM_INTERFACE)

########## configure CONFIG_VE_IPC ##########
LOCAL_CFLAGS += -DCONFIG_VE_IPC=$(CONFIG_VE_IPC)

########## configure CONFIG_CMCC ##########
LOCAL_CFLAGS += -DCONFIG_CMCC=$(CONFIG_CMCC)

########## configure CONFIG_DTV ##########
LOCAL_CFLAGS += -DCONFIG_DTV=$(CONFIG_DTV)

########## configure CONFIG_IS_CAMERA_DECODER ##########
LOCAL_CFLAGS += -DCONFIG_IS_CAMERA_DECODER=$(CONFIG_IS_CAMERA_DECODER)

#$(warning "SW_CHIP_PLATFORM:"$(SW_CHIP_PLATFORM))
#$(warning "PLATFORM_VERSION:"$(PLATFORM_VERSION)) 
#$(warning "TARGET_PRODUCT:"$(TARGET_PRODUCT))


########## configure USE_SW_DEINTERLACE ##########
#todo
#LIB_AW_PATH := $(TOP)/frameworks/av/media/liballwinner
#LAW_CFLAGS :=
#SW_DEINTERLACE_FLAGS = $(shell test -d $(LIB_AW_PATH)/LIBRARY/PLAYER/sw-deinterlace;echo $$?)
#ifeq ($(SW_DEINTERLACE_FLAGS), 0)
#USE_SW_DEINTERLACE := yes
#LAW_CFLAGS += -DUSE_SW_DEINTERLACE
#endif

########## configure CONFIG_DEINTERLACE ##########
LOCAL_CFLAGS += -DCONFIG_DEINTERLACE=$(CONFIG_DEINTERLACE)

############ configure USE_NEW_DISPLAY ###########
# on all secure box
ifeq ($(CONFIG_PRODUCT),$(OPTION_PRODUCT_TVBOX))
    ifeq ($(BOARD_WIDEVINE_OEMCRYPTO_LEVEL), 1)
    USE_NEW_DISPLAY := 1
    endif
endif

LOCAL_CFLAGS += -DUSE_NEW_DISPLAY=$(USE_NEW_DISPLAY)

########## configure GPU_TYPE_MALI ##########
LOCAL_CFLAGS += -DGPU_TYPE_MALI=$(GPU_TYPE_MALI)

########## configure DROP_3D_SECOND_VIDEO_STREAM ##########
ifeq (1, $(USE_NEW_DISPLAY))
    ifeq ($(CONFIG_PRODUCT), $(OPTION_PRODUCT_PAD))
        DROP_3D_SECOND_VIDEO_STREAM := 1
    endif
endif
LOCAL_CFLAGS += -DDROP_3D_SECOND_VIDEO_STREAM=$(DROP_3D_SECOND_VIDEO_STREAM)

########## configure MUTE_DRM_WHEN_HDMI_FLAG ##########
ifeq ($(CONFIG_PRODUCT), $(OPTION_PRODUCT_PAD))
    ifeq ($(CONFIG_OS_VERSION), $(OPTION_OS_VERSION_ANDROID_5_0))
        MUTE_DRM_WHEN_HDMI_FLAG := 1
    else ifeq ($(CONFIG_OS_VERSION), $(OPTION_OS_VERSION_ANDROID_6_0))
        MUTE_DRM_WHEN_HDMI_FLAG := 1
    endif
endif
LOCAL_CFLAGS += -DMUTE_DRM_WHEN_HDMI_FLAG=$(MUTE_DRM_WHEN_HDMI_FLAG)

########## configure WIDEVINE_OEMCRYPTO_LEVEL ##########
ifeq ($(BOARD_WIDEVINE_OEMCRYPTO_LEVEL), 1)
LAW_CFLAGS += -DWIDEVINE_OEMCRYPTO_LEVEL=1
else
LAW_CFLAGS += -DWIDEVINE_OEMCRYPTO_LEVEL=3
endif

########## configure CMCC ##########
CMCC := no
ifeq ($(CONFIG_CMCC), $(OPTION_CMCC_YES))
CMCC := yes
endif
LOCAL_CFLAGS += -DCMCC=$(CMCC)

########## configure DTV ##########
DTV := no
ifeq ($(CONFIG_DTV), $(OPTION_DTV_YES))
DTV := yes
endif
LOCAL_CFLAGS += -DDTV=$(DTV)

########## configure ENABLE_SUBTITLE_DISPLAY_IN_CEDARX ##########
#We surpport display subtitle in cedarx on android4.2 and 4.4.
#but the APIs of skia on android5.0 are much more different,
#so it do not work on android5.0

ifeq ($(CONFIG_OS_VERSION),$(OPTION_OS_VERSION_ANDROID_5_0))
    ENABLE_SUBTITLE_DISPLAY_IN_CEDARX := 0
else ifeq ($(CONFIG_OS_VERSION),$(OPTION_OS_VERSION_ANDROID_6_0))
    ENABLE_SUBTITLE_DISPLAY_IN_CEDARX := 0    
endif
LOCAL_CFLAGS += -DENABLE_SUBTITLE_DISPLAY_IN_CEDARX=$(ENABLE_SUBTITLE_DISPLAY_IN_CEDARX)

########## configure CEDARX_SUPPORT_SOUNDTOUCH ##########
ifeq ($(CONFIG_OS), $(OPTION_OS_ANDROID))
    #LOCAL_CFLAGS += -DCEDARX_SUPPORT_SOUNDTOUCH
endif

########## configure LINUX_VERSION ##########
LOCAL_CFLAGS += -DLINUX_VERSION=$(LINUX_VERSION)

############ configure USE_NEW_BDMV_STREAM ############
# on H64-tvbox only 
ifeq ($(CONFIG_PRODUCT),$(OPTION_PRODUCT_TVBOX))
    ifeq ($(CONFIG_OS_VERSION),$(OPTION_OS_VERSION_ANDROID_5_0))
		USE_NEW_BDMV_STREAM := 1
    endif
endif

LOCAL_CFLAGS += -DUSE_NEW_BDMV_STREAM=$(USE_NEW_BDMV_STREAM)

########## configure PLAYREADY_DRM_INVOKE ##########
LOCAL_CFLAGS += -DPLAYREADY_DRM_INVOKE=$(PLAYREADY_DRM_INVOKE)

########## configure H265_4K_CHECK_SCALE_DOWN ##########
LOCAL_CFLAGS += -DH265_4K_CHECK_SCALE_DOWN=$(H265_4K_CHECK_SCALE_DOWN)

########## configure NON_H265_4K_NOT_SCALE_DOWN ##########
LOCAL_CFLAGS += -DNON_H265_4K_NOT_SCALE_DOWN=$(NON_H265_4K_NOT_SCALE_DOWN)

########## configure SUPPORT_H265 ##########
LOCAL_CFLAGS += -DSUPPORT_H265=$(SUPPORT_H265)

########## configure ANTUTU_NOT_SUPPORT ##########
LOCAL_CFLAGS += -DANTUTU_NOT_SUPPORT=$(ANTUTU_NOT_SUPPORT)

########## configure ENABLE_MEDIA_BOOST ##########
LOCAL_CFLAGS += -DENABLE_MEDIA_BOOST=$(ENABLE_MEDIA_BOOST)

########## configure DROP_DELAY_FRAME ##########
LOCAL_CFLAGS += -DDROP_DELAY_FRAME=$(DROP_DELAY_FRAME)

########## configure ROTATE_PIC_HW ##########
LOCAL_CFLAGS += -DROTATE_PIC_HW=$(ROTATE_PIC_HW)

########## configure VE_PHY_OFFSET ##########
LOCAL_CFLAGS += -DVE_PHY_OFFSET=$(VE_PHY_OFFSET)

########## configure ZEROCOPY_PIXEL_FORMAT ##########
LOCAL_CFLAGS += -DZEROCOPY_PIXEL_FORMAT=$(ZEROCOPY_PIXEL_FORMAT)

########## configure GPU_Y_C_ALIGN ##########
LOCAL_CFLAGS += -DGPU_Y_C_ALIGN=$(GPU_Y_C_ALIGN)

########## configure SEND_3_BLACK_FRAME_TO_GPU ##########
LOCAL_CFLAGS += -DSEND_3_BLACK_FRAME_TO_GPU=$(SEND_3_BLACK_FRAME_TO_GPU)

########## configure ZEROCOPY_DYNAMIC_CHECK ##########
LOCAL_CFLAGS += -DZEROCOPY_DYNAMIC_CHECK=$(ZEROCOPY_DYNAMIC_CHECK)

########## configure GRALLOC_PRIV ##########
LOCAL_CFLAGS += -DGRALLOC_PRIV=$(GRALLOC_PRIV)

########## configure VIDEO_DIRECT_ACCESS_DE ##########
LOCAL_CFLAGS += -DVIDEO_DIRECT_ACCESS_DE=$(VIDEO_DIRECT_ACCESS_DE)

########## configure KEY_PARAMETER_GET ##########
LOCAL_CFLAGS += -DKEY_PARAMETER_GET=$(KEY_PARAMETER_GET)

########## configure DISPLAY_CMD_SETVIDEOSIZE_POSITION ##########
LOCAL_CFLAGS += -DDISPLAY_CMD_SETVIDEOSIZE_POSITION=$(DISPLAY_CMD_SETVIDEOSIZE_POSITION)

########## configure DEINTERLACE_IOWR ##########
LOCAL_CFLAGS += -DDEINTERLACE_IOWR=$(DEINTERLACE_IOWR)

########## configure DEINTERLACE_FORMAT ##########
LOCAL_CFLAGS += -DDEINTERLACE_FORMAT=$(DEINTERLACE_FORMAT)

########## configure NEW_DISPLAY_DOUBLE_STREAM_NEED_NV21 ##########
LOCAL_CFLAGS += -DNEW_DISPLAY_DOUBLE_STREAM_NEED_NV21=$(NEW_DISPLAY_DOUBLE_STREAM_NEED_NV21)

########## configure OUTPUT_PIXEL_FORMAT ##########
LOCAL_CFLAGS += -DOUTPUT_PIXEL_FORMAT=$(OUTPUT_PIXEL_FORMAT)

########## configure USE_NEW_DISPLAY_GPU_ALIGN_STRIDE ##########
ifeq ($(USE_NEW_DISPLAY), 1)
    ifeq ($(CONFIG_TARGET_PRODUCT), octopus)
        USE_NEW_DISPLAY_GPU_ALIGN_STRIDE = $(GPU_ALIGN_STRIDE_32)
    else ifeq ($(GPU_TYPE_MALI), 1)
        USE_NEW_DISPLAY_GPU_ALIGN_STRIDE = $(GPU_ALIGN_STRIDE_32)
    else
        USE_NEW_DISPLAY_GPU_ALIGN_STRIDE = $(GPU_ALIGN_STRIDE_16)
    endif
LOCAL_CFLAGS += -DUSE_NEW_DISPLAY_GPU_ALIGN_STRIDE=$(USE_NEW_DISPLAY_GPU_ALIGN_STRIDE)
endif


########## configure NOT_DROP_FRAME ##########
LOCAL_CFLAGS += -DNOT_DROP_FRAME=$(NOT_DROP_FRAME)

########## configure SOUND_DEVICE_SET_RAW_FLAG ##########
LOCAL_CFLAGS += -DSOUND_DEVICE_SET_RAW_FLAG=$(SOUND_DEVICE_SET_RAW_FLAG)

########## configure NATIVE_WIN_DISPLAY_CMD_GETDISPFPS ##########
LOCAL_CFLAGS += -DNATIVE_WIN_DISPLAY_CMD_GETDISPFPS=$(NATIVE_WIN_DISPLAY_CMD_GETDISPFPS)

########## configure IMG_NV21_4K_ALIGN ##########
LOCAL_CFLAGS += -DIMG_NV21_4K_ALIGN=$(IMG_NV21_4K_ALIGN)

########## configure DEINTERLACE_ADDR_64 ##########
LOCAL_CFLAGS += -DDEINTERLACE_ADDR_64=$(DEINTERLACE_ADDR_64)

###################################end define####################################
