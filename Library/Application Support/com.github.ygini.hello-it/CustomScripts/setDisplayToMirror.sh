#!/bin/bash

# Comments here for later

. "$HELLO_IT_SCRIPT_SH_LIBRARY/com.github.ygini.hello-it.scriptlib.sh"

function onClickAction {
    /usr/local/bin/mirror -on
}

function setTitleAction {

    updateTitle "Mirror Desktop"

}

main $@

exit 0