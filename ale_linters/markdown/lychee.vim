" ~/.config/nvim/ale_linters/markdown/lychee.vim
" Lychee link checker for ALE

call ale#Set('markdown_lychee_executable', 'lychee')
call ale#Set('markdown_lychee_options', '')

function! ale_linters#markdown#lychee#GetCommand(buffer) abort
    let l:executable = ale#Var(a:buffer, 'markdown_lychee_executable')
    let l:options = ale#Var(a:buffer, 'markdown_lychee_options')
    return ale#Escape(l:executable) . ' --format json' . ale#Pad(l:options) . ' %s'
endfunction

function! ale_linters#markdown#lychee#Handle(buffer, lines) abort
    let l:output = []
    try
        let l:json = ale#util#FuzzyJSONDecode(a:lines, {})
        let l:error_map = get(l:json, 'error_map', {})
        for [l:file, l:errors] in items(l:error_map)
            for l:error in l:errors
                let l:span = get(l:error, 'span', {})
                let l:status = get(l:error, 'status', {})
                call add(l:output, {
                \   'lnum': get(l:span, 'line', 1),
                \   'col': get(l:span, 'column', 1),
                \   'type': 'E',
                \   'text': get(l:status, 'text', 'Broken link') . ': ' . get(l:error, 'url', ''),
                \})
            endfor
        endfor
    catch
    endtry
    return l:output
endfunction

call ale#linter#Define('markdown', {
\   'name': 'lychee',
\   'executable': {b -> ale#Var(b, 'markdown_lychee_executable')},
\   'command': function('ale_linters#markdown#lychee#GetCommand'),
\   'callback': 'ale_linters#markdown#lychee#Handle',
\   'lint_file': 1,
\   'read_buffer': 0,
\})
