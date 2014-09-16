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

