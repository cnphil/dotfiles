build: vim-plugins

modules:
	git submodule sync
	git submodule update --init --recursive

modules-update:
	git submodule foreach 'git fetch origin'
	git submodule foreach 'git checkout origin/master'

vim-plugins:
	cd .vim/bundle/vimproc; make
	cd .vim/bundle/ycm; ./install.sh --clang-completer

vim-plugins-fast:
	cd .vim/bundle/vimproc; make
	cd .vim/bundle/ycm; ./install.sh

clean:
	rm -f .vim/bundle/vimproc/autoload/vimproc_*.so

vim-config: modules
	ln -s $(CURDIR)/.vimrc ~/.vimrc
	ln -s $(CURDIR)/.vim ~/.vim

vim: vim-config vim-plugins

vim-fast: vim-config vim-plugins-fast

gitconfig:
	ln -s $(CURDIR)/.gitconfig ~/.gitconfig
	ln -s $(CURDIR)/.gitignore_global ~/.gitignore_global

mutt:
	ln -s $(CURDIR)/.muttrc ~/.muttrc
	ln -s $(CURDIR)/.mutt ~/.mutt

tmux:
	ln -s $(CURDIR)/.tmux.conf ~/.tmux.conf

zsh:
	-curl -L http://install.ohmyz.sh | sh
	sed -i 's/^ZSH_THEME=".*"/ZSH_THEME="phil-gentoo"/; s|.*ZSH_CUSTOM.*|ZSH_CUSTOM=$(CURDIR)/.oh-my-zsh/custom|' ~/.zshrc

