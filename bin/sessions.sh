#!/bin/bash

# This should be set as a startup item when using non-custom
# desktop environments like gnome or cinnamon.
# To setup this, run: gnome-session-properties

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
[[ -f ~/.Xresources_local ]] && xrdb -merge ~/.Xresources_local

