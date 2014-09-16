let g:acp_enableAtStartup = 0

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

