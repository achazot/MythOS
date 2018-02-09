# Resulting initramfs must be packaged as a compressed cpio archive 
# For embedded it directly in the kernel image set 
# CONFIG_INITIRAMFS_SOURCE=<path_to_initramfs> before compiling the kernel 

#!/bin/bash 

set -o errexit
set -o nounset 
set -o pipefail

source ../../../config/default.conf  

# Initialize target
TARGET="${INITRD_IN}/initrd"
[[ -d $TARGET ]] && rm -rf $TARGET
mkdir $TARGET

# Initramfs
mkdir -p ${TARGET}/{bin,dev,dev,etc,lib,lib64,mnt/root,proc,root,sbin,sys}
cp -a /dev/{null,console,tty,sda1} ${TARGET}/dev 

# Utilities 
cp -a ${REPOSITORY}/busybox ${TARGET}/bin/ 

# Init script 
cp -a  ${INITRD}/init ${TARGET}/

exit 0
