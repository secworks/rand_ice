#===================================================================
#
# Makefile
# --------
# Makefile for building, simlating and programming the the rand_ice
# core. Note that the target device is a Lattice iCEstick
# Evaluation Kit (part number ICE40HX1K-STICK-EVN). The device
# sports an iCE40HX-1k device.
# https://www.latticesemi.com/icestick
#
# The tools required are:
# Icarus Verilog for simulation
# Verilator for linting
# IceStorm for bitstream generation and FPGA configuration.
#
#
# Author: Joachim Strombergson
# Copyright (c) 2019, NORDUnet A/S
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# - Redistributions of source code must retain the above copyright notice,
#   this list of conditions and the following disclaimer.
#
# - Redistributions in binary form must reproduce the above copyright
#   notice, this list of conditions and the following disclaimer in the
#   documentation and/or other materials provided with the distribution.
#
# - Neither the name of the NORDUnet nor the names of its contributors may
#   be used to endorse or promote products derived from this software
#   without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
# PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
# TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#===================================================================

# Project defines
PROJ      = rand_ice
BUILD     = ./build
DEVICE    = 1k
FOOTPRINT = tq144

TOP_NAME = rand_ice
TOP_SRC = ../src/rtl/rand_ice.v

CONFIG_SRC = ../src/config/pinmap_icestick.pcf

CC = iverilog
CC_FLAGS = -Wall

LINT = verilator
LINT_FLAGS = +1364-2001ext+ --lint-only  -Wall -Wno-fatal -Wno-DECLFILENAME


.PHONY: all bitstream burn


all:


lint:  $(TOP_SRC) $(SPI_SRC)
	$(LINT) $(LINT_FLAGS) $(TOP_SRC) $(SPI_SRC)


bitstream: $(TOP_SRC) $(SPI_SRC)
	mkdir -p $(BUILD)
	yosys -p "synth_ice40 -top $(TOP_NAME) -blif $(BUILD)/$(PROJ).blif" $(TOP_SRC)
	arachne-pnr -d $(DEVICE) -P $(FOOTPRINT) -o $(BUILD)/$(PROJ).asc -p $(CONFIG_SRC) $(BUILD)/$(PROJ).blif
	icepack $(BUILD)/$(PROJ).asc $(BUILD)/$(PROJ).bin


burn:
	iceprog $(BUILD)/$(PROJ).bin


clean:
	rm -f *.sim
	rm -rf build


help:
	@echo "Build system for simulation of AES Verilog core"
	@echo ""
	@echo "Supported targets:"
	@echo "------------------"
	@echo "all:       Build all simulation targets."
	@echo "lint:      Lint all rtl source files."
	@echo "bitstream: Generate FPGA bitstream."
	@echo "burn:      Write bitstream to FPGA config mem.."
	@echo "clean:     Delete all built files and directories."

#===================================================================
# EOF Makefile
#===================================================================
