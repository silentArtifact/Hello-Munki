#!/bin/bash

osascript <<'END'
set theFile to (("/Volumes/folders") as text)
set status to false as boolean

tell application "Finder" to if exists theFile then set status to true
if status is true then
	tell application "Finder" to open ("/Volumes/folders/" as POSIX file)
else
	mount volume "smb://cfafiles01.ad.ilstu.edu/folders"
	tell application "Finder" to open ("/Volumes/folders/" as POSIX file)
end if
END
exit 0