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

let g:airline_powerline_fonts=1
let g:airline#extensions#hunks#non_zero_only=1
let g:airline_detect_whitespace=0
let g:airline#extensions#default#section_truncate_width = {
    \ 'b': 30,
    \ 'x': 60,
    \ 'y': 88,
    \ 'z': 45,
    \ }
function! AirlineThemePatch(palette)
    if g:airline_theme == 'solarized'
        let a:palette.normal.airline_c = [ '#76878c', '#073642', 244, 235 ]
        let a:palette.normal.airline_x = [ '#76878c', '#073642', 244, 235 ]
    endif
    let a:palette.normal.airline_a = g:airline#themes#powerlineish#palette.normal.airline_a
    let a:palette.insert = g:airline#themes#powerlineish#palette.insert
    let a:palette.visual.airline_a = g:airline#themes#powerlineish#palette.visual.airline_a
    let a:palette.replace.airline_a = g:airline#themes#powerlineish#palette.replace.airline_a
    let a:palette.inactive.airline_a = g:airline#themes#powerlineish#palette.inactive.airline_a

    let a:palette.normal.airline_z = a:palette.normal.airline_a
    let a:palette.visual.airline_z = a:palette.visual.airline_a
    let a:palette.replace.airline_z = a:palette.replace.airline_a
    let a:palette.insert.airline_b[0] ='#ffffff'
    let a:palette.insert.airline_b[2] =231
    let a:palette.insert.airline_y = a:palette.insert.airline_b

    " hide original filepath
    let a:palette.normal.airline_c[0] = a:palette.normal.airline_c[1]
    let a:palette.normal.airline_c[2] = a:palette.normal.airline_c[3]
    let a:palette.insert.airline_c[0] = a:palette.insert.airline_c[1]
    let a:palette.insert.airline_c[2] = a:palette.insert.airline_c[3]
    let a:palette.visual.airline_c[0] = a:palette.visual.airline_c[1]
    let a:palette.visual.airline_c[2] = a:palette.visual.airline_c[3]
    let a:palette.replace.airline_c[0] = a:palette.replace.airline_c[1]
    let a:palette.replace.airline_c[2] = a:palette.replace.airline_c[3]

    let a:palette.normal_modified = a:palette.normal
    let a:palette.insert_modified = a:palette.insert
    let a:palette.visual_modified = a:palette.visual
    let a:palette.replace_modified = a:palette.replace

    function! MyFilewrap(text1, text2, text3, minwidth)
        if a:minwidth > 0 && winwidth(0) < a:minwidth
            return ''
        endif
        let myspace=g:airline_symbols.space
        let prefix = myspace == "\ua0" ? myspace : myspace.myspace
        let a:mySep = empty(a:text3) ? '' : myspace.g:airline_left_alt_sep.myspace
        let a:mytext1 = a:text1
        let a:mytext2 = a:text2
        if winwidth(0) < 79
            let a:mytext1 = ''
        endif
        if winwidth(0) < 74
            let a:mytext2 = ''
        endif
        if empty(a:mytext1) && empty(a:mytext2)
            let a:mySep = ''
        endif
        return a:mytext1 . a:mytext2 . a:mySep 
    endfunction

    function! MyAppendPath(cpath)
        if !empty(a:cpath) && a:cpath != "."
            return a:cpath . "/"
        endif
        return ""
    endfunction

    function! MyEmptyChecker(cname)
        if empty(a:cname)
            return "*"
        endif
        return a:cname
    endfunction

    function! MyGVimFixer()
        return ":)"
    endfunction

    let g:airline_section_a = "%#__accent_bold#%{airline#util#wrap(airline#parts#mode(),0)}%#__restore__#%{airline#util#append(airline#parts#paste(),0)}%{airline#util#append(airline#parts#iminsert(),0)}"
    let g:airline_section_b = "%{MyFilewrap(airline#extensions#hunks#get_hunks(),airline#extensions#branch#get_head(),fnamemodify(simplify(expand('%')),':t'), 0)}%<%{MyAppendPath(fnamemodify(simplify(expand('%')),':h'))}%#__accent_bold#%{MyEmptyChecker(fnamemodify(simplify(expand('%')),':t'))}%#__restore__#"
    let g:airline_section_c = "%#__accent_red#%m %{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#%{MyGVimFixer()}"

endfunction
let g:airline_theme_patch_func = 'AirlineThemePatch'

filetype plugin indent on

autocmd FileType ruby setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2

if !has('gui_running')
    let g:solarized_termcolors=256
    "set term=screen-256color
else
    set guioptions-=L
    set guioptions-=r
    set guioptions-=e
    if has('gui_macvim')
        set guifont=Monaco\ for\ Powerline:h12 " Patched font for Powerline
    else " then it's Arch Linux with urxvt
        set guifont=Monaco\ for\ Powerline\ 10
        set guioptions-=T
        set guioptions-=m
        nmap <S-F1> :set guifont=Monaco\ for\ Powerline\ 10<CR>
        nmap <S-F2> :set guifont=Curried\ 12<CR>
    endif
endif

set background=dark
colorscheme solarized

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

cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
inoremap <C-F> <Right>
inoremap <C-B> <Left>
inoremap <C-N> <Down>
inoremap <C-P> <Up>

" ycm configuration
if !exists("g:ycm_global_ycm_extra_conf")
  let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/ycm/third_party/ycmd/examples/.ycm_extra_conf.py'
endif

let g:ycm_key_invoke_completion = '<C-L>'
let g:ycm_always_populate_location_list = 1
" let g:ycm_key_list_select_completion = ['<C-N>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-P>', '<Up>']
" let g:ycm_server_keep_logfiles = 1
" let g:ycm_server_log_level = 'debug'
let g:ycm_semantic_triggers = {'haskell' : ['.']}

" Alt-V for paste in insert mode
map! <M-v> <C-r>*

" gui_gtk2 font size
let s:pattern = '^\(.* \)\([1-9][0-9]*\)$'
let s:minfontsize = 6
let s:maxfontsize = 16
function! AdjustFontSize(amount)
  if has("gui_gtk2") && has("gui_running")
    let fontname = substitute(&guifont, s:pattern, '\1', '')
    let cursize = substitute(&guifont, s:pattern, '\2', '')
    let newsize = cursize + a:amount
    if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
      let newfont = fontname . newsize
      let &guifont = newfont
    endif
  else
    echoerr "You need to run the GTK2 version of Vim to use this function."
  endif
endfunction

function! LargerFont()
  call AdjustFontSize(1)
endfunction
command! LargerFont call LargerFont()
map <M-=> :LargerFont<CR>

function! SmallerFont()
  call AdjustFontSize(-1)
endfunction
command! SmallerFont call SmallerFont()
map <M--> :SmallerFont<CR>

function! OpenInGvim(filepath)
    :bd
    :exec ":silent !gvim " . a:filepath
endfunction
command! OG call OpenInGvim(expand('%:p'))

:command GT GhcModType
:command GTC GhcModTypeClear
:command SP ConqueTermSplit zsh
:command VSP ConqueTermVSplit zsh
:command NL NeoCompleteLock
:command Black colors badwolf
:command Pretty colors solarized

