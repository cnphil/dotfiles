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

au BufRead,BufNewFile *.dart setfiletype dart
augroup dart
    " Set Dart SDK location
    autocmd FileType dart let g:ycm_dart_bin_folder_path = '/usr/lib/google-dartlang/bin'

    " Enable support for google3
    autocmd FileType dart let g:ycm_dart_analysis_server_flags = '--google3-package-resolution'
augroup END

autocmd BufNewFile,BufRead *.hsc set filetype=haskell
autocmd BufNewFile,BufRead *.page set filetype=markdown
