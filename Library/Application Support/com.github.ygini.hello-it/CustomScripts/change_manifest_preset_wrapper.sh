#!/bin/bash

# Prerequisites: outset installed, sudoers.d file: '%everyone ALL=(ALL) NOPASSWD: /usr/local/hello-it/'
# script to create an outset script to wipe all keychains on a machine on next reboot, 
# then prompts the user to reboot.
# mdgrome 02/14/18

. "$HELLO_IT_SCRIPT_SH_LIBRARY/com.github.ygini.hello-it.scriptlib.sh"

function onClickAction {
    sudo /usr/local/hello_it_admin/change_manifest_preset.sh $1
}

main $@

exit 0