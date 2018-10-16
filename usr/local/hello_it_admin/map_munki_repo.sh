#!/bin/bash

LOCALMOUNTPOINT="/Volumes/munki_repo"

if mount | grep "on $LOCALMOUNTPOINT" > /dev/null; then
    osascript -e 'tell application "Finder" to open ("/Volumes/munki_repo" as POSIX file)'
else
    osascript <<'END'
    set ULIDDialog to display dialog "Enter admin ULID:" default answer ""
    set ULID to text returned of ULIDDialog

    set PasswordDialog to display dialog "Enter admin account password" default answer "" with hidden answer
    set AdminPassword to text returned of PasswordDialog

    set connectionString to "smb://" & ULID & ":" & AdminPassword & "@CFADEPLOY.ad.ilstu.edu/munki_repo"
	mount volume connectionString
	tell application "Finder" to open ("/Volumes/munki_repo/" as POSIX file)
END
fi

exit 0