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
" plugin on GitHub repo

" To change start screen
" https://github.com/mhinz/vim-startifyn
Plugin 'mhinz/vim-startify'

"syntax highlighting for Vue components.
Plugin 'posva/vim-vue'
"Syntax highlighting for js files
Plugin 'vim-javascript'
let g:javascript_plugin_jsdoc = 1

"To have a browser for files on left panel
Plugin 'scrooloose/nerdtree'
" To open file using System from NERDTree
Plugin 'ivalkeen/nerdtree-execute'
" To show git changed files in NERDTree
" https://github.com/Xuyuanp/nerdtree-git-plugin
Plugin 'Xuyuanp/nerdtree-git-plugin'
" To display a git info close to line number
Plugin 'airblade/vim-gitgutter'

" To improve status line bar
" https://github.com/vim-airline/vim-airline
Plugin 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1
Plugin 'enricobacis/vim-airline-clock'

" To open an URL in a browser
" See doc at : https://www.vim.org/scripts/script.php?script_id=3133
" Command : gx
Plugin 'tyru/open-browser.vim'
" To support PlantUML File syntax
Plugin 'aklt/plantuml-syntax'
" To support various lint
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
Plugin 'tpope/vim-fugitive'
" to allow fuzzy search of files
Plugin 'ctrlpvim/ctrlp.vim'
" to allow usage of templates on new files
Plugin 'aperezdc/vim-template'
" To close buffer without closing window
" Command :Bdelete shortcut :Bd
Plugin 'moll/vim-bbye'
" To displays marks in gutter
" See : https://github.com/kshenoy/vim-signature
Plugin 'kshenoy/vim-signature'
" Plugin to take notes
" See https://github.com/xolox/vim-notes
Plugin 'xolox/vim-notes'
let g:notes_directories = ['~/Documents/NotesVim']
" To edit slack
Plugin 'yaasita/edit-slack.vim'
" Required by plugin vim-notes
Plugin 'xolox/vim-misc'

" To open javascript MDN directly from vim
" See : https://github.com/jungomi/vim-mdnquery
" installation : requires gem install mdn_query
" Usage : overwrites K key for some filtypes (Javascript)
"         or :MdnQuery keyword
Plugin 'jungomi/vim-mdnquery'
autocmd FileType vue setlocal keywordprg=:MdnQuery

" Adding surround me to use 's' in commands
Plugin 'tpope/vim-surround'

" Adding you complete me for super completion
"Compiled using : -~/.vim/bundle/YouCompleteMe
" ./install.py --go-completer --ts-completer --java-completer
Plugin 'ycm-core/YouCompleteMe'
let mapleader=","
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
" Disabling diagnostic/lint cause ALE already does it
let g:ycm_show_diagnostics_ui = 0
" Disable auto trigger, slowing too much ?
let g:ycm_auto_trigger = 0
" Make you complet me support vue files
" DOES NOT WORK autocmd BufEnter,BufRead *.vue set filetype=vue.javascript
"https://github.com/ycm-core/lsp-examples
Plugin 'ycm-core/lsp-examples'
let g:ycm_keep_logfiles = 1
let g:ycm_log_level = 'debug'
let g:ycm_language_server = [
  \   {
  \     'name': 'yaml',
  \     'cmdline': [ 'node', expand( '$HOME/.vim/bundle/lsp-examples/yaml/node_modules/.bin/yaml-language-server' ), '--stdio' ],
  \     'filetypes': [ 'yaml' ],
  \   },
  \   {
  \     'name': 'json',
  \     'cmdline': [ 'node', expand( '$HOME/.vim/bundle/lsp-examples/json/node_modules/.bin/vscode-json-languageserver' ), '--stdio' ],
  \     'filetypes': [ 'json' ],
  \   },
  \   { 'name': 'kotlin',
  \     'filetypes': [ 'kotlin' ], 
  \     'cmdline': [ expand( '$HOME/.vim/bundle/lsp-examples/kotlin/server/build/install/server/bin/server' ) ],
  \   },
  \   { 'name': 'docker',
  \     'filetypes': [ 'dockerfile' ], 
  \     'cmdline': [ expand( '$HOME/.vim/bundle/lsp-examples/docker/node_modules/.bin/docker-langserver' ), '--stdio' ]
  \   },
  \   { 'name': 'vim',
  \     'filetypes': [ 'vim' ],
  \     'cmdline': [ expand( '$HOME/.vim/bundle/lsp-examples/viml/node_modules/.bin/vim-language-server' ), '--stdio' ]
  \   },
  \   { 'name': 'vue',
  \     'filetypes': [ 'vue' ], 
  \     'cmdline': [ 'vls', '--stdio' ]
  \   },
\ ]

"Plugin to format on save
" See configuration in .prettierrc.js
Plugin 'prettier/vim-prettier'

" Plugin to simulate ctrl shift S
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

" Adding plugin to highlight trailing whitespace
Plugin 'ntpeters/vim-better-whitespace'
let g:better_whitespace_filetypes_blacklist=['diff', 'gitcommit', 'unite', 'qf', 'help']

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

" NERDTree related
" Make NERDTree show hidden files by default
let NERDTreeShowHidden=1

" To Fix backspace not working in insert mode (on Mac ?)
set bs=2

" To use find command easily in VIM (requires path to be set)
set path=$PWD/**

" To display spaces and change colors
" SpecialKey is the name of group including spaces,
" ctermfg => color terminal  foreground
set list listchars=tab:>-,trail:.,extends:>,precedes:<,space:.
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
