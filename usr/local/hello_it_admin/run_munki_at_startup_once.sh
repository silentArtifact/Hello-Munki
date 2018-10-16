#!/bin/bash

# Prerequisites: Outset, Munki Client

# What this does: This creates the "Munki bootstrap" file, which tells munki
# to update on reboot, but it _also_ creates a new plist with the variable
# HasRun, and sets it to "false". It then creates a new Outset script that
# checks on startup to see if that variable is set to true. If it isn't, 
# it sets it to true (counting on the presence of the )

touch /Users/Shared/.com.googlecode.munki.checkandinstallatstartup
defaults write /Library/Preferences/MunkiRunOnStartup HasRun "false"

cat > /usr/local/outset/boot-every/MunkiRunOnceOnStartup.sh << EOF
#!/bin/sh

hasMunkiRun=\$(defaults read /Library/Preferences/MunkiRunOnStartup HasRun)

if [ \$hasMunkiRun = "false" ] && [ -f /Users/Shared/.com.googlecode.munki.checkandinstallatstartup ]; then
defaults write /Library/Preferences/MunkiRunOnStartup HasRun "true"
else
rm /Users/Shared/.com.googlecode.munki.checkandinstallatstartup
rm /Library/Preferences/MunkiRunOnStartup.plist
rm -- "\$0"
fi

exit 0
EOF

chmod 755 /usr/local/outset/boot-every/MunkiRunOnceOnStartup.sh
chown root:wheel /usr/local/outset/boot-every/MunkiRunOnceOnStartup.sh

    SURETY="$(osascript -e 'display dialog "Munki will update on the next reboot. Reboot now?" buttons {"Reboot", "Later"} default button "Later" with icon caution')"

    if [ "$SURETY" = "button returned:Reboot" ]; then
        shutdown -r now
    fi

exit 0