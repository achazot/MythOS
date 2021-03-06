#!/bin/bash

# TODO: source common functions

# Get the script absolute path
OWN_DIR=$(dirname "$(readlink -f "$0")")
REL_CONF_PATH="../config/default.conf"

if [ ! -f "$OWN_DIR/$REL_CONF_PATH" ]; then
    printf "Missing config file $OWN_DIR/$REL_CONF_PATH, aborting.\n"
    exit 1
fi

# Read configuration variables
# No, I won't check for malicious code here
source "$OWN_DIR/$REL_CONF_PATH"




# TODO: write usage
usage ()
{
    cat <<-EOF
    build.sh -- Generate an iso
    Usage:
        ./build.sh
EOF
}


main ()
{
    # Copy installer system
    mkdir -p "$ISOLINUX_OUT"
    cp "$ISOLINUX_IN/"* "$ISOLINUX_OUT/"
    mkdir -p "$INSTALL_OUT"
    cp "$KERNEL_IN/vmlinuz" "$INSTALL_OUT/"
    cp "$INITRD_IN/initrd.gz" "$INSTALL_OUT/"

    # Create iso from iso_root
    genisoimage -v -J -r -l \
        -V "${ISO_NAME}" \
        -b "isolinux/isolinux.bin" \
        -no-emul-boot -boot-load-size 4 -boot-info-table \
        -c "isolinux/boot.cat" \
        -o "${OUTPUT}/${ISO_FILE}" \
           "${ISO_ROOT}"
}



main $@
exit 0
