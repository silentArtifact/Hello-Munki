#!/bin/bash

# Get the manifest name from arguments
manifestName=$1

# For machine-specific manifests, the argument passed in will be HOSTNAME. 
# This code then sweeps that up and sets the manifest to the current
# $HOSTNAME
if [ "$manifestName" == "HOSTNAME" ]; then
    manifestName=`echo "$HOSTNAME" | cut -d'.' -f1`
fi

# For custom manifests, the argument passed in will be CUSTOM.
# This code then prompts the user for a custom manifest, parses it
# from the AppleScript return, and sets it to manifestName.
if [ "$manifestName" == "CUSTOM" ]; then
    manifestName="$(osascript -e 'display dialog "Enter custom manifest name:" default answer "basic_workstation"')"
    manifestName=$(echo $manifestName | sed 's/.*://')
fi

# Inform user of current manifest and manifest to be changed to, and confirm.
currentManifest="$(defaults read /Library/Preferences/ManagedInstalls.plist ClientIdentifier)"
SURETY="$(osascript -e 'display dialog "Change manifest from '$currentManifest' to '$manifestName'?" buttons {"Yes", "No"} default button "No" with icon caution')"
if [ "$SURETY" = "button returned:Yes" ]; then
	defaults write /Library/Preferences/ManagedInstalls SoftwareRepoURL "<your repo here>"
	defaults write /Library/Preferences/ManagedInstalls ClientIdentifier $manifestName
	defaults write /private/var/root/Library/Preferences/ManagedInstalls AdditionalHttpHeaders -array "<your authorization here>"

    # Ask if the user wants munki to run and install anything in the newly-
    # updated manifest.
    SURETY="$(osascript -e 'display dialog "Download and install from new manifest?" buttons {"Yes", "No"} default button "Yes" with icon caution')"
    if [ "$SURETY" = "button returned:Yes" ]; then
        /usr/bin/open /Applications/Managed\ Software\ Center.app
        /usr/bin/open /Applications/CFA\ App\ Store.app
        sudo /usr/local/munki/managedsoftwareupdate -q
        sudo /usr/local/munki/managedsoftwareupdate -q --installonly
    fi
fi

exit 0