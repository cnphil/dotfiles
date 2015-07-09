#!/usr/bin/bash
# THIS SCRIPT SHOULD BE RUN AS A SYSTEMD SERVICE AND TIMER
# e.g. /etc/systemd/system/battery-checker.service && /etc/systemd/system/battery-checker.timer

_battery_pipe=/tmp/.battery-pipe
[[ -p $_battery_pipe ]] || mkfifo $_battery_pipe

C_NOW=`cat /sys/class/power_supply/BAT0/charge_now`
C_FULL=`cat /sys/class/power_supply/BAT0/charge_full`

ANS=`echo "100*$C_NOW/$C_FULL" | bc`
PREV=""
POST=""
if [ $ANS -gt 79 ]; then
    PREV="<fc=green>"
    POST="</fc>"
fi
if [ $ANS -lt 15 ]; then
    PREV="<fc=red>"
    POST="</fc>"
fi
printf "%s%s%s%%\n" "$PREV" "$ANS" "$POST" | tee ${_battery_pipe}
