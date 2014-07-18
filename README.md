dotfiles
===

Backup of my dotfiles. Uses `ln -s` to put them in place.

### Usage:
* Backup your previous dotfiles.
* Follow instructions in the following sections that you're interested.
* `make modules` will restore submodules.
* `make modules-update` will update submodules with their upstream HEADs.
* `make build` builds required binaries like `vimproc`.

### TODO:
* Separate .vimrc into config files.
* Migrate all dotfiles to symlink-style.

### vim:
`.vimrc` and `.vim/`
* Should work out of box.
* Vim version 7.4.253 with lua, python support required.
* Various TERM tweaks for theme Solarized required.
* Other notable plugins that does NOT work out of box: ghc-mod (install from cabal), powerline (python standalone), ack.
* Installation:
    * Optional binaries: `ack` and `ghc-mod`.
    * Run `make vim`.

### tmux:
`.tmux.conf`
* Should work out of box.
* Changed bind key to Ctrl-A, default shell set to zsh.
* Installation:
    * Run `make tmux`.

### slate:
`.slate`
* Should work out of box.

### amethyst:
`.amethyst`
* Should work out of box.
* Collaborates with slate.

### oh-my-zsh:
`.oh-my-zsh/custom/`
* Includes my gentoo-style theme.
* Installation:
    * Run `make zsh`:
        * May have to `chsh` to zsh manually.

### ghc:
`.ghc/ghci.conf`
* Hoogle and Hlint required.

### xmonad:
`.xmobarrc` and `.xmonad/xmonad.hs`
* Should work out of box.

### xorg:
`.xinitrc`, `.Xresources`, `.Xmodmap` and `.xbindkeysrc`
* Includes configurations for urxvt.
* xbindkey also required.

### gtk+:
`.gtkrc-2.0`
* GTK+ theme settings.

### fonts:
`.fonts/`
* Arch Linux-only.
* Run `fc-cache -vf` to update fonts.
* Other required binary: wqy-microhei, wqy-zenhei, wqy-bitmapfont.

### urxvt:
`.urxvt/`
* Basically works out of box.
* Required package: `urxvt-perls` and `autocutsel`.
* Please note that urxvt's settings are in `.Xresources`.

### Other workflows:
These workflows require confidential data written in their configurations.
* mutt:
    * `.muttrc` and `.mutt/` folder.
    * offlineimap: `.offlineimaprc`.
    * goobook: `.goobookrc`.
