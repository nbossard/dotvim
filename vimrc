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

let mapleader=","

"
"---------------------- VUNDLE CONFIG -----------------------
" Vundle install :
"git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

set nocompatible              " be improved, required
filetype off                  " required

" set the run time path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" {{{ Languages syntax support plugins ======
"
" {{{ Arduino : For writing arduino sketches
Plugin 'stevearc/vim-arduino'
"}}}

" {{{ Vue : syntax highlighting for Vue components.
Plugin 'posva/vim-vue'
" }}}

" {{{ Syntax highlighting for js files
Plugin 'vim-javascript'
let g:javascript_plugin_jsdoc = 1
" }}}

" {{{ To support PlantUML File syntax
Plugin 'aklt/plantuml-syntax'
" }}}

" {{{ Adding support for '.feature' files
Plugin 'tpope/vim-cucumber'
" }}}

" {{{ Adding Golang plugin
Plugin 'fatih/vim-go'
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
" }}}

"}}} ==== end of language syntax plugins =====

" {{{ ==== Git related Plugins ===

" {{{ GitGutter config
" Plugin to display a git line change marker close to line number
" see: https://github.com/airblade/vim-gitgutter
Plugin 'airblade/vim-gitgutter'
" changing default mapping ]c cause conflicts with coc
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap ,gn <Plug>(GitGutterNextHunk)
nmap ,gp <Plug>(GitGutterPrevHunk)
nmap ghn <Plug>(GitGutterNextHunk)
nmap ghp <Plug>(GitGutterPrevHunk)
nmap ,gh <Plug>(GitGutterPreviewHunk)
" main commandes :
" ]h or [h --> next hunk
" ,gn or ,gp --> next hunk
" ,hp --> display hunk change
" ,hs --> stage hunk
" ,hs --> undo hunk
" :GitGutterFold --> sic
" }}}

" {{{ trying jreybert/vimagit for cross files commit
Plugin 'jreybert/vimagit'
cabbrev magit Magit
" }}}
"
" }}} === End of Git related plugins ====

" {{{ Startify plugin : To change start screen
" https://github.com/mhinz/vim-startify
Plugin 'mhinz/vim-startify'
let g:startify_files_number = 5
let g:startify_commands = [
    \ ['Vim Reference', 'h ref'],
    \ ['GTD Review', 'GtdReview'],
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
Plugin 'janko/vim-test'
"let g:test#runner_commands = ['Mocha']
let test#javascript#jest#executable = './node_modules/.bin/vue-cli-service test:unit'
let test#javascript#jest#options = {
  \ 'nearest': '',
  \ 'file':    '',
  \ 'suite':   '',
\}
"}}}

" {{{ ===== NERDTree related configs =====
" Nerdtree is a must have plugin, to have a browser for files on left panel
Plugin 'scrooloose/nerdtree'
" Nerdtree plugin has plugins (sic)
" Plugin-plugin to open file using System from NERDTree
Plugin 'ivalkeen/nerdtree-execute'
" Plugin-plugin To show git changed files in NERDTree
" https://github.com/Xuyuanp/nerdtree-git-plugin
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'pseewald/nerdtree-tagbar-combined'
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
function NERDTreeShowMeFile()
  :NERDTreeFind
  :normal zz
  :normal o
endfunction
map gnf :call NERDTreeShowMeFile()<CR>

" {{{ Plugin to add icons : in ctrlP, Airline, NERDTree, Startify
" See https://github.com/ryanoasis/vim-devicons
" Requires Nerd font
" https://github.com/ryanoasis/nerd-fonts
Plugin 'ryanoasis/vim-devicons'
" }}}
"}}} ===== end of nerdtree related config ======

" {{{ Airline plugin : Improved status line bar
" Use airline plugin as status line bar
" https://github.com/vim-airline/vim-airline
Plugin 'vim-airline/vim-airline'
"an extra statusline on the top of the Vim window and can display loaded buffers and tabs in the current Vim session
let g:airline#extensions#tabline#enabled = 1
" display clock in airline
Plugin 'enricobacis/vim-airline-clock'
" without this line, airline-clock defaults to updatetime and consumes a lot
" of CPU
let g:airline#extensions#clock#updatetime = 60000
" }}}

" {{{ open-browser : Plugin to open URL under cursor in an external browser
" See doc at : https://www.vim.org/scripts/script.php?script_id=3133
" Command : gx
Plugin 'tyru/open-browser.vim'
" My setting.
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
" }}}

" {{{ Plugin to display the list of registers
" on a right bar on " or @ keypress
" See : https://github.com/junegunn/vim-peekaboo
Plugin 'junegunn/vim-peekaboo'
" }}}

"  {{{ ALE plugin : To support various linters
" ALE = Asynchronous Lint Engine
" See : https://github.com/dense-analysis/ale
" acts as a Vim Language Server Protocol client
Plugin 'dense-analysis/ale'
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

" {{{ Fugitive plugin : to display git log in vim
" see https://github.com/tpope/vim-fugitive
Plugin 'tpope/vim-fugitive'
"Afugitive addition plugin To display a gitk (git log (history))like in vim
" https://github.com/junegunn/gv.vim
" Most used commands :
" View log :
" :GV
" View log will all branches (use git log options) :
" :GV --all
" Only for current file :
" :GV!
Plugin 'junegunn/gv.vim'
autocmd FileType GV setlocal nolist
autocmd FileType GV setlocal nonumber
autocmd FileType GV setlocal norelativenumber
" Additional plugin for opening gitlab website throught command Gbrowse
Plugin 'shumphrey/fugitive-gitlab.vim'
let g:fugitive_gitlab_domains = ['https://gitlab.forge.orange-labs.fr']
" Additional plugin to deal better with branches
" See : https://github.com/idanarye/vim-merginal
" Usage :
" :Merginal
Plugin 'idanarye/vim-merginal'
cabbrev Gsdiff Gdiffsplit
command! -nargs=1 Gsdiff Gdiffsplit <args>
" }}}

" {{{ Allow Vim to open binary image files (PNG, JPG,...) as ASCII ART
" See : https://github.com/ashisha/image.vim
" wich happens often to me
" Requires python2 and :
" pip install Pillow
if has('nvim')
  Plugin 'ashisha/image.vim'
endif
" }}}

" {{{ Vim indent guides : Plugin to display indent lines
" Also tried Plugin 'Yggdroot/indentLine' but has issues with conceal usage
" https://github.com/nathanaelkane/vim-indent-guides
Plugin 'nathanaelkane/vim-indent-guides'
let g:indent_guides_auto_colors = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 3
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'startify']
" }}}

" {{{ Allow generating of lorem ipsum
" See : https://www.vim.org/scripts/script.php?script_id=2289
" usage : :Loremipsum
Plugin 'vim-scripts/loremipsum'
" }}}

" {{{ ctrl+P : Plugin to allow fuzzy search of files
" See : https://github.com/kien/ctrlp.vim
Plugin 'ctrlpvim/ctrlp.vim'
" Excluding node_modules folder
" cause it slowdowns ctr-P
" Should  be in local .vimrc but does not work
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|node_modules$\|\.DS_STORE$',
    \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\',
    \ }
" }}}

" {{{ Using snippets in Vim
" in combination with Coc
" dont forget : :CocInstall coc-neosnippet
"
" See https://github.com/Shougo/neosnippet.vim
" and https://github.com/neoclide/coc-sources
Plugin 'Shougo/deoplete.nvim'
if !has('nvim')
  Plugin 'roxma/nvim-yarp'
  Plugin 'roxma/vim-hug-neovim-rpc'
endif
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'
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
" Usage : create a new file with accurate extension (.vue)
" open it and type :Template
Plugin 'aperezdc/vim-template'
" }}}

" {{{ vim-bbye : To close buffer without closing window
" See : https://github.com/moll/vim-bbye
" Command :Bdelete shortcut :Bd
Plugin 'moll/vim-bbye'
" Override standard bd command
abbreviate bd Bdelete
" }}}

" {{{ vim-signature : To displays Vim marks in gutter
" See : https://github.com/kshenoy/vim-signature
Plugin 'kshenoy/vim-signature'
" }}}

" {{{ vim-notes : Plugin to take notes
" See https://github.com/xolox/vim-notes
" usage :
" Nouvelle note : :Note
" Retrouver une note :
" :RecentNotes
Plugin 'xolox/vim-notes'
let g:notes_directories = ['~/Documents/NotesVim']
" Required by plugin vim-notes
Plugin 'xolox/vim-misc'
" Renaming RecentNotes for easier finding
" Rem : navigate using gf
command! NotesRecent RecentNotes
" }}}

" {{{ hardmode : Plugin for Disabling arrows, oh my god...
" Enable it by
" :call HardMode()
Plugin 'wikitopian/hardmode'
let g:HardMode_level="wannabe"
" Always launch hardmode, sic
":call HardMode()
" }}}

" {{{ vim-mdnquery : Plugin to open javascript MDN directly from vim
" See : https://github.com/jungomi/vim-mdnquery
" installation : requires gem install mdn_query
" Usage : overwrites K key for some filetypes (Javascript)
"         or :MdnQuery keyword
Plugin 'jungomi/vim-mdnquery'
autocmd FileType vue setlocal keywordprg=:MdnQuery
" }}}

" {{{ you surround me : Adding surround me to use 's' in commands
" https://github.com/tpope/vim-surround
Plugin 'tpope/vim-surround'
" }}}

" {{{ rainbow_csv : plugin for editing csv tsv formatted files
Plugin 'mechatroner/rainbow_csv'
"}}}

" {{{ editor-config: A plugin for cross editors configuration file
" for compatibility with other developers on other platforms
" See configuration in .editorconfig file
Plugin 'editorconfig/editorconfig-vim'
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
Plugin 'neoclide/coc.nvim', {'pinned': 1}
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
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remad keys for gotos
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

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
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
"Fixing unexpected mapping of ctrl + i (used to come-back front)
if has('nvim')
  nunmap <C-I>
endif
" }}}
" }}}

" {{{ vim-sass-colors : Plugin to colorize color texts in (s)css files
" Also tried following, but does not work on scss variables :
" Plugin 'gko/vim-coloresque'
Plugin 'shmargum/vim-sass-colors'
" }}}

" {{{ vim-prettier Plugin to call Prettier, to format sources (on save)
" See project local configuration in .prettierrc.js
Plugin 'prettier/vim-prettier'
" }}}
"
" {{{ Plugin to simulate ctrl-shift-s
" https://github.com/dyng/ctrlsf.vim
Plugin 'dyng/ctrlsf.vim'
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

" {{{ Rainbow : To display colored parenthesis
" See : https://github.com/luochen1990/rainbow
Plugin 'luochen1990/rainbow'
let g:rainbow_active = 1
" }}}

" {{{ Adding plugin to highlight trailing whitespace
" https://github.com/ntpeters/vim-better-whitespace
" To launch manual stripping of whitespaces :
" :StripWhitespace
Plugin 'ntpeters/vim-better-whitespace'
let g:better_whitespace_filetypes_blacklist=['diff', 'gitcommit', 'unite', 'qf', 'help', 'mail', 'startify', 'git']
"To highlight space characters that appear before or in-between tabs
let g:show_spaces_that_precede_tabs=1
"Enabling stripping on save (with confirmation)
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:startify_change_to_dir=0
" }}}

" {{{ delimitMate : Plugin to auto close brackets, parenthesis
" while typing in insert mode
Plugin 'Raimondi/delimitMate'
" }}}

" {{{ tagbar : Displaying a tag bar on right side
" see https://github.com/majutsushi/tagbar
" Tried exuberant ctags , but did not work
" Replaced by Universal ctags :
" https://ctags.io/
" https://github.com/universal-ctags/ctags
" install with : brew install --HEAD universal-ctags/universal-ctags/universal-ctags
" see also : npm install -g git+https://github.com/ramitos/jsctags.git
Plugin 'majutsushi/tagbar'
set tags=tags
" }}}

" {{{ Markdown plugin
" See https://github.com/plasticboy/vim-markdowns
" Improve display, replace formatting by result for bold and italic
autocmd Filetype markdown setlocal conceallevel=2
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
" }}}

" {{{ calendar : Adding calendar tool in Vim
Plugin 'itchyny/calendar.vim'
let g:calendar_google_calendar = 1
" }}}

" {{{ tcomment_vim : Quick comment uncomment
" see https://github.com/tomtom/tcomment_vim
" Usage : gc<motion>
" gcc for current line
Plugin 'tomtom/tcomment_vim'
"}}}

" {{{ Plugin to generate remark slides
" See https://github.com/mauromorales/vim-remark
" Commands :
" :RemarkBuild
" :RemarkPrview
Plugin 'mauromorales/vim-remark'
" To ease table creation in remark
" https://github.com/dhruvasagar/vim-table-mode
" invoke vim-table-mode’s table mode with <leader>tm
Plugin 'dhruvasagar/vim-table-mode'
let g:table_mode_corner="|"
" }}}

" {{{ Plugin to generate JSDoc
" https://github.com/heavenshell/vim-jsdoc
" Usage :
" :JsDoc
Plugin 'heavenshell/vim-jsdoc'
"To fix neovim issue : unknown command
command! -register JsDoc call jsdoc#insert()
" To allow prompt for filling fields
let g:jsdoc_allow_input_prompt=1
" to enable @access tag
let g:jsdoc_access_descriptions=1
let g:jsdoc_return_type=1
let g:jsdoc_param_description_separator=' - '
" }}}

" {{{ Plugin to use gtd in vim
" See : https://github.com/phb1/gtd.vim
" rem : to delete a task : GtdDelete
Plugin 'phb1/gtd.vim'
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

" Plugin for grammar check
" see : https://github.com/rhysd/vim-grammarous
" NOTE : REQUIRES JAVA 8
"Plugin 'rhysd/vim-grammarous'
command! GrammarousCheckFR :GrammarousCheck --lang=fr

" {{{ Various colorscheme s
"Enables 24-bit RGB color
set termguicolors
"Enable quick switch schemecolor
" Use F8 and shift+F8 to quick switch
Plugin 'xolox/vim-colorscheme-switcher'
:let g:colorscheme_switcher_exclude = ['default', 'blue', 'shine', 'elflord']
"Adding a light theme similar to GitHub
"Usage : :colorscheme github
"See color schemes list : :colorscheme <ctrl+d>
Bundle 'acarapetis/vim-colors-github'
Bundle "nanotech/jellybeans.vim"
"Pencil color theme
Bundle 'reedes/vim-colors-pencil'
" gruvbox : https://github.com/morhetz/gruvbox
Plugin 'morhetz/gruvbox'
" Go dedicated colorscheme
" Bundle 'bitfield/vim-gitgo'
" visual studio code like dark theme
Plugin 'tomasiser/vim-code-dark'
"}}}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"-----------------------END OF VUNDLE CONFIG---------------------
" change default colorscheme
colorscheme gruvbox



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
" SpecialKey is the name of group including spaces,
" ctermfg => color terminal  foreground
" to disable : 'set nolist'
set listchars=tab:>-,trail:.,extends:>,precedes:<,space:.
autocmd FileType vim setlocal list
"highlight SpecialKey ctermfg=DarkGray

" Set the hidden option so any buffer can be hidden (keeping its changes) without first writing the buffer to a file.
" This affects all commands and all buffers.
:set hidden

"Quick file search mapped on F4, opens quickwin window
map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
map <F5> :execute "vimgrep /" . expand("<cWORD>") . "/j **" <Bar> cw<CR>

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

" on entering / leaving insert mode, insert a cursor line and column
" Make cursor more visible in insert mode :
autocmd InsertEnter * set cursorcolumn
autocmd InsertEnter * set cursorline
autocmd InsertLeave * set nocursorcolumn
autocmd InsertLeave * set nocursorline

" Adding live view of substitute command on neovim only
if exists('&inccommand')
  set inccommand=split
endif

" Adding relative numbers
:set number relativenumber

" Add support for comments in jsonc files
autocmd FileType json syntax match Comment +\/\/.\+$+

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
