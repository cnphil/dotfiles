#!/usr/bin/bash

get_volume() {
  # return volume levels (0-100)
  vol=$(amixer sget Master | grep -o -m 1 '[[:digit:]]*%' | tr -d '%')
  if amixer sget Master | grep "\[off\]"; then
      symbol="🔇"
      vol="0"
  elif [ ${vol} -lt 5 ]; then
      symbol="🔈"
  elif [ ${vol} -lt 15 ]; then
      symbol="🔈"
  elif [ ${vol} -lt 30 ]; then
      symbol="🔈"
  elif [ ${vol} -lt 45 ]; then
      symbol="🔉"
  elif [ ${vol} -lt 60 ]; then
      symbol="🔉"
  elif [ ${vol} -lt 70 ]; then
      symbol="🔉"
  elif [ ${vol} -lt 80 ]; then
      symbol="🔊"
  elif [ ${vol} -lt 95 ]; then
      symbol="🔊"
  else
      symbol="🔊"
  fi
  echo ${symbol} | tee /tmp/.volume-pipe

  if [ "$icon_name" = "" ]; then
        if [ "$vol" = "0" ]; then
            icon_name="notification-audio-volume-off"
        else
            if [ "$vol" -lt "33" ]; then
                icon_name="notification-audio-volume-low"
            else
                if [ "$vol" -lt "70" ]; then
                    icon_name="notification-audio-volume-medium"
                else
                    icon_name="notification-audio-volume-high"
                fi
            fi
        fi
  fi
  notify-send "Volume" -i $icon_name -h int:value:${vol} -h string:synchronous:volume
}

case $1 in
  "")
    ;;
  "up")
    amixer set Master 10+ unmute >/dev/null
    ;;
  "down")
    amixer set Master 10- unmute > /dev/null
    ;;
  "toggle")
    amixer set Master toggle >/dev/null
    ;;
  *)
    echo "unknown command"
    exit 1
    ;;
esac
get_volume
