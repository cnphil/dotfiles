#!/usr/bin/bash
eval "ip link | egrep -q 'tun[0-9]'"
if [ $? -eq 0 ]; then
    echo " [V]"
else
    echo ""
fi
