# Clang flags for arm arch, target or host.

CLANG_CONFIG_arm_EXTRA_ASFLAGS :=

CLANG_CONFIG_arm_EXTRA_CFLAGS :=

ifneq (,$(filter krait,$(TARGET_$(combo_2nd_arch_prefix)CPU_VARIANT)))
  # Android's clang support's krait as a CPU whereas GCC doesn't. Specify
  # -mcpu here rather than the more normal core/combo/arch/arm/armv7-a-neon.mk.
  CLANG_CONFIG_arm_EXTRA_CFLAGS += -mcpu=krait -mfpu=neon-vfpv4
endif

CLANG_CONFIG_arm_EXTRA_CPPFLAGS :=

CLANG_CONFIG_arm_EXTRA_LDFLAGS :=

# Include common unknown flags
CLANG_CONFIG_arm_UNKNOWN_CFLAGS := \
  $(CLANG_CONFIG_UNKNOWN_CFLAGS) \
  -mthumb-interwork \
  -fgcse-after-reload \
  -frerun-cse-after-loop \
  -frename-registers \
  -fno-align-jumps \
  -fno-builtin-sin \
  -fno-caller-saves \
  -fno-early-inlining \
  -fno-move-loop-invariants \
  -fno-partial-inlining \
  -fno-strict-volatile-bitfields \
  -fno-tree-copy-prop \
  -fno-tree-loop-optimize

define subst-clang-incompatible-arm-flags
  $(subst -march=armv5te,-march=armv5t,\
  $(subst -march=armv5e,-march=armv5,\
  $(subst -march=armv7ve,-march=armv7-a,\
  $(subst -mcpu=cortex-a15,-march=armv7-a,\
  $(subst -mcpu=cortex-a12.cortex-a7,-march=armv7-a,\
  $(subst -mcpu=cortex-a53,-mcpu=cortex-a7,\
  $(subst -mtune=cortex-a53,-mtune=cortex-a7,\
  $(1))))))))
endef
