#!/bin/bash
# Bash Color
green='\033[01;32m'
red='\033[01;31m'
blink_red='\033[05;31m'
restore='\033[0m'

# This is a cleanup and single run build script for testing purposes.
# This does not zip anything for you, only executes a normal build.

# Minimum requirements to build:
# cd /opt/Android
# mkdir toolchains && cd toolchains
# git clone https://gitlab.com/HDTC/gclang.git
# git clone https://bitbucket.org/xanaxdroid/aarch64-8.0.git
#
# In this script:
# You will need to change the 'Source Path to kernel tree' to match your current path to this source.
# You will need to change the 'Compile Path to out' to match your current path to this source.
# You will also need to edit the '-j32' under 'Start Compile' section and adjust that to match the amount of cores you want to use to build.
#
# In Makefile:
# You will need to edit the 'CROSS_COMPILE=' line to match your current path to this source.
#
############################################################
# Build Script Variables
############################################################

# Kernel version
        ver=1

# Toolchain location used to build
	CC_DIR=/root/Desktop/KERNEL/toolchains/gclang/bin/

# Source defconfig used to build
	##dc=nethunter_defconfig
	dc=nethunter_defconfig

# Source Path to kernel tree
	k=/root/Desktop/KERNEL/nethunter_kernel_development

# Compile Path to out
	o="O=/root/Desktop/KERNEL/nethunter_kernel_development/out"

# Source Path to clean(empty) out folder
	co=$k/out

# Destination path to modules
        zm=$k/out/lib/modules

# CPU threads
	th="-j$(grep -c ^processor /proc/cpuinfo)"

############################################################
# Cleanup
############################################################

	echo "	Cleaning up out directory"
	rm -Rf out/
	echo "	Out directory removed!"

############################################################
# Make out folder
############################################################

	echo "	Making new out directory"
	mkdir -p "$co"
	((ver = $ver -1))
	echo $ver > $co\/\.version
	echo "	Created new out directory"

############################################################
# Establish defconfig
############################################################

	echo "	Establishing build environment.."
	make "$o" REAL_CC=${CC_DIR}/clang CLANG_TRIPLE=aarch64-linux-gnu- DTC_EXT=/usr/bin/dtc "$dc" menuconfig
	#./scripts/config --file ./out/.config -e BUILD_ARM64_DT_OVERLAY

############################################################
# Start Compile
############################################################

	echo "	Starting first build.."
	make "$o" REAL_CC=${CC_DIR}/clang CLANG_TRIPLE=aarch64-linux-gnu- DTC_EXT=/usr/bin/dtc CONFIG_DEBUG_SECTION_MISMATCH=y $th
	#./scripts/config --file ./out/.config -e BUILD_ARM64_DT_OVERLAY
	make "$o" INSTALL_MOD_PATH="." INSTALL_MOD_STRIP=1 modules_install $th
	echo "	Build complete!"

