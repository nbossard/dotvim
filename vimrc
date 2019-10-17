" Nicolas Bossard, 28Th may 2018, personal syntax for VIM editor
" Saved in git for history and for sharing across computers.
" As described here :
" See README.md for configuration.
"
"Other configs : remapping caps lock key to escape using Karabiner
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

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

" {{{ Startify plugin : To change start screen
" https://github.com/mhinz/vim-startify
Plugin 'mhinz/vim-startify'
" }}}

"syntax highlighting for Vue components.
Plugin 'posva/vim-vue'

"Syntax highlighting for js files
Plugin 'vim-javascript'
let g:javascript_plugin_jsdoc = 1

" {{{ NERDTree configs
" To have a browser for files on left panel
Plugin 'scrooloose/nerdtree'
" To open file using System from NERDTree
Plugin 'ivalkeen/nerdtree-execute'
" To show git changed files in NERDTree
" https://github.com/Xuyuanp/nerdtree-git-plugin
Plugin 'Xuyuanp/nerdtree-git-plugin'
" To display a git info close to line number
Plugin 'airblade/vim-gitgutter'
Plugin 'pseewald/nerdtree-tagbar-combined'
" NERDTree related
" Make NERDTree show hidden files by default
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=0
let NERDTreeAutoCenter=1
let NERDTreeAutoCenterTreshold=8
" }}}

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

" To open an URL in a browser
" See doc at : https://www.vim.org/scripts/script.php?script_id=3133
" Command : gx
Plugin 'tyru/open-browser.vim'

" To support PlantUML File syntax
Plugin 'aklt/plantuml-syntax'

"  {{{ ALE plugin : To support various linters
" ALE = Asynchronous Lint Engine
" See : https://github.com/dense-analysis/ale
" acts as a Vim Language Server Protocol client
Plugin 'dense-analysis/ale'
" changing lint delay from 200ms to ... in order to run less often
let g:ale_lint_delay=3000
" NBO : do not try to enable tsserver on vue files, it does not work
"let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}
"let g:ale_linters = {'vue': ['eslint', 'vls', 'tsserver']}
" Git plugin to embed git command in vim
" }}}

" {{{ Fugitive plugin : to display git log in vim
Plugin 'tpope/vim-fugitive'
"Afugitive addition plugin To display a gitk (git log (history))like in vim
" https://github.com/junegunn/gv.vim
" commands
" :GV
" :GV!
Plugin 'junegunn/gv.vim'
autocmd FileType GV setlocal nolist
autocmd FileType GV setlocal nonumber
autocmd FileType GV setlocal norelativenumber
" }}}

" to allow fuzzy search of files
Plugin 'ctrlpvim/ctrlp.vim'

" to allow usage of templates on new files
Plugin 'aperezdc/vim-template'

" To close buffer without closing window
" Command :Bdelete shortcut :Bd
Plugin 'moll/vim-bbye'

" To displays Vim marks in gutter
" See : https://github.com/kshenoy/vim-signature
Plugin 'kshenoy/vim-signature'

" Plugin to take notes
" See https://github.com/xolox/vim-notes
Plugin 'xolox/vim-notes'
let g:notes_directories = ['~/Documents/NotesVim']
" Required by plugin vim-notes
Plugin 'xolox/vim-misc'

" To edit slack in Vim
Plugin 'yaasita/edit-slack.vim'

" Disabling arrows, oh my god...
" Enable it by
" :call HardMode()
Plugin 'wikitopian/hardmode'
let g:HardMode_level="wannabe"
" Always launch hardmode, sic
":call HardMode()

" To open javascript MDN directly from vim
" See : https://github.com/jungomi/vim-mdnquery
" installation : requires gem install mdn_query
" Usage : overwrites K key for some filetypes (Javascript)
"         or :MdnQuery keyword
Plugin 'jungomi/vim-mdnquery'
autocmd FileType vue setlocal keywordprg=:MdnQuery

" Adding surround me to use 's' in commands
" https://github.com/tpope/vim-surround
Plugin 'tpope/vim-surround'

" For editing csv tsv formatted files
Plugin 'mechatroner/rainbow_csv'

let mapleader=","

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
" coc-html
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
"Fixing unexpected mapping of ctrl + i
nunmap <C-I>
" }}}

"Plugin to format on save
" See configuration in .prettierrc.js
Plugin 'prettier/vim-prettier'

" {{{ Plugin to simulate ctrl shift S
" https://github.com/dyng/ctrlsf.vim
Plugin 'dyng/ctrlsf.vim'
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>
let g:ctrlsf_ignore_dir = ['bower_components', 'node_modules']
let g:ctrlsf_position = 'right'
let g:ctrlsf_winsize = '33%'
let g:ctrlsf_auto_focus = {
    \ "at": "done",
    \ "duration_less_than": 1000
    \ }
" }}}

" To display colored parenthesis
" See : https://github.com/luochen1990/rainbow
Plugin 'luochen1990/rainbow'
let g:rainbow_active = 1

" Adding plugin to highlight trailing whitespace
" https://github.com/ntpeters/vim-better-whitespace
" To launch manual stripping of whitespaces :
" :StripWhitespace
Plugin 'ntpeters/vim-better-whitespace'
let g:better_whitespace_filetypes_blacklist=['diff', 'gitcommit', 'unite', 'qf', 'help', 'mail']

" Adding Golang plugin
Plugin 'fatih/vim-go'
" Installing go-pls : syntax server for GO
" go get golang.org/x/tools/gopls@latest
" Making go-pls included server work for COC
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
autocmd FileType go setlocal foldmethod=syntax
autocmd Filetype go setlocal tabstop=4
autocmd Filetype go setlocal listchars=tab:\|\ 
autocmd Filetype go set list

"Plugin to auto close brackets
Plugin 'Raimondi/delimitMate'

" Displaying a tag bar on right side
" Tried exuberant ctags , but did not work
" Replaced by https://ctags.io/
" see also : npm install -g git+https://github.com/ramitos/jsctags.git
Plugin 'majutsushi/tagbar'
set tags=tags

" Markdown plugin
" See https://github.com/plasticboy/vim-markdowns
" Usage :
" set conceallevel=2
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" Quick comment uncomment
"see https://github.com/tomtom/tcomment_vim
" Usage : gc<motion>
" gcc for currnt line
Plugin 'tomtom/tcomment_vim'

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
" }}}

" {{{ Plugin to use gtd in vim
Plugin 'phb1/gtd.vim'
let g:gtd#default_action = 'inbox'
let g:gtd#default_context = 'work'
let g:gtd#dir = '~/gtd'
let g:gtd#map_browse_older = '<Left>'
let g:gtd#map_browse_newer = '<Right>'
let g:gtd#review = [
  \ '(!inbox + !scheduled-'.strftime("%Y%m%d").') @work',
  \ '!todo @work',
  \ '!waiting @work',
  \ '!archived @work',
  \ ]
" }}}

" {{{ Various colorscheme s
"Adding a light theme similar to GitHub
"Usage : :colorscheme github
"See color schemes list : :colorscheme <ctrl+d>
Bundle 'acarapetis/vim-colors-github'

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

"---------------- open-browser config -----------------
" My setting.
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
"---------------- END OF open-browser config -----------------



" Display line number in left gutter
:set number

" Allow syntax coloring
" Syntax are located in *.vim files, e.g. : "java.vim", try "locate java.vim"
:syntax on

" Highlight result of searches
:set hlsearch
" Search is by default ignorecase
:set ignorecase


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
" :set spell spelllang=fr
" zg => add word
" z= => suggest word

" Excluding node_modules folder
" cause it slowdowns ctr-P
" Should  be in local .vimrc but does not work
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Allow search of currently selected text using //
vnoremap // y/<C-R>"<CR>

" on entering / leaving insert mode, insert a cursor line
autocmd InsertEnter,InsertLeave * set cul!

" Adding live view of substitute command on neovim only
if exists('&inccommand')
  set inccommand=split
endif

" Adding relative numbers in insert mode only
:set number relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

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

" Making vim files be foldable based on markers {{{ and }}}
autocmd FileType vim setlocal foldmethod=marker

