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
    cp -ar "$ISOLINUX_IN" "$ISOLINUX_OUT"
    cp -ar "$KERNEL_IN" "$INSTALL_OUT"
    

}




main $@
exit 0
