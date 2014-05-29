dotfiles
===

Backup of my dotfiles.

### TODO:
* Bash script for auto installation and backup.

### vim:
`.vimrc` and `.vim/`
* MAY NOT work out of box.
* Vim version 7.4.253 with lua, python support required.
* Various TERM tweaks for theme Solarized required.
* Plugins should be managed by Vundle, you need to manually install vundle into `.vim/vundle`.
* Other notable plugins that does NOT work out of box: ghc-mod (install from cabal), powerline (official python implementation).
* TODO: install script.

### tmux:
`.tmux.conf`
* Should work out of box.
* Changed bind key to Ctrl-A.
* TODO: separate OS X-only scripts.

### slate:
`.slate`
* Should work out of box.

### oh-my-zsh:
`.oh-my-zsh/custom/`
* Includes my gentoo-style theme.
* TODO: separate user configurations that works for any shell.

### ghc:
`.ghc/ghci.conf`
* Hoogle and Hlint required.

### xmonad:
`.xmobarrc` and `.xmonad/xmonad.hs`
* Should work out of box.

### xorg:
`.xinitrc`, `.Xresources` and `.xbindkeysrc`
* Includes configurations for urxvt.
* xbindkey also required.

### fonts:
`.fonts/`
* Arch Linux-only.
* Run `fc-cache -vf` to update fonts.
