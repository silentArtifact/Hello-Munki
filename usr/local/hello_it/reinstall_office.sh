#!/bin/bash

# This application removes all files associated with Office 2016/365
# and causes Munki to forget them, then adds the bootstrap file, reboots,
# triggering Munki to re-download Office.

SURETY="$(osascript -e 'display dialog "Reinstall Microsoft Office? This will require a reboot, and will reset your signature and shared calendars. Any templates you may be using will be lost." buttons {"Yes", "No"} default button "No" with icon caution')"

if [ "$SURETY" = "button returned:Yes" ]; then
    osascript -e 'display notification "Uninstalling Office 2016..." with title "CFA-IT Update"'
    osascript -e 'quit app "Microsoft Excel"'
    osascript -e 'quit app "Microsoft OneNote"'
    osascript -e 'quit app "Microsoft Outlook"'
    osascript -e 'quit app "Microsoft PowerPoint"'
    osascript -e 'quit app "Microsoft Word"'

    rm -rif "/Applications/Microsoft Excel.app"
    rm -rif "/Applications/Microsoft OneNote.app"
    rm -rif "/Applications/Microsoft Outlook.app"
    rm -rif "/Applications/Microsoft PowerPoint.app"
    rm -rif "/Applications/Microsoft Word.app"

    rm -rif ~/Library/Containers/com.microsoft.errorreporting
    rm -rif ~/Library/Containers/com.microsoft.Excel
    rm -rif ~/Library/Containers/com.microsoft.netlib.shipassertprocess
    rm -rif ~/Library/Containers/com.microsoft.Office365ServiceV2
    rm -rif ~/Library/Containers/com.microsoft.Outlook
    rm -rif ~/Library/Containers/com.microsoft.Powerpoint
    rm -rif ~/Library/Containers/com.microsoft.RMS-XPCService
    rm -rif ~/Library/Containers/com.microsoft.Word
    rm -rif ~/Library/Containers/com.microsoft.onenote.mac

    rm -rif "$HOME/Library/Group Containers/UBF8T346G9.ms"
    rm -rif "$HOME/Library/Group Containers/UBF8T346G9.Office"
    rm -rif "$HOME/Library/Group Containers/UBF8T346G9.OfficeOsfWebHost"

    pkgutil --forget com.microsoft.package.component
    pkgutil --forget com.microsoft.package.Fonts
    pkgutil --forget com.microsoft.package.Frameworks
    pkgutil --forget com.microsoft.package.Microsoft_AutoUpdate.app
    pkgutil --forget com.microsoft.package.Microsoft_Excel.app
    pkgutil --forget com.microsoft.package.Microsoft_OneNote.app
    pkgutil --forget com.microsoft.package.Microsoft_Outlook.app
    pkgutil --forget com.microsoft.package.Microsoft_PowerPoint.app
    pkgutil --forget com.microsoft.package.Microsoft_Word.app
    pkgutil --forget com.microsoft.package.Proofing_Tools

    osascript -e 'display notification "Office 2016 uninstalled, rebooting..." with title "CFA-IT Update"'

    touch /Users/Shared/.com.googlecode.munki.checkandinstallatstartup

    shutdown -r now

fi

exit 0