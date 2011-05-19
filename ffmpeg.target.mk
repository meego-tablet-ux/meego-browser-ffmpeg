# This file is generated by gyp; do not edit.

TOOLSET := target
TARGET := ffmpeg
### Rules for action "generate_stubs":
quiet_cmd_ffmpeg_generate_stubs = ACTION Generating FFmpeg stubs for dynamic loading. $@
cmd_ffmpeg_generate_stubs = export LD_LIBRARY_PATH=$(builddir)/lib.host:$(builddir)/lib.target:$$LD_LIBRARY_PATH; cd third_party/ffmpeg; mkdir -p $(obj).$(TOOLSET)/geni $(obj)/gen/ffmpeg/third_party/ffmpeg; python ../../tools/generate_stubs/generate_stubs.py -i "$(obj).$(TOOLSET)/geni" -o "$(obj)/gen/ffmpeg/third_party/ffmpeg" -t posix_stubs -e ffmpeg_stub_headers.fragment -s ffmpeg_stubs -p third_party/ffmpeg avutil-50.sigs avcodec-52.sigs avformat-52.sigs

$(obj).$(TOOLSET)/geni/ffmpeg_stubs.cc: obj := $(abs_obj)

$(obj).$(TOOLSET)/geni/ffmpeg_stubs.cc: builddir := $(abs_builddir)

$(obj).$(TOOLSET)/geni/ffmpeg_stubs.cc: TOOLSET := $(TOOLSET)
$(obj).$(TOOLSET)/geni/ffmpeg_stubs.cc: tools/generate_stubs/generate_stubs.py third_party/ffmpeg/ffmpeg_stub_headers.fragment third_party/ffmpeg/avutil-50.sigs third_party/ffmpeg/avcodec-52.sigs third_party/ffmpeg/avformat-52.sigs FORCE_DO_CMD
	$(call do_cmd,ffmpeg_generate_stubs)
$(obj)/gen/ffmpeg/third_party/ffmpeg/ffmpeg_stubs.h: $(obj).$(TOOLSET)/geni/ffmpeg_stubs.cc
$(obj)/gen/ffmpeg/third_party/ffmpeg/ffmpeg_stubs.h: ;

all_deps += $(obj).$(TOOLSET)/geni/ffmpeg_stubs.cc $(obj)/gen/ffmpeg/third_party/ffmpeg/ffmpeg_stubs.h
action_ffmpeg_generate_stubs_outputs := $(obj).$(TOOLSET)/geni/ffmpeg_stubs.cc $(obj)/gen/ffmpeg/third_party/ffmpeg/ffmpeg_stubs.h


DEFS_Debug := '-DNO_HEAPCHECKER' \
	'-DCHROMIUM_BUILD' \
	'-DOS_MEEGO=1' \
	'-DTOOLKIT_MEEGOTOUCH=1' \
	'-DENABLE_REMOTING=1' \
	'-DENABLE_GPU=1' \
	'-DENABLE_EGLIMAGE=1' \
	'-D__STDC_CONSTANT_MACROS' \
	'-DDYNAMIC_ANNOTATIONS_ENABLED=1' \
	'-D_DEBUG'

# Flags passed to both C and C++ files.
CFLAGS_Debug :=  \
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
	-g

# Flags passed to only C (and not C++) files.
CFLAGS_C_Debug := 

# Flags passed to only C++ (and not C) files.
CFLAGS_CC_Debug := -fno-threadsafe-statics \
	-fvisibility-inlines-hidden

INCS_Debug := -I$(obj)/gen/ffmpeg \
	-I. \
	-Ithird_party/libvpx/include \
	-Ithird_party/ffmpeg/config \
	-Ithird_party/ffmpeg/patched-ffmpeg-mt

DEFS_Release := '-DNO_HEAPCHECKER' \
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

# Flags passed to both C and C++ files.
CFLAGS_Release :=  \
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
	-g

# Flags passed to only C (and not C++) files.
CFLAGS_C_Release := 

# Flags passed to only C++ (and not C) files.
CFLAGS_CC_Release := -fno-threadsafe-statics \
	-fvisibility-inlines-hidden

INCS_Release := -I$(obj)/gen/ffmpeg \
	-I. \
	-Ithird_party/libvpx/include \
	-Ithird_party/ffmpeg/config \
	-Ithird_party/ffmpeg/patched-ffmpeg-mt

OBJS := $(obj).$(TOOLSET)/geni/ffmpeg_stubs.o

# Add to the list of files we specially track dependencies for.
all_deps += $(OBJS)

# Make sure our dependencies are built before any of us.
$(OBJS): | $(builddir)/ffmpegsumo_nolink

# Make sure our actions/rules run before any of us.
$(OBJS): | $(action_ffmpeg_generate_stubs_outputs)

# CFLAGS et al overrides must be target-local.
# See "Target-specific Variable Values" in the GNU Make manual.
$(OBJS): TOOLSET := $(TOOLSET)
$(OBJS): GYP_CFLAGS := $(DEFS_$(BUILDTYPE)) $(INCS_$(BUILDTYPE)) $(CFLAGS_$(BUILDTYPE)) $(CFLAGS_C_$(BUILDTYPE))
$(OBJS): GYP_CXXFLAGS := $(DEFS_$(BUILDTYPE)) $(INCS_$(BUILDTYPE)) $(CFLAGS_$(BUILDTYPE)) $(CFLAGS_CC_$(BUILDTYPE))

# Suffix rules, putting all outputs into $(obj).

$(obj).$(TOOLSET)/$(TARGET)/%.o: $(srcdir)/%.cc FORCE_DO_CMD
	@$(call do_cmd,cxx,1)

# Try building from generated source, too.

$(obj).$(TOOLSET)/$(TARGET)/%.o: $(obj).$(TOOLSET)/%.cc FORCE_DO_CMD
	@$(call do_cmd,cxx,1)

$(obj).$(TOOLSET)/$(TARGET)/%.o: $(obj)/%.cc FORCE_DO_CMD
	@$(call do_cmd,cxx,1)

# End of this set of suffix rules
### Rules for final target.
# Build our special outputs first.
$(obj).target/third_party/ffmpeg/libffmpeg.so: | $(action_ffmpeg_generate_stubs_outputs)

# Preserve order dependency of special output on deps.
$(action_ffmpeg_generate_stubs_outputs): | $(builddir)/ffmpegsumo_nolink

LDFLAGS_Debug := -pthread \
	-Wl,-z,noexecstack \
	-m32

LDFLAGS_Release := -pthread \
	-Wl,-z,noexecstack \
	-m32 \
	-Wl,-O1 \
	-Wl,--gc-sections

LIBS := -ldl

$(obj).target/third_party/ffmpeg/libffmpeg.so: GYP_LDFLAGS := $(LDFLAGS_$(BUILDTYPE))
$(obj).target/third_party/ffmpeg/libffmpeg.so: LIBS := $(LIBS)
$(obj).target/third_party/ffmpeg/libffmpeg.so: TOOLSET := $(TOOLSET)
$(obj).target/third_party/ffmpeg/libffmpeg.so: $(OBJS) FORCE_DO_CMD
	$(call do_cmd,solink)

all_deps += $(obj).target/third_party/ffmpeg/libffmpeg.so
# Add target alias
.PHONY: ffmpeg
ffmpeg: $(builddir)/lib.target/libffmpeg.so

# Copy this to the shared library output path.
$(builddir)/lib.target/libffmpeg.so: TOOLSET := $(TOOLSET)
$(builddir)/lib.target/libffmpeg.so: $(obj).target/third_party/ffmpeg/libffmpeg.so FORCE_DO_CMD
	$(call do_cmd,copy)

all_deps += $(builddir)/lib.target/libffmpeg.so
# Short alias for building this shared library.
.PHONY: libffmpeg.so
libffmpeg.so: $(obj).target/third_party/ffmpeg/libffmpeg.so $(builddir)/lib.target/libffmpeg.so

# Add shared library to "all" target.
.PHONY: all
all: $(builddir)/lib.target/libffmpeg.so
