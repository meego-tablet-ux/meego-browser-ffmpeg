
# build ffmpeg plugin independently , and install to meego-browser 
#----------------------------------------------------------
# usage : 
#       [build]: make -f ffmpeg_build.mk
#       [debug]: make -f ffmpeg_build.mk V=
#       [clean]: make clean -f ffmpeg_build.mk
#       [install]: make install -f ffmpeg_build.mk
#----------------------------------------------------------

#----------------------------------------------------------
# debug flags
#----------------------------------------------------------
V?=@
DESTDIR?=

#----------------------------------------------------------
# toolchain 
#----------------------------------------------------------
CC=cc
LN=g++
ASM=yasm
PKG=libffmpegsumo.so
INSTALL=$(DESTDIR)/usr/lib/meego-app-browser/.

#FIXME: 3rd part dependency, pls update before your building.
VPXPATH=../libvpx


# compiler flags
#----------------------------------------------------------
INC_DEPS:= \
	-I./config/Chromium/linux/ia32 \
	-I./patched-ffmpeg-mt \
	-I./patched-ffmpeg-mt/libavcodec/x86/ \
	-I./config \
	-I$(VPXPATH)/include
     

#DEFS  := \
	'-DNO_HEAPCHECKER' \
	'-DCHROMIUM_BUILD' \
	'-DOS_MEEGO=1' \
	'-DTOOLKIT_MEEGOTOUCH=1' \
	'-DENABLE_REMOTING=1' \
	'-DENABLE_GPU=1' \
	'-DENABLE_EGLIMAGE=1' \
	'-D__STDC_CONSTANT_MACROS' \
	'-DNDEBUG' \
	'-DNVALGRIND' \
	'-DDYNAMIC_ANNOTATIONS_ENABLED=0'


DEFS  := \
       '-DNO_HEAPCHECKER' \
        '-DCHROMIUM_BUILD' \
        '-DOS_MEEGO=1' \
        '-DTOOLKIT_MEEGOTOUCH=1' \
        '-DENABLE_REMOTING=1' \
        '-DENABLE_GPU=1' \
        '-DHAVE_AV_CONFIG_H' \
        '-D_POSIX_C_SOURCE=200112' \
        '-D_ISOC99_SOURCE' \
        '-D_LARGEFILE_SOURCE' \
        '-DNDEBUG' \
        '-DNVALGRIND' \
        '-DDYNAMIC_ANNOTATIONS_ENABLED=0'

CFLAGS  :=  \
	-pthread \
	-fno-exceptions \
	-Wno-unused-parameter \
	-Wno-missing-field-initializers \
	-D_FILE_OFFSET_BITS=64 \
	-pipe \
	-m32 \
	-mmmx \
	-march=pentium4 \
	-msse2 \
	-mfpmath=sse \
	-fno-strict-aliasing \
	-Wno-deprecated \
	-Wno-format \
	-O2 \
	-fno-ident \
	-fdata-sections \
	-ffunction-sections \
	-g \
        -fomit-frame-pointer \
        -std=c99 \
        -fno-math-errno \
	$(DEFS) \
	$(INC_DEPS) 


CXXFLAGS = $(CFLAGS)

ASMFLAGS := \
	-f elf -DARCH_X86_32 -m x86 

LDFLAGS := -pthread \
	-Wl,-z,noexecstack \
	-m32 \
        -Wl,-Bsymbolic \
	-L$(VPXPATH)/lib/linux/ia32 \
	-Wl,-O1 \
	-Wl,--gc-sections \
	-Wl,-soname=$(PKG)

	#-Wl,--as-needed \

#----------------------------------------------------------
# lib deps, and files
#----------------------------------------------------------
LIB_C = \
    ./patched-ffmpeg-mt/libavcodec/allcodecs.c \
	./patched-ffmpeg-mt/libavcodec/audioconvert.c \
	./patched-ffmpeg-mt/libavcodec/avpacket.c \
	./patched-ffmpeg-mt/libavcodec/bitstream.c \
	./patched-ffmpeg-mt/libavcodec/bitstream_filter.c \
	./patched-ffmpeg-mt/libavcodec/dsputil.c \
	./patched-ffmpeg-mt/libavcodec/faandct.c \
	./patched-ffmpeg-mt/libavcodec/faanidct.c \
	./patched-ffmpeg-mt/libavcodec/fft.c \
	./patched-ffmpeg-mt/libavcodec/golomb.c \
	./patched-ffmpeg-mt/libavcodec/imgconvert.c \
	./patched-ffmpeg-mt/libavcodec/jfdctfst.c \
	./patched-ffmpeg-mt/libavcodec/jfdctint.c \
	./patched-ffmpeg-mt/libavcodec/jrevdct.c \
	./patched-ffmpeg-mt/libavcodec/mdct.c \
	./patched-ffmpeg-mt/libavcodec/mpeg4audio.c \
	./patched-ffmpeg-mt/libavcodec/opt.c \
	./patched-ffmpeg-mt/libavcodec/options.c \
	./patched-ffmpeg-mt/libavcodec/parser.c \
	./patched-ffmpeg-mt/libavcodec/pcm.c \
	./patched-ffmpeg-mt/libavcodec/pthread.c \
	./patched-ffmpeg-mt/libavcodec/raw.c \
	./patched-ffmpeg-mt/libavcodec/simple_idct.c \
	./patched-ffmpeg-mt/libavcodec/utils.c \
	./patched-ffmpeg-mt/libavcodec/vorbis.c \
	./patched-ffmpeg-mt/libavcodec/vorbis_data.c \
	./patched-ffmpeg-mt/libavcodec/vorbis_dec.c \
	./patched-ffmpeg-mt/libavcodec/vp3.c \
	./patched-ffmpeg-mt/libavcodec/vp3dsp.c \
	./patched-ffmpeg-mt/libavcodec/xiph.c \
	./patched-ffmpeg-mt/libavcore/imgutils.c \
	./patched-ffmpeg-mt/libavcore/parseutils.c \
	./patched-ffmpeg-mt/libavcore/samplefmt.c \
	./patched-ffmpeg-mt/libavformat/allformats.c \
	./patched-ffmpeg-mt/libavformat/avio.c \
	./patched-ffmpeg-mt/libavformat/aviobuf.c \
	./patched-ffmpeg-mt/libavformat/cutils.c \
        ./patched-ffmpeg-mt/libavformat/id3v1.c \
        ./patched-ffmpeg-mt/libavformat/id3v2.c \
	./patched-ffmpeg-mt/libavformat/isom.c \
	./patched-ffmpeg-mt/libavformat/matroska.c \
	./patched-ffmpeg-mt/libavformat/matroskadec.c \
	./patched-ffmpeg-mt/libavformat/metadata.c \
	./patched-ffmpeg-mt/libavformat/metadata_compat.c \
	./patched-ffmpeg-mt/libavformat/oggdec.c \
	./patched-ffmpeg-mt/libavformat/oggparseogm.c \
	./patched-ffmpeg-mt/libavformat/oggparseskeleton.c \
	./patched-ffmpeg-mt/libavformat/oggparsetheora.c \
	./patched-ffmpeg-mt/libavformat/oggparsevorbis.c \
	./patched-ffmpeg-mt/libavformat/options.c \
	./patched-ffmpeg-mt/libavformat/pcm.c \
	./patched-ffmpeg-mt/libavformat/riff.c \
	./patched-ffmpeg-mt/libavformat/utils.c \
	./patched-ffmpeg-mt/libavformat/vorbiscomment.c \
	./patched-ffmpeg-mt/libavformat/wav.c \
	./patched-ffmpeg-mt/libavutil/avstring.c \
	./patched-ffmpeg-mt/libavutil/base64.c \
	./patched-ffmpeg-mt/libavutil/cpu.c \
	./patched-ffmpeg-mt/libavutil/crc.c \
	./patched-ffmpeg-mt/libavutil/eval.c \
	./patched-ffmpeg-mt/libavutil/intfloat_readwrite.c \
	./patched-ffmpeg-mt/libavutil/inverse.c \
	./patched-ffmpeg-mt/libavutil/log.c \
	./patched-ffmpeg-mt/libavutil/lzo.c \
	./patched-ffmpeg-mt/libavutil/mathematics.c \
	./patched-ffmpeg-mt/libavutil/mem.c \
	./patched-ffmpeg-mt/libavutil/opt.c \
	./patched-ffmpeg-mt/libavutil/pixdesc.c \
	./patched-ffmpeg-mt/libavutil/rational.c \
	./patched-ffmpeg-mt/libavcodec/libvpxdec.c \
	./patched-ffmpeg-mt/libavcodec/libvpxenc.c \
	./patched-ffmpeg-mt/libavcodec/x86/dsputil_mmx.c \
	./patched-ffmpeg-mt/libavcodec/x86/dsputilenc_mmx.c \
	./patched-ffmpeg-mt/libavcodec/x86/fdct_mmx.c \
	./patched-ffmpeg-mt/libavcodec/x86/fft.c \
	./patched-ffmpeg-mt/libavcodec/x86/fft_sse.c \
	./patched-ffmpeg-mt/libavcodec/x86/idct_mmx_xvid.c \
	./patched-ffmpeg-mt/libavcodec/x86/idct_sse2_xvid.c \
	./patched-ffmpeg-mt/libavcodec/x86/motion_est_mmx.c \
	./patched-ffmpeg-mt/libavcodec/x86/simple_idct_mmx.c \
	./patched-ffmpeg-mt/libavutil/x86/cpu.c \
	$(LIB_H264_AAC)

LIB_ASM= \
	./patched-ffmpeg-mt/libavcodec/x86/deinterlace.asm \
	./patched-ffmpeg-mt/libavcodec/x86/dsputil_yasm.asm \
	./patched-ffmpeg-mt/libavcodec/x86/dsputilenc_yasm.asm \
	./patched-ffmpeg-mt/libavcodec/x86/fft_mmx.asm \
	./patched-ffmpeg-mt/libavcodec/x86/vp3dsp.asm \
	$(LIB_ASM_H264)

	#./patched-ffmpeg-mt/libavcodec/x86/x86util.asm
	#./patched-ffmpeg-mt/libavcodec/x86/x86inc.asm
	#./patched-ffmpeg-mt/libavcodec/x86/vp8dsp.asm

LIB_ASM_H264=\


LIB_H264_AAC=\


LIB_LIBS = -lpthread \
           -lz \
	   -lvpx \

LIB_OBJ=$(LIB_C:%.c=%.o)
LIB_D=$(LIB_C:%.c=%.d)
LIB_OBJ_ASM=$(LIB_ASM:%.asm=%.o)

%.o: %.c ffmpeg_build.mk
	$(V)echo "Building $<"
	$(V)$(CC) $(CFLAGS) -c $< -o $@ 2>>build.log

%.d: %.c ffmpeg_build.mk
	$(V)$(CC) $(CFLAGS) -MMD -MF $(LIB_D) -c $< 

%.o: %.asm ffmpeg_build.mk
	$(V)echo "Building ASM $<"
	$(V)$(ASM) $(ASMFLAGS) $< -o $@ 2>>build.log

#----------------------------------------------------------
# build targets
#----------------------------------------------------------

.PHONY: all 
all : dep $(PKG) 

dep: 
	$(V)rm -f build.log

$(PKG): $(LIB_OBJ) $(LIB_OBJ_ASM) 
	$(V)$(LN) $(LDFLAGS) -shared -o $@   -Wl,--start-group  $(LIB_OBJ) $(LIB_OBJ_ASM) -Wl,--end-group $(LIB_LIBS) 
	$(V)if [ -e $(PKG) ] ; then echo ; echo "    [Build $(PKG) Successfully!! Log Is : build.log]"; echo ; fi;
clean :
	$(V)rm -f build.log $(LIB_OBJ) $(LIB_OBJ_ASM) $(LIB_D) $(PKG)
	$(V)if [ -n $(PKG) ] ; then echo ; echo "    [Clean $(PKG) Successfully!!]"; echo ;fi;

install : 
	$(V)echo "    [Installing to $(INSTALL)]"
	$(V)cp $(PKG) $(INSTALL)
