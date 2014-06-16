# set the cursor
xsetroot -cursor_name left_ptr

# read Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
[[ -f ~/background.xpm ]] && imlibsetroot ~/background.xpm &

# enable "natural" scrolling like OS X
xmodmap -e "pointer = 1 2 3 5 4"

# swap left Ctrl and left Alt (on Chromebook, mimicking HHKB)
# xmodmap -e "clear control"
# xmodmap -e "clear mod1"
# xmodmap -e "add control = Alt_L Control_R"
# xmodmap -e "add mod1 = Control_L Alt_R"

# map windows key to control
xmodmap -e "clear mod4"
xmodmap -e "add control = Super_L"

xbindkeys

autocutsel -fork &
autocutsel -selection PRIMARY -fork &

# start xmonad
exec xmonad
