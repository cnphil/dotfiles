#!/usr/bin/bash

show_brightness() {
  brt=$(xbacklight)
  brt=$( printf "%.0f" $brt )
  if [ "$icon_name" = "" ]; then
        if [ "$brt" = "0" ]; then
            icon_name="notification-display-brightness-off"
        else
            if [ "$brt" -lt "33" ]; then
                icon_name="notification-display-brightness-low"
            else
                if [ "$brt" -lt "70" ]; then
                    icon_name="notification-display-brightness-medium"
                else
                    icon_name="notification-display-brightness-high"
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
    xbacklight -inc 10 >/dev/null
    ;;
  "down")
    xbacklight -dec 10 >/dev/null
    ;;
  *)
    echo "unknown command"
    exit 1
    ;;
esac
show_brightness
