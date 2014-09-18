#!/usr/bin/bash

get_volume() {
  # return volume levels (0-100)
  vol=$(amixer sget Master | grep -o -m 1 '[[:digit:]]*%' | tr -d '%')
  if amixer sget Master | grep "\[off\]"; then
      vol="🔇"
  elif [ ${vol} -lt 5 ]; then
      vol="🔈"
  elif [ ${vol} -lt 15 ]; then
      vol="🔈"
  elif [ ${vol} -lt 30 ]; then
      vol="🔈"
  elif [ ${vol} -lt 45 ]; then
      vol="🔉"
  elif [ ${vol} -lt 60 ]; then
      vol="🔉"
  elif [ ${vol} -lt 75 ]; then
      vol="🔉"
  elif [ ${vol} -lt 80 ]; then
      vol="🔊"
  elif [ ${vol} -lt 95 ]; then
      vol="🔊"
  else
      vol="🔊"
  fi
  echo ${vol} | tee /tmp/.volume-pipe
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
