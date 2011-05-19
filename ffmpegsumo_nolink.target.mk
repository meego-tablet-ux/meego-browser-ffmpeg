# This file is generated by gyp; do not edit.

TOOLSET := target
TARGET := ffmpegsumo_nolink
### Generated for copy rule.
$(builddir)/libffmpegsumo.so: TOOLSET := $(TOOLSET)
$(builddir)/libffmpegsumo.so: $(builddir)/lib.$(TOOLSET)/libffmpegsumo.so FORCE_DO_CMD
	$(call do_cmd,copy)

all_deps += $(builddir)/libffmpegsumo.so
ffmpegsumo_nolink_copies = $(builddir)/libffmpegsumo.so

DEFS_Debug := '-DNO_HEAPCHECKER' \
	'-DCHROMIUM_BUILD' \
	'-DOS_MEEGO=1' \
	'-DTOOLKIT_MEEGOTOUCH=1' \
	'-DENABLE_REMOTING=1' \
	'-DENABLE_GPU=1' \
	'-DENABLE_EGLIMAGE=1' \
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

INCS_Debug := 

DEFS_Release := '-DNO_HEAPCHECKER' \
	'-DCHROMIUM_BUILD' \
	'-DOS_MEEGO=1' \
	'-DTOOLKIT_MEEGOTOUCH=1' \
	'-DENABLE_REMOTING=1' \
	'-DENABLE_GPU=1' \
	'-DENABLE_EGLIMAGE=1' \
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

INCS_Release := 

OBJS := $(obj).target/$(TARGET)/third_party/ffmpeg/dummy_nolink.o

# Add to the list of files we specially track dependencies for.
all_deps += $(OBJS)

# Make sure our dependencies are built before any of us.
$(OBJS): | $(builddir)/lib.target/libffmpegsumo.so $(obj).target/third_party/ffmpeg/libffmpegsumo.so $(obj).target/third_party/libvpx/libvpx.a

# Make sure our actions/rules run before any of us.
$(OBJS): | $(ffmpegsumo_nolink_copies)

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
$(builddir)/ffmpegsumo_nolink: | $(ffmpegsumo_nolink_copies)

# Preserve order dependency of special output on deps.
$(ffmpegsumo_nolink_copies): | $(builddir)/lib.target/libffmpegsumo.so $(obj).target/third_party/ffmpeg/libffmpegsumo.so $(obj).target/third_party/libvpx/libvpx.a

LDFLAGS_Debug := -pthread \
	-Wl,-z,noexecstack \
	-m32 \
	-Wl,-Bsymbolic \
	-L$(obj)/gen/third_party/ffmpeg

LDFLAGS_Release := -pthread \
	-Wl,-z,noexecstack \
	-m32 \
	-Wl,-Bsymbolic \
	-L$(obj)/gen/third_party/ffmpeg \
	-Wl,-O1 \
	-Wl,--gc-sections

LIBS := -lz

$(builddir)/ffmpegsumo_nolink: GYP_LDFLAGS := $(LDFLAGS_$(BUILDTYPE))
$(builddir)/ffmpegsumo_nolink: LIBS := $(LIBS)
$(builddir)/ffmpegsumo_nolink: TOOLSET := $(TOOLSET)
$(builddir)/ffmpegsumo_nolink: $(OBJS) $(obj).target/third_party/ffmpeg/libffmpegsumo.so $(obj).target/third_party/libvpx/libvpx.a FORCE_DO_CMD
	$(call do_cmd,link)

all_deps += $(builddir)/ffmpegsumo_nolink
# Add target alias
.PHONY: ffmpegsumo_nolink
ffmpegsumo_nolink: $(builddir)/ffmpegsumo_nolink

# Add executable to "all" target.
.PHONY: all
all: $(builddir)/ffmpegsumo_nolink

