#!/usr/bin/bash
# THIS SCRIPT SHOULD BE RUN AS A SYSTEMD SERVICE AND TIMER
# e.g. /etc/systemd/system/vpn-checker.service && /etc/systemd/system/vpn-checker.timer

_vpn_pipe=/tmp/.vpn-pipe
[[ -p $_vpn_pipe ]] || mkfifo $_vpn_pipe

ANSWER=''

if ip link | egrep -q 'tun[0-9]'; then
    ANSWER=${ANSWER}" [V]"
fi

bash -c '(sleep 3; kill $$) & exit $(curl -s -o /dev/null -w "%{http_code}\\n" http://fuji.takau.net/generate_204)' > /dev/null 2>&1
if [ $? != 204 ]; then
    if [ "$ANSWER" = '' ]; then
        ANSWER="${ANSWER}"" "
    fi
    ANSWER="${ANSWER}""?"
fi

echo "$ANSWER" | tee ${_vpn_pipe}
