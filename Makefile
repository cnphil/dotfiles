build: vim-plugins

modules:
	git submodule sync
	git submodule update --init --recursive

modules-update:
	git submodule foreach 'git fetch origin'
	git submodule foreach 'git checkout origin/master'

vim-plugins:
	cd .vim/bundle/vimproc; make

clean:
	rm -f .vim/bundle/vimproc/autoload/vimproc_*.so

vim: modules vim-plugins
	ln -s $(CURDIR)/.vimrc ~/.vimrc
	ln -s $(CURDIR)/.vim ~/.vim

tmux:
	ln -s $(CURDIR)/.tmux.conf ~/.tmux.conf

zsh:
	curl -L http://install.ohmyz.sh | sh
	ln -fs $(CURDIR)/.oh-my-zsh/custom ~/.oh-my-zsh/custom
	sed -i 's/^ZSH_THEME=".*$/ZSH_THEME="phil-gentoo"/' ~/.zshrc

