# set the cursor
xsetroot -cursor_name left_ptr

# read Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# enable "natural" scrolling like OS X
xmodmap -e "pointer = 1 2 3 5 4"

# map windows key to control
xmodmap -e "clear mod4"
xmodmap -e "add control = Super_L"

xbindkeys

# start xmonad
exec xmonad
