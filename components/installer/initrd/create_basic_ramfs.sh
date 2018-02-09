#!/bin/bash 

set -o errexit
set -o nounset 
set -o pipefail

source ../../config/default.conf  

# Initialize target
TARGET="${INITRD_IN}/initrd"
[[ -d $TARGET ]] && rm -rf $TARGET
mkdir $TARGET

# Create filesystem structure
mkdir -p ${TARGET}/{dev,dev,etc,lib,lib64,mnt/root,proc,root,sbin,sys}
cp -a /dev/{null,console,tty,sda1} ${TARGET}/dev 

# Add utilities 

exit 0
