set shiftwidth=4 softtabstop=4 tabstop=4
set expandtab
set ruler
set number
set title
set autoindent
set smartindent
set showmatch
set shiftround
set nojoinspaces
set ignorecase
set smartcase

set nocompatible   " Disable vi-compatibility
set backspace=indent,eol,start
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
syntax on

set mouse=c

" load bundles
runtime bundle/unbundle/unbundle.vim
runtime! config/**/*.vim

" set the background color of sign column
highlight clear SignColumn
