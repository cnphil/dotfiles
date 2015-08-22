filetype plugin indent on

autocmd FileType ruby setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup haskell
    autocmd!
    autocmd FileType haskell map <silent> <leader><cr> :noh<cr>:GhcModTypeClear<cr>:SyntasticReset<cr>:HoogleClose<cr>
    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
augroup END

augroup java
  if filereadable(expand('~/.at_google_workstation'))
    source /google/data/ro/projects/vigor/vigor.vim
  endif
augroup END

autocmd BufNewFile,BufRead *.hsc set filetype=haskell
autocmd BufNewFile,BufRead *.page set filetype=markdown
