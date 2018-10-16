#!/bin/bash

# Comments here for later

. "$HELLO_IT_SCRIPT_SH_LIBRARY/com.github.ygini.hello-it.scriptlib.sh"

function onClickAction {
    /usr/local/bin/mirror -t
    setTitleAction "$@"
}

function fromCronAction {
    noOfMonitors=$(system_profiler SPDisplaysDataType | grep -c Resolution)
    if [ $noOfMonitors != 1 ]; then
        setHidden "NO"
    else
        setHidden "YES"
    fi
    setTitleAction "$@"
}

function setTitleAction {
    mirrorState=mirror -q
    if [ $mirroredMonitors="off" ]; then
        updateTitle "Mirror Desktop"
    else
        updateTitle "Extend Desktop"
    fi
}

main $@

exit 0