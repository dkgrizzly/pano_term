###############################################################################
## Makefile
###############################################################################
include ../project.mk

INCLUDE_ETHERNET ?= y

SRC_DIR       = .
SRC_DIR      += $(CORES_DIR)/core_soc/src_v
SRC_DIR      += $(CORES_DIR)/dbg_bridge/src_v
SRC_DIR      += $(CORES_DIR)/cpu/riscv/core/riscv
SRC_DIR      += $(CORES_DIR)/cpu/riscv/top_tcm_wrapper
SRC_DIR      += $(CORES_DIR)/0xArt_I2C/rtl
SRC_DIR      += $(CORES_DIR)/dvi/src_v
#SRC_DIR      += $(CORES_DIR)/axi65/src_v
#SRC_DIR      += $(CORES_DIR)/crossbar/src_v

ifeq ($(INCLUDE_ETHERNET),y)
SRC_DIR      += $(CORES_DIR)/ethernet_mac
SRC_DIR      += $(CORES_DIR)/ethernet_mac/xilinx
SRC_DIR      += $(CORES_DIR)/ethernet_mac/xilinx/ipcore_dir
SRC_DIR      += $(PANO_CORES_DIR)/g2/ethernet_mac
SRC_DIR      += $(PANO_CORES_DIR)/g2/multiboot
EXCLUDE_SRC  += $(CORES_DIR)/ethernet_mac/ethernet_mac_tb.vhd
EXTRA_VFLAGS += INCLUDE_ETHERNET=1
else
EXCLUDE_SRC += $(abspath ./eth_axi4lite.v)
endif

EXCLUDE_SRC  += $(CORES_DIR)/core_soc/src_v/core_soc.v
EXCLUDE_SRC  += $(CORES_DIR)/core_soc/src_v/gpio.v
EXCLUDE_SRC  += $(CORES_DIR)/core_soc/src_v/gpio_defs.v

BSCAN_SPI_DIR = $(PANO_CORES_DIR)/xc3sprog

#COMPRESS_BITFILE = yes
COMPRESS_BITFILE = no
INIT_IMAGE = ./firmware.mem

#MAP_CMDS = -w -intstyle ise -detail -ir off -ignore_keep_hierarchy -ol high

# NB: the -pr b option was removed from the default options, otherwise there 
# are timing errors
MAP_CMDS = -w -intstyle ise -detail -ir off -ignore_keep_hierarchy -timing -ol high -mt 2

# use 4 cores
PAR_CMDS = -w -intstyle ise -ol high  -mt 4

PATCHED_ETH_MAC = $(CORES_DIR)/ethernet_mac/.patched
PATCHED_CPU = $(CORES_DIR)/cpu/riscv/.patched

.PHONY: init_and_build
init_and_build: $(PATCHED_ETH_MAC) $(PATCHED_CPU) all

TOPDIR = ..
include $(TOPDIR)/pano/make/ise.mk

firmware.mem:
	make -C $(TOPDIR)/fw/pano_term init_image

debug:
	echo "INCLUDE_ETHERNET: $(INCLUDE_ETHERNET)"
	echo "SRC_DIR: $(SRC_DIR)"

remoteflash:
	sudo cp build/fpga.bin /srv/tftp/pa
	./flash.ex

