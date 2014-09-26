# dpi settings
xrandr --dpi 200

# fcitx settings
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
fcitx

# set the cursor
xsetroot -cursor_name left_ptr

# read Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
[[ -f ~/.background.png ]] && feh --bg-fill ~/.background.png &

if [ -s ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi

xbindkeys

autocutsel -fork &
# autocutsel -selection PRIMARY -fork &
# the previous line enables select-to-copy

compton --config ~/.compton.conf &
# for blur and opacity

# xmobar volume pipe
_volume_pipe=/tmp/.volume-pipe
[[ -S $_volume_pipe ]] || mkfifo $_volume_pipe
_mpc_pipe=/tmp/.mpc-pipe
[[ -S $_mpc_pipe ]] || mkfifo $_mpc_pipe
/home/phil/bin/volume.sh &
if [ ! $(pgrep "mpc\.sh") ]; then
    /home/phil/bin/mpc.sh loop > /dev/null &
fi

# start xmonad
exec xmonad
