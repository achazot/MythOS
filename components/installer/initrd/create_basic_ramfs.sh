#!/bin/bash 

# Resulting initramfs must be packaged as a compressed cpio archive 
# For embedded it directly in the kernel image set 
# CONFIG_INITIRAMFS_SOURCE=<path_to_initramfs> before compiling the kernel

set -o errexit
set -o nounset
set -o pipefail

source ../../../config/default.conf

# Initialize target
TARGET="${INITRD_IN}/initramfs"
[[ -d $TARGET ]] && rm -rf $TARGET
mkdir $TARGET

# Initramfs
mkdir -p ${TARGET}/{bin,dev,dev,etc,lib,lib64,mnt/root,proc,root,sbin,sys}
cp -a /dev/{null,console,tty,sda1} ${TARGET}/dev 

# Utilities 
cp -a ${REPOSITORY}/busybox ${TARGET}/bin/ 
cd ${REPOSITORY}/ 
ln -s busybox ${TARGET}/bin/ls 
ln -s busybox ${TARGET}/bin/mount 
ln -s busybox ${TARGET}/bin/echo
ln -s busybox ${TARGET}/bin/sleep
ln -s busybox ${TARGET}/bin/umount
ln -s busybox ${TARGET}/bin/sh
cd - 
 
# Init script 
cp -a  ${INITRD}/init ${TARGET}/

# CPIO archive 
cd ${TARGET} 
# TODO : create the cpio in ${INSTALL_OUT} 
find . -print0 | cpio --null -ov --format=newc | gzip -9 > ${INITRD_IN}/initrd.gz
cd -

exit 0
