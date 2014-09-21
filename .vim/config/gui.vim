
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
        set guifont=Monaco\ for\ Powerline\ 9
        set guioptions-=T
        set guioptions-=m
        nmap <S-F1> :set guifont=Monaco\ for\ Powerline\ 9<CR>
        nmap <S-F2> :set guifont=Curried\ 12<CR>
        nmap <S-F3> :set guifont=Source\ Code\ Pro\ for\ Powerline\ 9<CR>
        nmap <S-F4> :set guifont=Terminess\ Powerline\ 9<CR>
    endif
endif

set background=dark
colorscheme solarized

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
