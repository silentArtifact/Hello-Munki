#!/bin/bash

SURETY="$(osascript -e 'display dialog "Clear keychains?" buttons {"Yes", "No"} default button "No" with icon caution')"

    if [ "$SURETY" = "button returned:Yes" ]; then
        cat > /usr/local/outset/boot-once/kill-keychains.sh << EOF
#!/bin/sh

rm -Rf /Users/*/Library/Keychains/*

exit 0
EOF
    /usr/local/outset/outset --add-override /usr/local/outset/boot-once/kill-keychains.sh
    chmod +x /usr/local/outset/boot-once/kill-keychains.sh
    SURETY="$(osascript -e 'display dialog "Clearing keychains requires a reboot. Reboot now?" buttons {"Reboot", "Later"} default button "Later" with icon caution')"

    if [ "$SURETY" = "button returned:Reboot" ]; then
        shutdown -r now
    fi
fi

exit 0