set shiftwidth=4 softtabstop=4 tabstop=4
set expandtab
set ruler " highlight the line that the cursor is at
" set cursorline
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
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" alternatively, pass a path where Vundle should install plugins
"let path = '~/some/path/here'
"call vundle#rc(path)

" let Vundle manage Vundle, required
Plugin 'gmarik/vundle'

Bundle 'altercation/vim-colors-solarized'
Bundle 'rosenfeld/conque-term'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'kien/ctrlp.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'vim-scripts/indent-motion'
Bundle 'mileszs/ack.vim'
Bundle 'Shougo/neocomplete'
Bundle 'Shougo/neosnippet'
Bundle 'Shougo/neosnippet-snippets'
Bundle 'Shougo/vimproc'
Bundle 'eagletmt/ghcmod-vim'
Bundle 'ujihisa/neco-ghc'
execute pathogen#infect()
filetype plugin indent on
call pathogen#helptags()

autocmd FileType ruby setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
syntax on
"set t_Co=256
"set term=xterm-256color
"let g:solarized_termcolors=256
"let g:solarized_termtrans = 1
"let g:solarized_visibility = "high"
"let g:solarized_contrast = "high"
if !has('gui_running')
    set background=dark
    let g:solarized_termcolors = 256
    colorscheme solarized
    set term=screen-256color
else
    set background=dark
    colorscheme solarized
    set guioptions-=L
    set guioptions-=r
    if has('gui_macvim')
        set guifont=Monaco\ for\ Powerline:h12 " Patched font for Powerline
    else
        set guifont=Monaco\ for\ Powerline
    endif
endif

execute pathogen#incubate()

python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'


let g:ctrlp_prompt_mappings = {
\ 'PrtSelectMove("j")':   ['<c-j>', '<down>', '<c-n>'],
\ 'PrtSelectMove("k")':   ['<c-k>', '<up>', '<c-p>'],
\ 'PrtHistory(-1)':       [],
\ 'PrtHistory(1)':        [],
\ }

" set leader to ,
let mapleader=","
let g:mapleader=","

" set the background color of sign column
highlight clear SignColumn

" let g:neocomplete#max_list = 5
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
let $DOTVIM = $HOME . '/.vim'
" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'ruby' : $DOTVIM.'/dict/ruby.dict',
    \ }
" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
inoremap <C-F> <Right>
inoremap <C-B> <Left>
inoremap <C-N> <Down>
inoremap <C-P> <Up>


:command GT GhcModType
:command GTC GhcModTypeClear
:command SP ConqueTermSplit zsh
:command VSP ConqueTermVSplit zsh
:command NL NeoCompleteLock


