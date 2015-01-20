" set leader to ,
let mapleader=","
let g:mapleader=","

cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
inoremap <C-F> <Right>
inoremap <C-B> <Left>
inoremap <C-N> <Down>
inoremap <C-P> <Up>

" indent jumps
" <[l>, <]l>: exclusive jump to prev/next line with lower indent
"
" exclusive (bool): true: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): true: Go to next line
" false: Go to previous line
" lowerlevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): true: Skip blank lines
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal " column . "|"
        return
      endif
    endif
  endwhile
endfunction
" Moving back and forth between lines of same or lower indentation.
nnoremap <silent> [l :call NextIndent(1, 0, 1, 1)<CR>
nnoremap <silent> ]l :call NextIndent(1, 1, 1, 1)<CR>
vnoremap <silent> [l <Esc>:call NextIndent(1, 0, 1, 1)<CR>m'gv''
vnoremap <silent> ]l <Esc>:call NextIndent(1, 1, 1, 1)<CR>m'gv''
onoremap <silent> [l :call NextIndent(1, 0, 1, 1)<CR>
onoremap <silent> ]l :call NextIndent(1, 1, 1, 1)<CR>

:command GT GhcModType
:command GTC GhcModTypeClear
:command GC GhcModCheckAndLintAsync

" Type of expression under cursor
nmap <silent> <leader>ht :GhcModType<CR>
" Insert type of expression under cursor
nmap <silent> <leader>hT :GhcModTypeInsert<CR>
" GHC errors and warnings
nmap <silent> <leader>hc :SyntasticCheck ghc_mod<CR>
" Haskell Lint
nmap <silent> <leader>hl :SyntasticCheck hlint<CR>

" Hoogle the word under the cursor
nnoremap <silent> <leader>hh :Hoogle<CR>

" Hoogle and prompt for input
nnoremap <leader>hH :Hoogle 

" Hoogle for detailed documentation (e.g. "Functor")
nnoremap <silent> <leader>hi :HoogleInfo<CR>

" Hoogle for detailed documentation and prompt for input
nnoremap <leader>hI :HoogleInfo 

" Hoogle, close the Hoogle window
nnoremap <silent> <leader>hz :HoogleClose<CR>

" thanks to vim-slime, we can send v-mode selection to tmux by Ctrl-C Ctrl-C

:command SP ConqueTermSplit zsh
:command VSP ConqueTermVSplit zsh
:command NL NeoCompleteLock
:command Black colors badwolf
:command Pretty colors solarized

