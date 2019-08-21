" Nicolas Bossard, 28th may 2018, personal syntax for VIM editor
" Saved in git for history and for sharing accross computers.
" As described here : 
" See README.md for configuration.

"---------------------- VUNDLE CONFIG -----------------------

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'posva/vim-vue'
"To have a browser for files on left panel
Plugin 'scrooloose/nerdtree'
" To open file using System from Nerdtree
Plugin 'ivalkeen/nerdtree-execute'
" To show git changed files in Nerdtree
Plugin 'Xuyuanp/nerdtree-git-plugin'
" To display a git info close to line number
Plugin 'airblade/vim-gitgutter'
" To improve status line
Plugin 'vim-airline/vim-airline'
" To open an URL in a browser
" See doc at : https://www.vim.org/scripts/script.php?script_id=3133
" Command : gx
Plugin 'tyru/open-browser.vim'
" To support PlantUml File syntax
Plugin 'aklt/plantuml-syntax'
" To support various lint
Plugin 'dense-analysis/ale'
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
"---------------- ENDOF open-browser config -----------------



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

" To use find command esasily in VIM (requires path to be set)
set path=$PWD/**

" To display spaces and change colors
" SpecialKey is the name of group including spaces, 
" ctermfg => color terminal  foreground
set list listchars=tab:>-,trail:.,extends:>,precedes:<,space:.
highlight SpecialKey ctermfg=DarkGray

" Set the hidden option so any buffer can be hidden (keeping its changes) without first writing the buffer to a file.
" This affects all commands and all buffers.
:set hidden

"Quick file search mapped on F4, opens quickwin window
map <F4> :execute "vimgrep /" . expand("<cWORD>") . "/j **" <Bar> cw<CR>
