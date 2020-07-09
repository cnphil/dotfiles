dotfiles
===

Backup of my dotfiles. Use `ln -s` to put them in place, some workflows can be automatically installed via `make`.

### Fast bootstrapper:
Setup the working environment on a server lightning fast.
```bash
$ curl -sL https://phil.tw/env | bash
```

### Usage:
* Backup your previous dotfiles.
* Follow instructions in the following sections that you're interested.
* `make modules` will restore submodules.
* `make modules-update` will update submodules with their upstream HEADs.
* `make build` builds required binaries like `vimproc`.
* Before running `git pull` to obtain upstream changes, run `make modules-fetch` to make sure submodules are ready.

### TODO:
* Migrate all dotfiles to symlink-style.
* `.vimrc` no longer works on Vim 8, needs complete remake.

### vim:
`.vimrc` and `.vim/`
* Vim version 7.4.253 or up with lua, python support required.
* Various TERM tweaks for theme Solarized required.
* Other notable plugins that does NOT work out of box: ghc-mod (install from cabal), ack.
* Installation:
    * Optional binaries: `ack` and `ghc-mod`.
    * Required binaries: `clang` (for C/C++ completion), `libtinfo` (if using Arch Linux, from AUR).
    * Run `make vim`.
* Key bindings: see [Vim config](https://wiki.phil.tw/Vim%20config).

### tmux:
`.tmux.conf`
* Changed bind key to Ctrl-A, default shell set to zsh.
* Installation:
    * Run `make tmux`.

### slate:
`.slate`
* OS X-only.

### amethyst:
`.amethyst`
* OS X-only.
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
* Both xmobar and xmonad should be installed via cabal-install.
    * Package `wireless_tools` required.
    * Run `cabal install xmobar --flags="all_extensions"` for xft, alsa, mpd, and wireless support.
    * Various libraries required, follow cabal's warnings carefully. To work
      with multiply displays, make sure `libxinerama-dev` is installed before
      xmonad and xmobar.

### xorg:
`.xinitrc`, `.Xresources`, `.Xmodmap` and `.xbindkeysrc`
* Includes configurations for urxvt.
* xbindkey also required.

### gtk+:
`.gtkrc-2.0` and `.config/gtk-3.0/settings.ini`
* GTK+ theme settings.
* Required packages:
    * faenza-icon-theme
    * ttf-opensans
    * mediterraneannight-theme

### fonts:
`.fonts/`
* Arch Linux-only.
* Run `fc-cache -vf` to update fonts.
* Other required binary: wqy-microhei, wqy-zenhei, wqy-bitmapfont.

### urxvt:
`.urxvt/`
* Required package: `urxvt-perls` and `autocutsel`.
* Please note that urxvt's settings are in `.Xresources`.

### mutt:
`.muttrc` and `.mutt/`
* Collaborates with `offlineimap`.

### compton:
`.compton.conf`
* The compositing manager that does not suck.
* Requires:
    * notify-osd-customizable
    * irssi-libnotify-git

### Other workflows:
These workflows require confidential data written in their configurations.
* offlineimap: `.offlineimaprc`.
* goobook: `.goobookrc`.
* irssi: `.irssi/`.
