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
[[ -f ~/.background.png ]] && feh --bg-scale ~/.background.png &

if [ -s ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi

xbindkeys

autocutsel -fork &
# autocutsel -selection PRIMARY -fork &
# the previous line enables select-to-copy

# xmobar volume pipe
_volume_pipe=/tmp/.volume-pipe
[[ -S $_volume_pipe ]] || mkfifo $_volume_pipe
/home/phil/bin/volume.sh &

# start xmonad
exec xmonad
