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
set t_u7=
syntax on

set mouse=c

" load bundles
runtime bundle/unbundle/plugin/unbundle.vim
runtime! config/**/*.vim

" google production settings
if filereadable(expand('~/.at_google_workstation'))
  " Google-only
  source /usr/share/vim/google/google.vim
  Glug youcompleteme-google
  " comma-s to sort java imports
  nnoremap ,s    :!/google/src/head/depot/google3/tools/java/sort_java_imports.py % <CR>
  " comma-r to remove unused java imports
  nnoremap ,r    :!/google/src/head/depot/google3/tools/java/remove_unused_imports.py --fix % <CR>
  " Jade to automatically resolve imports and deals with BUILD files
  command Jade !/google/data/ro/teams/jade/jade %
  " eclim
  let g:EclimCompletionMethod = 'omnifunc'
else
  " outside of Google
  call Unbundle('bundle/non-google/*')
endif

" set the background color of sign column
highlight clear SignColumn
