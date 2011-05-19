#################################################################################
#                 Use for ffmpeg clean 
#
#################################################################################

include assemble_ffmpeg_asm.target.mk
file := $(OBJS) 
include ffmpegsumo_nolink.target.mk
file += $(OBJS)
include ffmpegsumo.target.mk
file += $(OBJS) 
include ffmpeg.target.mk
file += $(OBJS) 
include make_ffmpeg_asm_lib.target.mk
file += $(OBJS) 

c_file = $(notdir $(file:%.o=%.c))
c_file_1 = $(file:%.o=%.c)


dest=ffmpeg_clean
dest1=libavcodec libavcore libavformat libavutil

define Delete
cd $(dest)/patched-ffmpeg-mt ; find $(1) -name '*.c' | xargs rm -f  ;cd -
endef

base: 
	@echo ""
	@echo -------------------------FFMPEG Clean For HTML5 Video ----------------------------
	@echo create base folder \"$(dest)/\"
	@mkdir -p $(dest)
	@mkdir -p $(dest)/patched-ffmpeg-mt
	@echo setup base copy
	@$(foreach j, $(dest1), cp -fr patched-ffmpeg-mt/$(j) $(dest)/patched-ffmpeg-mt/.;) 
	$(call Delete, $(dest1))
    

DoWork= mkdir -p $(dir $(dest)/$(1)) ; cp $(1) $(dest)/$(1)

copy:
	-$(foreach i, $(c_file_1), $(call DoWork,$(shell echo $i | sed -e "s/.*\/ffmpeg\///g")) ;)

append:
	@echo appending..
	cp ./patched-ffmpeg-mt/libavcodec/aacpsdata.c $(dest)/patched-ffmpeg-mt/libavcodec/aacpsdata.c
	cp ./patched-ffmpeg-mt/libavcodec/dct32.c $(dest)/patched-ffmpeg-mt/libavcodec/dct32.c
	cp ./patched-ffmpeg-mt/libavcodec/x86/dsputil_mmx_rnd_template.c $(dest)/patched-ffmpeg-mt/libavcodec/x86/dsputil_mmx_rnd_template.c
	cp ./patched-ffmpeg-mt/libavcodec/x86/dsputil_mmx_avg_template.c $(dest)/patched-ffmpeg-mt/libavcodec/x86/dsputil_mmx_avg_template.c
	cp ./patched-ffmpeg-mt/libavcodec/x86/dsputil_mmx_qns_template.c $(dest)/patched-ffmpeg-mt/libavcodec/x86/dsputil_mmx_qns_template.c
	cp ./patched-ffmpeg-mt/libavcodec/x86/h264_qpel_mmx.c $(dest)/patched-ffmpeg-mt/libavcodec/x86/h264_qpel_mmx.c
	cp ./patched-ffmpeg-mt/libavcodec/x86/mpegvideo_mmx_template.c $(dest)/patched-ffmpeg-mt/libavcodec/x86/mpegvideo_mmx_template.c


iso: base copy append
	@echo clean patched ffmpeg mt version
	@echo -------------------------FFMPEG Clean For HTML5 Video ----------------------------
    




#$(foreach i, $(c_file_1), echo "file is $i "; $(call DoWork,$(shell echo $i | sed -e "s/.*\/ffmpeg\///g")) ;echo "" )
#DoWork=echo folder is $(dir $(dest)/$(1)) ;mkdir -p $(dir $(dest)/$(1) ); cp $(1) $(dest)/$(1)

#################################################################################
#             Version: 2010.11.24.
#             log: 
#                 1. only 4 folders , filterred *.c based on .mk, but all *.h
#                 2. add appending *.c which included in .c file.
#################################################################################

