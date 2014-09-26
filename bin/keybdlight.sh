#!/usr/bin/bash

show_brightness() {
  brt=$(kbdlight get)
  brt=$( printf "%.0f" $brt )
  if [ "$icon_name" = "" ]; then
        if [ "$brt" = "0" ]; then
            icon_name="notification-keyboard-brightness-off"
        else
            if [ "$brt" -lt "33" ]; then
                icon_name="notification-keyboard-brightness-low"
            else
                if [ "$brt" -lt "70" ]; then
                    icon_name="notification-keyboard-brightness-medium"
                else
                    icon_name="notification-keyboard-brightness-high"
                fi
            fi
        fi
  fi
  notify-send " " -i $icon_name -h int:value:$brt -h string:synchronous:brightness
}

case $1 in
  "")
    ;;
  "up")
    kbdlight up >/dev/null
    ;;
  "down")
    kbdlight down >/dev/null
    ;;
  *)
    echo "unknown command"
    exit 1
    ;;
esac
show_brightness
