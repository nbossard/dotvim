" Nicolas Bossard, 28Th may 2018, personal syntax for VIM editor
" Saved in git for history and for sharing across computers.
" As described here :
" See README.md for configuration.
"
" Other installs :
" brew install python@2
" brew install python3
" pip2 install neovim --upgrade
" pip3 install neovim --upgrade
"
" then test config with (neovim only):
" :checkhealth
"
let g:python_host_prog='/usr/local/bin/python'
let g:python3_host_prog='/usr/local/bin/python3'

" define the <leader> key
let mapleader=","

"
"---------------------- VIM-PLUG CONFIG -----------------------
" vim-plug replaces Vundle
"vim-plug install :
" https://github.com/junegunn/vim-plug

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

"{{{ ==== Languages syntax support plugins ======
"
" {{{ Arduino : For writing arduino sketches
Plug 'stevearc/vim-arduino', {'for': 'arduino'}
"}}}

" {{{ Vue : syntax highlighting for Vue components.
Plug 'posva/vim-vue', {'for': 'vue'}
autocmd Filetype vue setlocal foldmethod=syntax
" }}}

" {{{ Syntax highlighting for js files
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
" }}}

" {{{ To support PlantUML File syntax
" See: https://github.com/aklt/plantuml-syntax
Plug 'aklt/plantuml-syntax', {'for': 'plantuml'}
" To automatically generate file on save
"autocmd BufWritePost *.puml :make
" to allow folding
autocmd Filetype plantuml setlocal foldmethod=syntax
" changing max image size to support images like database schema
" See : https://plantuml.com/fr/faq#e689668a91b8d065
let g:plantuml_executable_script='plantuml -DPLANTUML_LIMIT_SIZE=8192 -verbose'
" }}}

" {{{ Adding support for '.feature' files,
" these are test files
" See : https://github.com/tpope/vim-cucumber
Plug 'tpope/vim-cucumber', {'for': 'cucumber'}
autocmd Filetype cucumber setlocal list
autocmd Filetype cucumber setlocal foldmethod=indent
autocmd Filetype cucumber setlocal tabstop=2
autocmd Filetype cucumber setlocal shiftwidth=2
autocmd Filetype cucumber setlocal softtabstop=2
autocmd Filetype cucumber setlocal expandtab
" }}}

" {{{ Adding Golang plugin
" see : https://github.com/fatih/vim-go
Plug 'fatih/vim-go', {'for': 'go'}
" Installing go-pls : syntax server for GO
" go get golang.org/x/tools/gopls@latest
" Making go-pls included server work for COC
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
autocmd FileType go setlocal foldmethod=syntax
autocmd Filetype go setlocal tabstop=4
autocmd Filetype go setlocal shiftwidth=4
autocmd Filetype go setlocal softtabstop=4

" COMPATIBILITY bug on neovim, setting list makes words disappear when
" switching to NERDTree
"autocmd Filetype go setlocal listchars=tab:\|\
"autocmd Filetype go setlocal list
"
"  Display doc in a floating window
let g:go_doc_popup_window = 1

" VET is one of the three default linters of Go
" This is to make VET ignore the checks for key value in bson.D
" error is : 'primitive.E composite literal uses unkeyed fields'
" Note : the list of checks done by vet can be obtained by running 'go tool vet help' in a terminal
let g:ale_go_govet_options = '--composites=false'

" Formatting on save is default option (similar to GoFmt).
" Just adding auto import in addition to format:
let g:go_fmt_autosave = 0
let g:go_fmt_command = "goimports"

" Add More highlighting
let g:go_highlight_types = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_function_parameters = 1


" }}}

"}}} ==== end of language syntax plugins =====

" {{{ ==== Git related Plugins ===

" {{{ GitGutter config
" Plugin to display a git line change marker close to line number
" see: https://github.com/airblade/vim-gitgutter
Plug 'airblade/vim-gitgutter'
" changing default mapping ]c cause conflicts with coc
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap ,gn <Plug>(GitGutterNextHunk)
nmap ,gp <Plug>(GitGutterPrevHunk)
nmap ghn <Plug>(GitGutterNextHunk)
nmap ghp <Plug>(GitGutterPrevHunk)
nmap ,gh <Plug>(GitGutterPreviewHunk)
nmap ,gdd :let g:gitgutter_diff_base = 'develop'<CR><bar>:GitGutter<CR>
nmap ,gdh :let g:gitgutter_diff_base = 'head'<CR><bar>:GitGutter<CR>

" Adding line number highlight by default
let g:gitgutter_highlight_linenrs = 1
" main commandes :
" ]h or [h --> next hunk
" ,gn or ,gp --> next hunk
" ,hp --> display hunk change
" ,hs --> stage hunk
" ,hs --> undo hunk
" :GitGutterFold --> sic
"
" To compare with another branch :
" :let g:gitgutter_diff_base = 'develop'
" :let g:gitgutter_diff_base = 'head'
" }}}

" {{{ trying jreybert/vimagit for cross files commit
Plug 'jreybert/vimagit'
cabbrev magit Magit
cabbrev maggit Magit
" }}}

" {{{ Fugitive plugin : to display git log in vim
" see https://github.com/tpope/vim-fugitive
Plug 'tpope/vim-fugitive'
"Afugitive addition plugin To display a gitk (git log (history))like in vim
" https://github.com/junegunn/gv.vim
" Most used commands :
" View log :
" :GV
" View log will all branches (use git log options) :
" :GV --all
" Only for current file :
" :GV!
Plug 'junegunn/gv.vim'
autocmd FileType GV setlocal nolist
autocmd FileType GV setlocal nonumber
autocmd FileType GV setlocal norelativenumber
" Additional plugin for opening gitlab website throught command Gbrowse
Plug 'shumphrey/fugitive-gitlab.vim'
let g:fugitive_gitlab_domains = ['https://gitlab.forge.orange-labs.fr']
" Additional plugin to deal better with branches
" See : https://github.com/idanarye/vim-merginal
" Usage :
" :Merginal
Plug 'idanarye/vim-merginal'
cabbrev Gsdiff Gdiffsplit
command! -nargs=1 Gsdiff Gdiffsplit <args>
" }}}
"
" }}} === End of Git related plugins ====

" {{{ Startify plugin : To change start screen (welcome page)
" https://github.com/mhinz/vim-startify
Plug 'mhinz/vim-startify'
let g:startify_files_number = 5
let g:startify_commands = [
    \ ['NERDTree', ':NERDTree'],
    \ ['Vim Reference', 'h ref'],
    \ ['Hard Core mode', ':call HardMode()'],
    \ ]
let g:startify_lists = [
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ ]
" }}}

" {{{ Vim-test : plugin for launching tests inside vim
"see https://github.com/vim-test/vim-test
"usage : testFile
Plug 'vim-test/vim-test'
"let g:test#runner_commands = ['Mocha']
let test#javascript#jest#executable = './node_modules/.bin/vue-cli-service test:unit'
let test#javascript#jest#options = {
  \ 'nearest': '',
  \ 'file':    '',
  \ 'suite':   '',
\}
cabbrev te TestFile
" See also Mahali project vimrc config file
"}}}

" {{{ vim-translator : Plugin for translating between human languages
" See: https://github.com/voldikss/vim-translator
" usage: no default mapping, use commands
" :Translate <== translate selected text to default language (english)
" or :TranslateR <==  <== translate and replace  selected text to default language (english)
Plug 'voldikss/vim-translator'
" Changing default target language from chinese to english
let g:translator_target_lang='en'
" As I am a french guy, I find these addditional commands useful
" Note the -range and <line1> <line2> to mark the selectedd text
" See : https://stackoverflow.com/questions/29495291/apply-vim-user-defined-command-to-visual-selection-or-all
command -range TranslateToFR <line1>,<line2>Translate --target_lang=fr
command -range TranslateRToFR <line1>,<line2>TranslateR --target_lang=fr
" }}}

" {{{ ===== NERDTree related configs =====
" Nerdtree is a must have plugin, to have a browser for files on left panel
Plug 'preservim/nerdtree'
" Nerdtree plugin has plugins (sic)
" Plugin-plugin to open file using System from NERDTree
Plug 'ivalkeen/nerdtree-execute'
" Plug-plugin To show git changed files in NERDTree
" https://github.com/Xuyuanp/nerdtree-git-plugin
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'pseewald/nerdtree-tagbar-combined'
" Plugin to add coloring on devicons (see below)
" https://github.com/tiagofumo/vim-nerdtree-syntax-highlight
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" NERDTree related config
" Make NERDTree show hidden files by default
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=0
autocmd FileType nerdtree setlocal nonumber
autocmd FileType nerdtree setlocal norelativenumber
let NERDTreeAutoCenter=1
let NERDTreeAutoCenterTreshold=8
" Hide some files
let NERDTreeIgnore=['\.swp']
" Add mapping for 'nerdtree find' : gnf
" rem function! where ! means overwrite if already exists
function! NERDTreeShowMeFile()
  :NERDTreeFind
  :normal zz
  :normal o
endfunction
map gnf :call NERDTreeShowMeFile()<CR>
map gnF :NERDTreeFind<CR>

" {{{ Plugin to add icons : in ctrlP, Airline, NERDTree, Startify
" See https://github.com/ryanoasis/vim-devicons
" Requires Nerd font
" https://github.com/ryanoasis/nerd-fonts
Plug 'ryanoasis/vim-devicons'
" }}}
" }}} ===== end of nerdtree related config ======

" {{{ Airline plugin : Improved status line bar
" Use airline plugin as status line bar
" https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'
"an extra statusline on the top of the Vim window and can display loaded buffers and tabs in the current Vim session
" NBO tried it but finally disabled cause slow downs too much
let g:airline#extensions#tabline#enabled = 0
"Also tried : Plug 'ap/vim-buftabline'
"but same slowing down
"
" display clock in airline
Plug 'enricobacis/vim-airline-clock'
" without this line, airline-clock defaults to updatetime and consumes a lot
" of CPU
let g:airline#extensions#clock#updatetime = 60000
" use > separators between sections
let g:airline_powerline_fonts = 1
"
"Disable tagbar, cause already displayed on right
"and hides filename
let g:airline#extensions#tagbar#enabled = 0
"
" various airline bar themes
Plug 'vim-airline/vim-airline-themes'
" }}}

" {{{ open-browser : Plugin to open URL under cursor in an external browser
" See doc at : https://www.vim.org/scripts/script.php?script_id=3133
" Command : gx
Plug 'tyru/open-browser.vim'
" My setting.
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
" open regular expression test website
cabbrev regex101 OpenBrowser https://regex101.com
" }}}

" {{{ Plugin to display the list of registers
" on a right bar on " or @ keypress
" See : https://github.com/junegunn/vim-peekaboo
Plug 'junegunn/vim-peekaboo'
" }}}

" {{{ unicode : to show unicode (and digraph) tables and search
" Usage :UnicodeTable
" See : https://github.com/chrisbra/unicode.vim
Plug 'chrisbra/unicode.vim'
"}}}

"  {{{ ALE plugin : To support various linters
" ALE = Asynchronous Lint Engine
" See : https://github.com/dense-analysis/ale
" acts as a Vim Language Server Protocol client
Plug 'dense-analysis/ale'
" By default, all available tools for all supported languages will be run.
"
" changing lint delay from 200ms to ... in order to run less often
let g:ale_lint_delay=3000
" NBO : do not try to enable tsserver on vue files, it does not work
"let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}
"let g:ale_linters = {'vue': ['eslint', 'vls', 'tsserver']}
" Git plugin to embed git command in vim
nmap gan :ALENext<CR>
nmap gap :ALEPrevious<CR>
" }}}

"{{{ BufOnly : Closes all buffers but this one
" see : https://github.com/vim-scripts/BufOnly.vim
" usage : :BufOnly
Plug 'vim-scripts/BufOnly.vim'
cabbrev bother BufOnly
cabbrev BOther BufOnly
"}}}

" {{{ Vim indent guides : Plugin to display indent lines
" Also tried Plugin 'Yggdroot/indentLine' but has issues with conceal usage
" https://github.com/nathanaelkane/vim-indent-guides
Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_auto_colors = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 3
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'startify']
" special config for some filetypes
autocmd FileType yaml let g:indent_guides_start_level = 1
" }}}

" {{{ loremipsum : allow generating of lorem ipsum
" See : https://www.vim.org/scripts/script.php?script_id=2289
" usage : :Loremipsum
Plug 'vim-scripts/loremipsum'
" }}}

" {{{ ctrl+P : Plugin to allow fuzzy search of files
" See : https://github.com/kien/ctrlp.vim
" Plug 'ctrlpvim/ctrlp.vim'
" Excluding node_modules folder
" cause it slowdowns ctr-P
" Should  be in local .vimrc but does not work
" Tips for usage : <c-r> to switch to regex mode’s
" <c-f> and <c-b> to cycle between modes
" let g:ctrlp_custom_ignore = {
"     \ 'dir':  '\.git$\|node_modules$\|\.DS_STORE$',
"     \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\',
"     \ }
" " }}}

" {{{ fzf : fuzzy finder inside vim
" See : https://github.com/junegunn/fzf.vim
set rtp+=~/.vim/bundle/fzf
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" reassign ctrl-p main command
nmap <c-p> :FzfFiles<CR>
" add a prefix Fzf to all commands
let g:fzf_command_prefix = 'Fzf'
" Always enable preview window on the right with 60% width
let g:fzf_preview_window = 'right:60%'
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
"let g:fzf_layout = { 'down': '~40%' }

" You can set up fzf window using a Vim command (Neovim or latest Vim 8 required)
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }
" let g:fzf_layout = { 'window': '10new' }
" Required:
" - width [float range [0 ~ 1]]
" - height [float range [0 ~ 1]]
"
" Optional:
" - xoffset [float default 0.5 range [0 ~ 1]]
" - yoffset [float default 0.5 range [0 ~ 1]]
" - highlight [string default 'Comment']: Highlight group for border
" - border [string default 'rounded']: Border style
"   - 'rounded' / 'sharp' / 'horizontal' / 'vertical' / 'top' / 'bottom' / 'left' / 'right'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }


" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'
"}}}


" {{{ Using snippets in Vim
" in combination with Coc
" dont forget : :CocInstall coc-neosnippet
"
" See https://github.com/Shougo/neosnippet.vim
" and https://github.com/neoclide/coc-sources
Plug 'Shougo/deoplete.nvim'
if !has('nvim')
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
" Note: was originally <c-k> but conflicted with digraph
imap <C-J>     <Plug>(neosnippet_expand_or_jump)
smap <C-J>     <Plug>(neosnippet_expand_or_jump)
xmap <C-J>     <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" For conceal markers.
 if has('conceal')
   set conceallevel=2 concealcursor=nv
 endif
 " NBO : adding my own snippets directory
 let g:neosnippet#snippets_directory='~/.vim/nbo_snippets'
" }}}

" {{{ vim-template : To allow usage of templates on new files
" see : https://github.com/aperezdc/vim-template
" Usage : create a new file with accurate extension (.vue)
" open it and type :Template
" NBO pinned on 08 june 2020 cause incompatibility issues with COC on latest
" revision
Plug 'aperezdc/vim-template'

" }}}

" {{{ vim-bbye : To close buffer without closing window
" See : https://github.com/moll/vim-bbye
" Command :Bdelete shortcut :Bd
Plug 'moll/vim-bbye'
" Override standard bd command
abbreviate bd Bdelete
" }}}

" {{{ vim-signature : To displays Vim marks in gutter
" See : https://github.com/kshenoy/vim-signature
Plug 'kshenoy/vim-signature'
" }}}

" {{{ vim-notes : Plugin to take notes
" See https://github.com/xolox/vim-notes
" usage :
" Nouvelle note : :Note
" Retrouver une note :
" :RecentNotes
Plug 'xolox/vim-notes'
let g:notes_directories = ['~/Documents/NotesVim']
" Required by plugin vim-notes
Plug 'xolox/vim-misc'
" Renaming RecentNotes for easier finding
" Rem : navigate using gf
command! NotesRecent RecentNotes
" }}}

" {{{ hardmode : Plugin for Disabling arrows, oh my god...
" Enable it by
" :call HardMode()
Plug 'wikitopian/hardmode'
let g:HardMode_level="wannabe"
" Always launch hardmode, sic
":call HardMode()
" }}}

" {{{ vim-mdnquery : Plugin to open javascript MDN directly from vim
" See : https://github.com/jungomi/vim-mdnquery
" installation : requires gem install mdn_query
" Usage : overwrites K key for some filetypes (Javascript)
"         or :MdnQuery keyword
Plug 'jungomi/vim-mdnquery'
autocmd FileType vue setlocal keywordprg=:MdnQuery
" }}}

" {{{ you surround me : Adding surround me to use 's' in commands
" https://github.com/tpope/vim-surround
" ysiw" ==> you surround inner word with quotes
" yss* ==> you surround entire line with star
" ysiw<em> ==> you surroung inner word with <em></em>
" cs'" ==> change surrounding ' for "
Plug 'tpope/vim-surround'
" }}}

" {{{ rainbow_csv : plugin for editing csv tsv formatted files
" https://github.com/mechatroner/rainbow_csv
Plug 'mechatroner/rainbow_csv'
"}}}

" {{{ editor-config: A plugin for cross editors configuration file
" for compatibility with other developers on other platforms
" See configuration in .editorconfig file
Plug 'editorconfig/editorconfig-vim'
" }}}

" {{{ ====== Completion in Vim : ====
" Tested and removed 'deoplin' for completion
" Tested and removed YCM : 'you complete' me for super completion

" {{{ Plugin for completion : COC
" https://github.com/neoclide/coc.nvim
" INSTALL : then switch to branch release
" INSTALL : then run :
" :CocInstall coc-tsserver coc-eslint coc-json coc-prettier coc-css coc-vetur
" :CocInstall coc-dictionary
" Emmet is already included in coc-vetur, but not in HTML so adding it
" :CocInstall coc-emmet
" :CocInstall coc-html
" :CocInstall coc-markdownlint
" :CocInstall coc-vimlsp
"
" Also tried coc marketplace :
" https://github.com/fannheyward/coc-marketplace
" Usage :
" :CocList marketplace list all available extensions
" :CocList marketplace python to search extension that name contains python
" CocInstall coc-marketplace
"
" Additional config for coc-tsserver is done in file opened by
" : CocConfig
"
" NOTE THAT THEY ARE USING 'release' branch
" so manual update : cd ~/.vim/bundle/coc.nvim; git pull
Plug 'neoclide/coc.nvim', {'branch': 'release'}
nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>dr <Plug>(coc-references)
nmap <silent> <leader>dj <Plug>(coc-implementation)
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
" Also influences gitgutter (they suggest 100ms).
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> gcp <Plug>(coc-diagnostic-prev)
nmap <silent> gcn <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
" changing coc highlight color cause light grey is invisible
" BUT is overwritten by scheme so defining it in an autocmd after colorscheme
" change
autocmd ColorScheme * highlight CocHighlightText     ctermfg=LightMagenta    guifg=LightMagenta

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" NBO: disabling in normal mode cause <C-i> and <TAB> are equivalent and this disables <C-I>
" nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"**************** end of Coc suggested configuration *****************
" }}}
" }}}

" {{{ vim-sass-colors : Plugin to colorize color texts in (s)css files
" Also tried following, but does not work on scss variables :
" Plug 'gko/vim-coloresque'
Plug 'shmargum/vim-sass-colors'
" }}}

" {{{ vim-prettier : plugin to call Prettier, to format sources (on save)
" See project local configuration in .prettierrc.js
Plug 'prettier/vim-prettier'
" }}}
"
" {{{ Plugin to simulate ctrl-shift-s
" https://github.com/dyng/ctrlsf.vim
" tip : to use regular expression type : :CtrlSF -R foo.*
" tip : to switch to quickfix presentation : M
Plug 'dyng/ctrlsf.vim'
"should not work but it does with neovim +iterm
nmap     <C-S-F> <Plug>CtrlSFPrompt
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-S-F> <Plug>CtrlSFVwordPath
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-S-F> <Plug>CtrlSFVwordExec
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>
let g:ctrlsf_ignore_dir = ['bower_components', 'node_modules', 'dist']
let g:ctrlsf_position = 'bottom'
let g:ctrlsf_winsize = '33%'
let g:ctrlsf_auto_focus = {
    \ "at": "done",
    \ "duration_less_than": 1000
    \ }
" }}}

" {{{ vim-multiple-cursors : Plugin for multiple cursors
" see : https://github.com/mg979/vim-visual-multi
" Originally to use with ctrlsf to change multiple words at a time
" usage : press ctrl-n n n
Plug 'mg979/vim-visual-multi'
" }}}

" {{{ Rainbow : To display colored parenthesis
" See : https://github.com/luochen1990/rainbow
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1
let g:rainbow_conf = {
\  'separately': {
\    '*': {},
\    'markdown': {
\      'parentheses_options': 'containedin=markdownCode contained',
\    },
\    'haskell': {
\      'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\v\{\ze[^-]/ end=/}/ fold'],
\    },
\    'vim': {
\      'parentheses_options': 'containedin=vimFuncBody',
\    },
\    'nerdtree': 0,
\    'go': 0,
\  }
\}
" nerdtree => disabled => makes [] visible
" go ==> disabled ==> useless for this language, trying to improve performance
" }}}

" {{{ Adding plugin to highlight trailing whitespace
" https://github.com/ntpeters/vim-better-whitespace
" To launch manual stripping of whitespaces :
" :StripWhitespace
Plug 'ntpeters/vim-better-whitespace'
let g:better_whitespace_filetypes_blacklist=['diff', 'gitcommit', 'unite', 'qf', 'help', 'mail', 'startify', 'git', 'taskedit']
"To highlight space characters that appear before or in-between tabs
let g:show_spaces_that_precede_tabs=1
"Enabling stripping on save (with confirmation)
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:startify_change_to_dir=0
" }}}

" {{{ delimitMate : Plugin to auto close brackets, parenthesis
" while typing in insert mode
Plug 'Raimondi/delimitMate'
" }}}

" {{{ tagbar : Displaying a tag bar on right side
" see https://github.com/majutsushi/tagbar
" Relies on external tag generator :
" Tried exuberant ctags , but did not work
" Replaced by Universal ctags :
" https://ctags.io/
" https://github.com/universal-ctags/ctags
" install with : brew install --HEAD universal-ctags/universal-ctags/universal-ctags
" see also : npm install -g git+https://github.com/ramitos/jsctags.git
Plug 'majutsushi/tagbar'
set tags=tags
" do not sort alphabetically
let g:tagbar_sort = 0
" Position the (global) quickfix window at the very bottom of the window
" (useful for making sure that it appears underneath tagbar splits)
" NOTE: Using a check here to make sure that window-specific location-lists
" aren't effected, as they use the same `FileType` as quickfix-lists.
autocmd FileType qf if (getwininfo(win_getid())[0].loclist != 1) | wincmd J | endif
" }}}

" {{{ File-line : plugin
" Allow opening a filename with line number
" See https://github.com/bogado/file-line
Plug 'bogado/file-line'
" }}}

" {{{ Markdown plugin
" See https://github.com/plasticboy/vim-markdowns
" Improve display, replace formatting by result for bold and italic
autocmd Filetype markdown setlocal conceallevel=2
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" Enable color column for markdown files
"autocmd Filetype markdown setlocal highlight ColorColumn ctermbg=darkmagenta guibg=darkmagenta
autocmd Filetype markdown setlocal colorcolumn=80
" }}}

" {{{ calendar : Adding calendar tool in Vim
Plug 'itchyny/calendar.vim'
let g:calendar_google_calendar = 1
" }}}

" {{{ tcomment_vim : Quick comment uncomment
" see https://github.com/tomtom/tcomment_vim
" Usage : gc<motion>
" gcc for current line
Plug 'tomtom/tcomment_vim'
"}}}

" {{{ Plugin to generate remark slides
" See https://github.com/mauromorales/vim-remark
" Commands :
" :RemarkBuild
" :RemarkPrview
Plug 'mauromorales/vim-remark'
" To ease table creation in remark
" https://github.com/dhruvasagar/vim-table-mode
" invoke vim-table-mode’s table mode with <leader>tm
" enter | twice to write a properly formatted horizontal line
Plug 'dhruvasagar/vim-table-mode'
let g:table_mode_corner="|"
" }}}

" {{{ Plugin to generate JSDoc
" https://github.com/heavenshell/vim-jsdoc
" Usage :
" :JsDoc
Plug 'heavenshell/vim-jsdoc'
"To fix neovim issue : unknown command
command! -register JsDoc call jsdoc#insert()
" To allow prompt for filling fields
let g:jsdoc_allow_input_prompt=1
" to enable @access tag
let g:jsdoc_access_descriptions=1
let g:jsdoc_return_type=1
let g:jsdoc_param_description_separator=' - '
" }}}

" {{{ killersheep : A game, to test popup windows
" See : https://github.com/vim/killersheep
" Usage :Kill
Plug 'vim/killersheep'
" }}}

" {{{ Plugin to use gtd in vim
" See : https://github.com/phb1/gtd.vim
" rem : to delete a task : GtdDelete
Plug 'phb1/gtd.vim'
let g:gtd#default_action = 'inbox'
let g:gtd#default_context = 'work'
let g:gtd#dir = '~/gtd'
let g:gtd#map_browse_older = '<Left>'
let g:gtd#map_browse_newer = '<Right>'
let g:gtd#review = [
  \ '(!inbox + !scheduled-'.strftime("%Y%m%d").') @work',
  \ '!todo @work',
  \ '!todo @work #10min',
  \ '!todo @work #30min',
  \ '!waiting @work',
  \ '!archived @work',
  \ ]
" to refresh task list : ,re
let g:gtd#map_refresh = "re"
autocmd BufWinEnter gtd-results :GtdRefresh
" Keys to create a nex task : ,gn
nmap <Leader>gn <Plug>GtdNew
vmap <Leader>gn <Plug>GtdNew
abbreviate gtdnew GtdNew
abbreviate gtdn GtdNew
"Keys to review tasks
nmap <leader>gr :GtdReview
" }}}

" Plugin to run mongodb js files directly from Vim
" https://github.com/tpope/vim-dadbod
Plug 'tpope/vim-dadbod'

" {{{ Plugin for grammar check
" see : https://github.com/rhysd/vim-grammarous
" NOTE : REQUIRES JAVA 8
" Plug 'rhysd/vim-grammarous'
let g:grammarous#default_comments_only_filetypes = {
            \ '*' : 1, 'help' : 0, 'markdown' : 0,
            \ }
command! GrammarousCheckFR :GrammarousCheck --lang=fr
" }}}

" {{{ yaml-vim : Plugin to support yaml file format
" https://github.com/mrk21/yaml-vim
Plug 'mrk21/yaml-vim', {'for': 'yaml'}
" }}}

" {{{ Plugin for making REST request using Curl
" https://github.com/diepm/vim-rest-console
" usage :
" :set ft=rest
" http://localhost:9200
" GET /_cat/nodes?v|
" <C-J>
Plug 'diepm/vim-rest-console', {'for': 'rest'}
let vrc_horizontal_split=1
autocmd FileType rest setlocal nospell
" }}}

" {{{ Plugin for dockerfiles
Plug 'ekalinin/Dockerfile.vim'
" }}}

" {{{ Plugin for .gitignore files
Plug 'gisphm/vim-gitignore', {'for': 'gitignore'}
" }}}

" {{{ mundo : Plugin for displaying undo tree
" https://github.com/simnalamburt/vim-mundo
" Usage : https://simnalamburt.github.io/vim-mundo/
Plug 'simnalamburt/vim-mundo'
" }}}

" {{{ vim-base64
" https://github.com/christianrondeau/vim-base64
" Usage : select then
" <leader>atob   ===> to convert from base 64 to string
"  or
" <leader>btoa   ===> to convert from string to base 64
Plug 'christianrondeau/vim-base64'
""}}}

" {{{ cheatsheet
" Learn X in Y minutes
" Code documentation written as code!
" usage : <leader>hl
Plug 'adambard/learnxinyminutes-docs'
let g:bundle_dir = "/Users/nbossard/.vim/plugged"

function! HelpLearnXInMinutes(topic) abort
    let l:file = &filetype
    if a:topic != ''
        let l:file = a:topic
    endif

    let l:file = g:bundle_dir . '/learnxinyminutes-docs/fr-fr/'
                \ . l:file . '-fr.html.markdown'

    if !filereadable(l:file)
        let l:file = fnamemodify(l:file, ":h")
        execute "Explore" file
    endif

    execute "edit" file
endfunction

command! -nargs=+ HelpLearnXInMinutes call HelpLearnXInMinutes(<f-args>)
command! -nargs=+ Cheatsheet call HelpLearnXInMinutes(<f-args>)
nnoremap <leader>hl :call HelpLearnXInMinutes(&filetype)<cr>
" }}}
"
" {{{ripgrep : brings usage of 'ripgrep' in vim
" See: https://github.com/jremmen/vim-ripgrep
" A much faster version that grep and much much than vimgrep
" usage to search 'toto' in all project files :
" :Rg toto
" usage to search 'toto' in go files only:
" :Rg toto -t go
" usage to search for a regular expression:
" :Rg 'mic.*v2'
Plug 'jremmen/vim-ripgrep'
" config -vimgrep : to display multiple results in the same line in multiple
" line in quickfix
" config -S : to use smart casing syntax (minuscule means minuscule or majuscule)
let g:rg_command = 'rg --vimgrep -S'
cabbrev rg Rg
" }}}

" {{{ Asyncrun
" Required by vim-ripgrep
Plug 'skywind3000/asyncrun.vim'
" }}}

" {{{ bufexplore : Plugin for buffers list display and management
" https://github.com/jlanzarotta/bufexplorer
" Usage : <leader>be    ,be
" Aimed to improve buffer list display (:ls ou :buffers ou via ctrl-P plugin)
" Plug 'jlanzarotta/bufexplorer'
" NOTE : disabling it to use FzfBuffers cause it has a preview and looks smarter
map <leader>be :FzfBuffers<cr>
" }}}

" {{{ ===== Various colorscheme s ====
"Enables 24-bit RGB color
set termguicolors
"Enable quick switch schemecolor
" Use F8 and shift+F8 to quick switch
Plug 'xolox/vim-colorscheme-switcher'
:let g:colorscheme_switcher_exclude = ['default', 'blue', 'shine', 'elflord']
:let g:colorscheme_switcher_exclude_builtins = 1
"Adding a light theme similar to GitHub
"Usage : :colorscheme github
"See color schemes list : :colorscheme <ctrl+d>
Plug 'acarapetis/vim-colors-github'
Plug 'nanotech/jellybeans.vim'
"Pencil color theme
Plug 'reedes/vim-colors-pencil'
" gruvbox : https://github.com/morhetz/gruvbox
Plug 'morhetz/gruvbox'
" dracula : https://draculatheme.com/vim
Plug 'dracula/vim', { 'name': 'dracula' }
" Go dedicated colorscheme
" Plugin'bitfield/vim-gitgo'
" visual studio code like dark theme
Plug 'tomasiser/vim-code-dark'
" https://vimawesome.com/plugin/landscape-vim
Plug 'itchyny/landscape.vim'
"}}}

" {{{ Jsonc : jsonc type file support
Plug 'neoclide/jsonc.vim'
autocmd BufNewFile,BufRead *.jsonc setlocal filetype=jsonc
" }}}


" All of your Plugins must be added before the following line
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#end()

"-----------------------END OF VIM-PLUG CONFIG---------------------

" change default colorscheme
colorscheme gruvbox
" Make coc current object be highlighted in Magenta (was not enough visible)
highlight CocHighlightText     ctermfg=LightMagenta    guifg=LightMagenta



" {{{ fzf : Try to use fuzzy finder in Vim
" https://github.com/junegunn/fzf#as-vim-plugin
" Installed using Homebrew, configuring it :
set rtp+=/usr/local/opt/fzf
" }}}

" Display line number in left gutter
:set number

" Allow syntax coloring
" Syntax are located in *.vim files, e.g. : "java.vim", try "locate java.vim"
:syntax on

" Highlight result of searches
:set hlsearch

" Setting search case sensitivity
" tried by default ignorecase
" :set ignorecase
" But smartcase seems better : some uppercase => case sensitive,
" lowercase ==> case insensitive
" but this disturbs command completion so turning it off in command line
augroup dynamic_smartcase
    autocmd!
    autocmd CmdLineEnter : set ignorecase
    autocmd CmdLineLeave : set smartcase
augroup END

" To Fix backspace not working in insert mode (on Mac ?)
set bs=2

" To use find command easily in VIM (requires path to be set)
set path=$PWD/**

" To display spaces and change colors
"
" SpecialKey is the name of group including spaces,
" ctermfg => color terminal  foreground
" to disable : 'set nolist'
set listchars=tab:>-,trail:.,extends:>,precedes:<,space:.
" list of filetypes for wich we want spaces to be displayed
autocmd FileType vim setlocal list
autocmd FileType yaml setlocal list
"highlight SpecialKey ctermfg=DarkGray

" Set the hidden option so any buffer can be hidden (keeping its changes) without first writing the buffer to a file.
" This affects all commands and all buffers.
:set hidden

"Quick file search mapped on F4, opens quickfix window
" Could also be done by
":ripgrep titi **/*   <=== will open results in quickfix list
":cdo %s/titi/toto/gc  <== cdo, do for all files in quicklist
map <F4> :execute "ripgrep /" . expand("<cword>") . "/gj **" <Bar> cw<CR>
map <F5> :execute "ripgrep /" . expand("<cWORD>") . "/gj **" <Bar> cw<CR>

" Allowing per project configuration
" For example to have a custom spellfile
" See https://andrew.stwrt.ca/posts/project-specific-vimrc/
set exrc
set secure

"spell : to enable :
" (enabled in project config file usually)
" :set spell spelllang=fr
" Usual commands :
" zg => add word to dico
" zw => remove word from dico
" z= => suggest word
" defining custom alias
map gsn ]s
map gsp [s
" grammar check : see vim-grammarous plugin above


" Allow search of currently selected text using //
vnoremap // y/<C-R>"<CR>

" {{{ Making cursor mode more visible
" on entering / leaving insert mode, insert a cursor line and column
" Make cursor more visible in insert mode :
autocmd InsertEnter * set cursorcolumn
autocmd InsertEnter * set cursorline
autocmd InsertLeave * set nocursorcolumn
autocmd InsertLeave * set nocursorline
highlight CursorColumn guibg=LightMagenta
" highlight CursorLine: guibg=LightMagenta
" }}}

" Adding live view of substitute command on neovim only
if exists('&inccommand')
  set inccommand=split
endif

" Adding relative numbers
":set number relativenumber


"Json files related configs
" Add support for comments in jsonc files
autocmd FileType json syntax match Comment +\/\/.\+$+
"Set conceallevels
autocmd FileType json setlocal conceallevel=0

" Allow folding in markdown files
let g:markdown_folding = 2

" {{{ Ranger style marks command
"
""""""""""""""""""""""""""""
function! Marks()
    marks
    echo('Mark: ')

    " getchar() - prompts user for a single character and returns the chars
    " ascii representation
    " nr2char() - converts ASCII `NUMBER TO CHAR'

    let s:mark = nr2char(getchar())
    " remove the `press any key prompt'
    redraw

    " build a string which uses the `normal' command plus the var holding the
    " mark - then eval it.
    execute "normal! '" . s:mark
endfunction
" }}}

nnoremap ' :call Marks()<CR>

" For supporting mouse click in all modes
:set mouse=a

" Replace bullshit vim help navigation commands
" Done in after/ftplugin/help.vim
" Press Enter to jump to the subject (topic) under the cursor.
" Press Backspace to return from the last jump.
" Press s to find the next subject, or S to find the previous subject.
" Press o to find the next option, or O to find the previous option.

" Making vim files be foldable based on markers {{{ and }}}
autocmd FileType vim setlocal foldmethod=marker

" Making Vim know to display in italic
" set t_ZH=^[[3m
" set t_ZR=^[[23m
" let &t_ZH="\e[3m"
" let &t_ZR="\e[23m"
highlight Comment gui=italic

" syntax debugging tool : helps understand why colored
" See : https://yanpritzker.com/how-to-change-vim-syntax-colors-that-are-annoying-you-13ce55948760
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" {{{ make vim save folding of files when leaving and coming back
" save folding and cursor position only
set viewoptions=folds,cursor
" ! to overwrite existing file
augroup AutoSaveFolds
  autocmd!
  " view files are about 500 bytes
  " bufleave but not bufwinleave captures closing 2nd tab
  " nested is needed by bufwrite* (if triggered via other autocmd)
  autocmd BufWinLeave,BufLeave,BufWritePost ?* nested silent! mkview!
  autocmd BufWinEnter ?* silent! loadview
augroup END
" }}}

"{{{ Adding useful shortcuts
" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d
" replace currently selected text with default register (paste)
" without yanking it
vnoremap <leader>p "_dP

" windows style 'ctrl + s' for saving
nmap <c-s> :write<CR>
" buffer navigation
nmap gn :bn<CR>
nmap gp :bp<CR>
"}}}

" set diff options
if has("patch-8.1.0360")
    set diffopt+=internal,algorithm:patience
endif

" Keep at least 5 lines visible at top and bottom of screen
:set scrolloff=5

"{{{ Common typo autofix
iabbrev improcing improving
"}}}

" {{{ Improving copier-coller classic support
"  When the "unnamed" string is included in the 'clipboard' option, the unnamed
" register is the same as the "* register.  Thus you can yank to and paste the
" selection without prepending "* to commands.
set clipboard+=unnamed  " use the clipboards of vim and win

" This should not be set in vimrc (see :checkhealth warning)
" Cause it disables too many features
" https://vimhelp.org/options.txt.html#%27paste%27
"set paste               " Paste from a windows or from vim

set guioptions+=a       " Visual selection automatically copied to the clipboard
" }}}
