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
_mpc_pipe=/tmp/.mpc-pipe
[[ -S $_mpc_pipe ]] || mkfifo $_mpc_pipe
/home/phil/bin/volume.sh &
if [ ! $(pgrep "mpc\.sh") ]; then
    /home/phil/bin/mpc.sh loop > /dev/null &
fi

# xmonad is the default environment
session=${1:-xmonad}
# usage:
# $ startx ~/.xinitrc xfce

case $session in
    awesome           ) exec awesome;;
    bspwm             ) exec bspwm;;
    catwm             ) exec catwm;;
    cinnamon          ) exec cinnamon-session;;
    dwm               ) exec dwm;;
    enlightenment     ) exec enlightenment_start;;
    ede               ) exec startede;;
    fluxbox           ) exec startfluxbox;;
    gnome             ) exec gnome-session;;
    gnome-classic     ) exec gnome-session --session=gnome-classic;;
    i3|i3wm           ) exec i3;;
    icewm             ) exec icewm-session;;
    jwm               ) exec jwm;;
    kde               ) exec startkde;;
    mate              ) exec mate-session;;
    monster|monsterwm ) exec monsterwm;;
    notion            ) exec notion;;
    openbox           ) exec openbox-session;;
    unity             ) exec unity;;
    xfce|xfce4        ) exec startxfce4;;
    xmonad            ) 
        [[ -f ~/.background.png ]] && feh --bg-fill ~/.background.png &
        compton --config ~/.compton.conf &
        # for blur and opacity
        exec xmonad
    ;;
    # No known session, try to run it as command
    *) exec $1;;
esac
