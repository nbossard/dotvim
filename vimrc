" Nicolas Bossard, 28Th may 2018, personal syntax for VIM editor
" Saved in git for history and for sharing across computers.
" As described here :
" See README.md for configuration.
" vim: set foldmethod=marker :
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
"---------------------- PACKAGE MANAGER CONFIG -----------------------
" vim-plug replaces Vundle
"vim-plug install :
" https://github.com/junegunn/vim-plug

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

"{{{ ==== Plugins tried and rejected or interesting but given up ======

" {{{ Plugins tried and rejected
" Plug 'psliwka/vim-smoothie' ==> 'Allow more smooth scrolling' ==> too slow
" Plug 'dhruvasagar/vim-zoom' ==> 'toggle zoom of current window within the current tab'
" }}}

" {{{ vim-notes : Plugin to take notes
" See https://github.com/xolox/vim-notes
" usage :
" Nouvelle note : :Note
" Retrouver une note :
" :RecentNotes
" Plug 'xolox/vim-notes'
" let g:notes_directories = ['~/Documents/NotesVim']
" " Required by plugin vim-notes
" Plug 'xolox/vim-misc'
" " Renaming RecentNotes for easier finding
" " Rem : navigate using gf
" command! NotesRecent RecentNotes
" }}}


" {{{ cheat.sh : to search for cheatsheets
" See : https://github.com/dbeniamine/cheat.sh-vim
" Never really used it, cause there is copilot
" Plug 'dbeniamine/cheat.sh-vim'
" }}}

" {{{ editor-config: A plugin for cross editors configuration file
" for compatibility with other developers on other platforms
" See configuration in .editorconfig file
" Currently not used, cause not really needed
" Plug 'editorconfig/editorconfig-vim'
" }}}

" {{{ killersheep : A game, to test popup windows
" See : https://github.com/vim/killersheep
" Usage :Kill
" Plug 'vim/killersheep'
" }}}

" {{{ Plugin to use gtd in vim
" See : https://github.com/phb1/gtd.vim
" rem : to delete a task : GtdDelete
" Plug 'phb1/gtd.vim'
" let g:gtd#default_action = 'inbox'
" let g:gtd#default_context = 'work'
" let g:gtd#dir = '~/gtd'
" let g:gtd#map_browse_older = '<Left>'
" let g:gtd#map_browse_newer = '<Right>'
" let g:gtd#review = [
"   \ '(!inbox + !scheduled-'.strftime("%Y%m%d").') @work',
"   \ '!todo @work',
"   \ '!todo @work #10min',
"   \ '!todo @work #30min',
"   \ '!waiting @work',
"   \ '!archived @work',
"   \ ]
" " to refresh task list : ,re
" let g:gtd#map_refresh = "re"
" autocmd BufWinEnter gtd-results :GtdRefresh
" " Keys to create a nex task : ,gn
" nmap <Leader>gn <Plug>GtdNew
" vmap <Leader>gn <Plug>GtdNew
" abbreviate gtdnew GtdNew
" abbreviate gtdn GtdNew
" "Keys to review tasks
" nmap <leader>gr :GtdReview
" }}}

" {{{ caser
" Easy change from camel case to snake case and others...
" Usage :
" :Snake
" :Camel
" :Kebab
" Plug 'nicwest/vim-camelsnek'
" let g:camelsnek_i_am_an_old_fart_with_no_sense_of_humour_or_internet_culture = 0
" }}}

" {{{ calendar : Adding calendar tool in Vim
" See: https://github.com/itchyny/calendar.vim
" UNUSED and interaction with gmail is falling, so disabled
" Usage :
"   :Calendar
"   :Calendar -view=year -split=vertical -width=27
"       ===> :Cal
" Plug 'itchyny/calendar.vim'
" let g:calendar_google_calendar = 1
" " NBO custom commands
" command Cal Calendar -view=year -split=vertical -width=27
" cabbrev cal Calendar -view=year -split=vertical -width=27
" }}}

" {{{ linediff : vim diff a selection of text
" See : https://github.com/AndrewRadev/linediff.vim
" usage : select a block of line, type ':Linediff', select another block, type ':Linediff'
" UNUSED andd complex to use, so disabled
" Plug 'AndrewRadev/linediff.vim'
"
" Also tried https://github.com/rickhowe/spotdiff.vim
" But was malfunctionning
" }}}

" {{{ hardmode : Plugin for Disabling arrows, oh my god...
" Enable it by
" :call HardMode()
" Plug 'wikitopian/hardmode'
" let g:HardMode_level="wannabe"
" Always launch hardmode, sic
":call HardMode()
" }}}

" " {{{ Plugin to simulate ctrl-shift-s
" UNUSED CAUSE NOW USING ripgrep all the time
" " https://github.com/dyng/ctrlsf.vim
" " tip : to use regular expression type : :CtrlSF -R foo.*
" " tip : to switch to quickfix presentation : M
" Plug 'dyng/ctrlsf.vim'
" "should not work but it does with neovim +iterm
" nmap     <C-S-F> <Plug>CtrlSFPrompt
" nmap     <C-F>f <Plug>CtrlSFPrompt
" vmap     <C-S-F> <Plug>CtrlSFVwordPath
" vmap     <C-F>f <Plug>CtrlSFVwordPath
" vmap     <C-S-F> <Plug>CtrlSFVwordExec
" vmap     <C-F>F <Plug>CtrlSFVwordExec
" nmap     <C-F>n <Plug>CtrlSFCwordPath
" nmap     <C-F>p <Plug>CtrlSFPwordPath
" nnoremap <C-F>o :CtrlSFOpen<CR>
" nnoremap <C-F>t :CtrlSFToggle<CR>
" inoremap <C-F>t <Esc>:CtrlSFToggle<CR>
" let g:ctrlsf_ignore_dir = ['bower_components', 'node_modules', 'dist']
" let g:ctrlsf_position = 'bottom'
" let g:ctrlsf_winsize = '33%'
" let g:ctrlsf_auto_focus = {
"     \ "at": "done",
"     \ "duration_less_than": 1000
"     \ }
" " }}}

" {{{ Plugin to save sessions automatically,
" to be used in combination with startify
" UNUSED so disabled
" Plug 'tpope/vim-obsession'
" }}}

" {{{ Plugin to generate JSDoc
" see: https://github.com/kkoomen/vim-doge
" Usage : ,d then wait a few seconds
" UNUSED cause too slow and too llimited, disabled
" Plug 'kkoomen/vim-doge', { 'do': { -> dogge#install() } }
" TRIED https://github.com/heavenshell/vim-jsdoc but was too limited
" }}}

" {{{ Plugin to run mongodb js files directly from Vim
" https://github.com/tpope/vim-dadbod
" UNUSED cause using command line instead
" Plug 'tpope/vim-dadbod'
" Plug 'kristijanhusak/vim-dadbod-ui'
" let g:dbs = {
" \ 'mongolocal_test': 'mongodb://localhost:27017/test',
" \ }
" let g:db_ui_use_nerd_fonts=0
" let g:db_ui_show_database_icon=0
" let g:db_ui_auto_execute_table_helpers = 1
" }}}
"
" {{{ vim-which-key: plugin to display available keybindings
" UNUSED and complex to configure, removing it
" See doc here : https://github.com/liuchengxu/vim-which-key#minimal-configuration
" Give a try may be to folke/which-key.nvim (neovim only) Plug 'folke/which-key.nvim'
" Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
" Plug 'liuchengxu/vim-which-key'
" " autocmd! User vim-which-key echom 'WhichKey is now lazy loaded!'
" nnoremap <silent> <leader> :<c-u>WhichKey  ','<CR>
" vnoremap <silent> <leader> :<c-u>WhichKeyVisual  ','<CR>
" " Define prefix dictionary
" let g:which_key_map =  {}
" }}}

" " {{{ obsidian.nvim : plugin to edit markdown files in vim using obsidian principles
" UNUSED, no interest? disabling it
" " See : https://github.com/epwalsh/obsidian.nvim
" Plug 'epwalsh/obsidian.nvim', {'for': 'markdown'}
" " Plug 'epwalsh/obsidian.nvim'
" Plug 'nvim-lua/plenary.nvim'
" " }}}

" " {{{ Plugin vim-ghost
" " See: https://github.com/raghur/vim-ghost
" " Edit browser (chrome/firefox) textarea content in Vim/Neovim
" " Usage :GhostStart
" " Go back to browser, click on a textarea then click on ghost plugin icon
" "  Only enabled for Vim 8 (not for Neovim).
" Plug 'roxma/nvim-yarp', v:version >= 800 && !has('nvim') ? {} : { 'on': [], 'for': [] }
" Plug 'roxma/vim-hug-neovim-rpc', v:version >= 800 && !has('nvim') ? {} : { 'on': [], 'for': [] }
" Plug 'raghur/vim-ghost', {'do': ':GhostInstall'}
" autocmd! User vim-ghost echom 'vim-ghost is now lazy loaded!'
" " }}}

" }}}  ==== End of plugins tried and rejected or interesting but given up ======

"{{{ ==== Languages syntax support plugins ======

" {{{ Plugin to support syntax for taskwarrior config files
Plug 'nbossard/vim-taskwarrior-conf', {'for': 'taskrc'}
" }}}

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
" these are test files. Aka cucumber files. Written in Gherkin.
" See : https://github.com/tpope/vim-cucumber
Plug 'tpope/vim-cucumber', {'for': 'cucumber'}
" forked repository to add support for rules
" Plug 'nbossard/vim-cucumber', {'for': 'cucumber', 'branch': 'feature/gherkin_v6_rule_keyword'}
autocmd Filetype cucumber setlocal list
autocmd Filetype cucumber setlocal foldmethod=indent
autocmd Filetype cucumber setlocal tabstop=2
autocmd Filetype cucumber setlocal shiftwidth=2
autocmd Filetype cucumber setlocal softtabstop=2
autocmd Filetype cucumber setlocal expandtab
" }}}

"{{{ Adding support for makefiles
" makefiles have to be tab indented, however they are not valid
autocmd Filetype make set autoindent noexpandtab tabstop=4 shiftwidth=4
"}}}

" {{{ Adding Golang plugin : vim-go
" see : https://github.com/fatih/vim-go
Plug 'fatih/vim-go', {'for': 'go'}
"
" Installing go-pls : syntax server for GO
" normally done by command : 'go get golang.org/x/tools/gopls@latest'
" but in fact installed using homebrew 'brew install gopls',
" this way it is kept up-to-date
"
" Making go-pls included server work for COC
" NBO : disabling pls in vim-go cause conflicts with similar coc-go
" See very good thread here : https://github.com/golang/go/issues/41998
let g:go_gopls_enabled = 0
"Also disabling mapping like gd, cause they are not working as gopls is
"disabled... but go-coc do
let g:go_def_mapping_enabled = 0
"Also disabling mapping like K, cause they are not working as gopls is
"disabled... but go-coc do
let g:go_doc_keywordprg_enabled = 0

"various
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

" To use delve debugger :
" GoDebugstart or GoDebugTest
" GoDebugcontinue
" GoDebugstop
" "<F6> to inspect value of object under cursor

" define alias for my strange memory
command GoTestCoverage GoCoverage

" Define options for gofmt, see vim doc
" -s stands for simplify code
" suggested by linter
let g:go_fmt_options = {
\ 'gofmt': '-s -w',
\ }
" }}}

" {{{ Plugin for coloring gomod files
" https://github.com/maralla/gomod.vim
Plug 'maralla/gomod.vim', {'for': 'gomod'}
" }}}

" {{{ Plugin for .gitignore files
Plug 'gisphm/vim-gitignore', {'for': 'gitignore'}
" }}}

" {{{ plugin to edit fortune files
" https://github.com/ljcooke/vim-fortune
Plug 'ljcooke/vim-fortune', {'for': 'fortune'}
" }}}

" {{{ Plugin for dockerfiles
" See: https://github.com/ekalinin/Dockerfile.vim
Plug 'ekalinin/Dockerfile.vim', {'for': ['Dockerfile','yaml.docker-compose']}
" }}}

" {{{ Jsonc : jsonc type file support
Plug 'neoclide/jsonc.vim', {'for': 'jsonc'}
autocmd BufNewFile,BufRead *.jsonc setlocal filetype=jsonc
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
nmap ,gu <Plug>(GitGutterUndoHunk)
nmap ghn <Plug>(GitGutterNextHunk)
nmap ghp <Plug>(GitGutterPrevHunk)
nmap ,gh <Plug>(GitGutterPreviewHunk)
nmap ,gdd :let g:gitgutter_diff_base = 'develop'<bar>:GitGutter<CR>
nmap ,gdm :let g:gitgutter_diff_base = 'master'<bar>:GitGutter<CR>
nmap ,gdh :let g:gitgutter_diff_base = 'head'<bar>:GitGutter<CR>

" Adding line number highlight by default
let g:gitgutter_highlight_linenrs = 1
" main commandes :
" ]h or [h --> next hunk
" ,gn or ,gp --> next hunk
" ,hp --> display hunk change
" ,hs --> stage hunk (add hunk to staging area)
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
"A fugitive addition plugin To display a gitk (git log (history))like in vim
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

" When editing a git commit message (.git/COMMIT_EDITMSG)
" you often won't start on the first line due to Vim remembering your last position in that file
" Fix for this:
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
" disable whitespace mix checking in git commit messages
autocmd FileType gitcommit silent! call airline#extensions#whitespace#disable()


" }}} === End of Git related plugins ====

" {{{ firenvim : plugin to edit textareas in firefox with neovim
" See : https://github.com/glacambre/firenvim
" see: https://github.com/glacambre/firenvim#configuring-firenvim
" Issue : Text is too small ? change size, see set guifont below (suggestion : h24)
if has('nvim')
  Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

  " disable firenvim for some websites
  " rem : needs restart of the browser
  if exists('g:started_by_firenvim')
    let fc = g:firenvim_config['localSettings']
    let fc['https?://[^/]+\.google\.com/'] = { 'takeover': 'never', 'priority': 1 }
    " vim edition is lost in taiga
    let fc['https?://taiga\.tech\.orange/'] = { 'takeover': 'never', 'priority': 1 }
    let fc['https?://teams\.microsoft\.com/'] = { 'takeover': 'never', 'priority': 1 }
    let fc['https?://chat\.openai\.com/'] = { 'takeover': 'never', 'priority': 1 }
  endif
endif
" }}}

" {{{ Copilot
" See: https://github.com/github/copilot.vim
" And: https://copilot.github.com/
Plug 'github/copilot.vim'
" configuring alternate suggestions
imap <C-n> <Plug>(copilot-next)
imap <C-p> <Plug>(copilot-previous)
let g:copilot_filetypes = {
      \ 'markdown': v:true,
      \ 'yaml': v:true,
      \ 'gitcommit': v:true,
      \ }
" }}}

" {{{ Startify plugin : To change start screen (welcome page)
" https://github.com/mhinz/vim-startify
Plug 'mhinz/vim-startify'
if exists('g:started_by_firenvim')
    let g:startify_disable_at_vimenter = 1
endif
let g:startify_files_number = 5
let g:startify_commands = [
    \ ['NERDTree', ':NERDTree'],
    \ ['Vim Reference', 'h ref'],
    \ ]
let g:startify_lists = [
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ ]
" let g:startify_custom_header = g:ascii + startify#fortune#boxed('', '═','║','╔','╗','╝','╚')
" Using own bases of fortunes as suggested here : https://sudonull.com/post/105462-Configure-Vim-Start-Screen
" following constant will be used by projects
let g:fortune = map(split(system('fortune ~/.vim ~/.vim/plugged/vimtips-fortune/fortunes | cowsay'), '\n'), '"   ". v:val')
" }}}

" {{{ Vim-test : plugin for launching tests inside vim
"see https://github.com/vim-test/vim-test
"usage : testFile
Plug 'vim-test/vim-test', { 'on': ['TestFile','TestLast','TestNearest']}
autocmd! User vim-test echom 'vim-test is now lazy loaded!'
"let g:test#runner_commands = ['Mocha']
let test#javascript#jest#executable = './node_modules/.bin/vue-cli-service test:unit'
let test#javascript#jest#options = {
  \ 'nearest': '',
  \ 'file':    '',
  \ 'suite':   '',
\}
" To run fuzzy testing 
" let test#go#gotest#options = {
"   \ 'nearest': '-run Test -fuzz',
"   \ 'file':    '-fuzz',
"   \ 'suite':   '-fuzz',
" \}
cabbrev te TestFile
cabbrev tf TestFile
" See also Mahali project vimrc config file

" prevent neovim from closing terminal straight away
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    au TermOpen  * setlocal nonumber | startinsert
    au TermClose * setlocal   number | call feedkeys("\<C-\>\<C-n>")
endif

" Prevent vim from closing straight away
if !has('nvim')
    let test#strategy = "vimterminal"
endif
"}}}

" {{{ vim-translator : Plugin for translating between human languages
" See: https://github.com/voldikss/vim-translator
" usage: no default mapping, use commands
" :Translate <== translate selected text to default language (english)
" or :TranslateR <==  <== translate and replace  selected text to default language (english)
Plug 'voldikss/vim-translator', { 'on': ['Translate', 'TranslateR'] }
autocmd! User vim-translator echom 'vim-translator is now lazy loaded!'
" Changing default target language from chinese to english
let g:translator_target_lang='en'
" As I am a french guy, I find these addditional commands useful
" Note the -range and <line1> <line2> to mark the selectedd text
" See : https://stackoverflow.com/questions/29495291/apply-vim-user-defined-command-to-visual-selection-or-all
command -range TranslateToFR <line1>,<line2>Translate --target_lang=fr
command -range TranslateRToFR <line1>,<line2>TranslateR --target_lang=fr
" Useful in Mahali project
command -range TranslateToMG <line1>,<line2>Translate --target_lang=mg
command -range TranslateRToMG <line1>,<line2>TranslateR --target_lang=mg
" }}}

" {{{ ===== NERDTree related configs =====
"
" TODO : study new alternatives to NERDTree :
" - https://github.com/lambdalisue/fern.vim
" - https://github.com/weirongxu/coc-explorer
"
" Nerdtree is a must have plugin, to have a browser for files on left panel
" This plugin is replacing default file browser netrw
" (netrw can be launched with :Lexplore)
Plug 'preservim/nerdtree'
" Nerdtree plugin has plugins (sic)
" Plugin-plugin to open file using System from NERDTree
" Plug 'ivalkeen/nerdtree-execute' ==> removed, duplicate with menu/open, and
" takes lot of time at startup
" Plug-plugin To show git changed files in NERDTree
" https://github.com/Xuyuanp/nerdtree-git-plugin
Plug 'Xuyuanp/nerdtree-git-plugin'
" Plugin to add coloring on devicons (see below)
" https://github.com/tiagofumo/vim-nerdtree-syntax-highlight
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Plugin that adds a menu item to open the selected folder in Mac OS X Terminal
" https://github.com/mortonfox/nerdtree-term
Plug 'mortonfox/nerdtree-term'
" NERDTree related config
" Make NERDTree show hidden files by default
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=0
autocmd FileType nerdtree setlocal nonumber
autocmd FileType nerdtree setlocal norelativenumber
let NERDTreeAutoCenter=1
let NERDTreeAutoCenterTreshold=8
" Hide some files
let NERDTreeIgnore=['\.swp','\.DS_Store']
" Add mapping for 'nerdtree find' : gnf
" rem function! where ! means overwrite if already exists
function! NERDTreeShowMeFile()
  :NERDTreeFind
  :normal zz
  :normal o
endfunction
map gnf :call NERDTreeShowMeFile()<CR>zz
map gnF :NERDTreeFind<CR>zz

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
" disabling on nerdtree cause too small to be readable
let g:airline#extensions#nerdtree_statusline = 0

" various airline bar themes
Plug 'vim-airline/vim-airline-themes'
" }}}

" {{{ open-browser : Plugin to open URL under cursor in an external browser
" See doc at : https://www.vim.org/scripts/script.php?script_id=3133
" Addditional commands added by me:
" - OpenInGitlab / RevealInGitlab
" - OpenInGitHub / RevealInGitHub
" Command : gx
Plug 'tyru/open-browser.vim'
" My setting.
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
" Additional command "OpenBrowserCurrent" to Open current file in browser
command! OpenBrowserCurrent execute "OpenBrowser" "file:///" . expand('%:p:gs?\\?/?')
" open regular expression test website
command! RegEx101 OpenBrowser https://regex101.com
" open current file in gitlab
let reponame = substitute(system("basename `git rev-parse --show-toplevel`"), '\n\+$', '', '')
if reponame == "documentation"
  let branchname = "master"
else
  let branchname = "develop"
endif
command! OpenInGitlab execute "OpenBrowser" "https://gitlab.tech.orange/mahali/" . reponame . "/-/tree/" . branchname . "/" . fnamemodify(expand("%"), ":~:.")
command RevealInGitlab OpenInGitlab

" open current file in github
command! OpenInGitHub execute "OpenBrowser" "https://github.com/nbossard/dotvim/blob/master/" . fnamemodify(expand("%"), ":~:.")
" }}}
command RevealInGitHub OpenInGitHub

" {{{ vim-peekaboo : plugin to display the list of registers
" on a right bar on " or @ keypress
" See : https://github.com/junegunn/vim-peekaboo
Plug 'junegunn/vim-peekaboo'
" }}}

" {{{ vim-dirdiff : plugin to compare files in two directories recursively
" usage : :DirDiff <dir1> <dir2>
" See: https://github.com/will133/vim-dirdiff
Plug 'will133/vim-dirdiff', { 'on': ['Dirdiff'] }
" }}}

" {{{ unicode : to show unicode (and digraph) tables and search
" such as smileys, emojis, emoticons...chars allowed by UTF-8.
" Usage :UnicodeTable
" See : https://github.com/chrisbra/unicode.vim
Plug 'chrisbra/unicode.vim'
command! UnicodeGreenCheckbox :norm a✅
command! UTF8GreenCheckbox UnicodeGreenCheckbox

command! UnicodeRedCross :norm a❌
command! UTF8RedCross UnicodeRedCross

command! UnicodeQuestionRed :norm a❓
command! UTF8QuestionRed UnicodeQuestionRed

command! UnicodeBomb :norm a💣
command! UTF8Bomb UnicodeBomb

command! UnicodeWarning :norm a⚠
command! UTFWarning UnicodeWarning
"}}}

" {{{ ALE plugin : To support various linters
" ALE = Asynchronous Lint Engine
" See : https://github.com/dense-analysis/ale
" acts as a Vim Language Server Protocol client
"
" NBOSSARD : prototype to support ghelkin-lint
" Plug 'nbossard/ale', {'branch': 'feature/support_gherkin-lint'}
Plug 'dense-analysis/ale'
"
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
"
" NOTE : ALE is used by vim-go, see vim-go for go related configuration


" For markdown lint ALE relies on markdownlint
" https://github.com/DavidAnson/markdownlint
"
" For yaml lint ALE relies on yamllint
" and spectral : npm install -g @stoplight/spectral-cli
"
" For golangci-lint, see  dedicated config file '.golangci.yml' at root of project
" staticcheck is used to detect dead code especially in godog source files.
let g:ale_linters = {
  \ 'go':   ['golint', 'go vet', 'golangci-lint', 'staticcheck'],
  \ 'yaml': ['yamllint', 'spectral']
  \ }
" adding ale linter 'gherkin-ling' for cucumber files,
" see nbossard prototype above
" g:ale_linters.cucumber = ['gherkin-lint']

" Disable ALE for copilot solution proposal file
" opened when typing :Copilot
autocmd filetype copilot.go let b:ale_enabled=0

" }}}

"{{{ BufOnly : Closes all buffers but this one
" see : https://github.com/vim-scripts/BufOnly.vim
" usage : :BufOnly
Plug 'vim-scripts/BufOnly.vim', { 'on': 'BufOnly' }
autocmd! User BufOnly.vim echom 'BufOnly is now lazy loaded!'
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
Plug 'vim-scripts/loremipsum', { 'on': 'Loremipsum' }
autocmd! User loremipsum echom 'loremipsum is now lazy loaded!'
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
nmap <c-p> :echo "Calling ':FzfFiles', also try classic way ':find toto\<TAB\>'" <bar> :FzfFiles<CR>
" add a prefix Fzf to all commands
let g:fzf_command_prefix = 'Fzf'
" Always enable preview window on the right with 60% width
let g:fzf_preview_window = 'right:60%'

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" Customizable extra key bindings for opening selected files in different ways
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

" NOTE : excluding of some files is done based on git-ignore
" And this is defined by setting environment variable FZF_DEFAULT_COMMAND
" in .zshrc file

"Adding shortcut for fzfrg
abbreviate frg FzfRg
nmap <c-f> :echo "Calling ':FzfRg', also try more classic way ':Rg toto'" <bar> :FzfRg<CR>
nmap <C-S-F> :echo "Calling ':FzfRg', also try more classic way ':Rg toto'" <bar> :FzfRg<CR>

"}}}


" {{{ Using snippets in Vim
" in combination with Coc
" dont forget : :CocInstall coc-neosnippet
"
" to jump : <C-J> (in insert mode)
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
 "
 " NBO : adding my own snippets directory
 let g:neosnippet#snippets_directory='~/.vim/nbo_snippets'
" }}}

" Tested and removed : twilight : disable unused part of code to ease
" readability See : https://github.com/folke/twilight.nvim
" Gave up as in fact folding is better.

" {{{ vim-bbye : To close buffer without closing window
" See : https://github.com/moll/vim-bbye
" Command :Bdelete shortcut :Bd
Plug 'moll/vim-bbye', { 'on': ['Bdelete'] }
autocmd! User vim-bbye echom 'vim-bbye is now lazy loaded!'
" Define a similar to bd command
abbreviate bdd Bdelete
" }}}

" {{{ vim-signature : To displays Vim marks in gutter
" See : https://github.com/kshenoy/vim-signature
Plug 'kshenoy/vim-signature'
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
" Ìn visual mode use : S
" cs'" ==> change surrounding ' for "
Plug 'tpope/vim-surround'
" }}}

" {{{ rainbow_csv : plugin for editing csv tsv formatted files
" https://github.com/mechatroner/rainbow_csv
" useful commands :
" :RainbowAlign
" :Select a1,a4 order by a11
Plug 'mechatroner/rainbow_csv', {'for': 'csv'}
" removing line wrapping on csv
autocmd filetype csv setlocal nowrap
" }}}

" {{{ ====== Completion in Vim : ====
" Tested and removed 'deoplin' for completion
" Tested and removed YCM : 'you complete' me for super completion

" {{{ Plugin for completion : COC
" https://github.com/neoclide/coc.nvim
" INSTALL : then switch to branch release
"
" NOTE THAT THEY ARE USING 'release' branch
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"
" INSTALL : then run :
"
" https://github.com/neoclide/coc-tsserver
" Support of typescript
" :CocInstall coc-tsserver
let g:coc_global_extensions = ['coc-tsserver']
"
" https://github.com/neoclide/coc-eslint
" Javascript linter
" :CocInstall coc-eslint
"
" https://github.com/neoclide/coc-json
" Json language server
" Allows to use json schema for completion in json files.
" e.g. in coc-settings.json
" :CocInstall coc-json
let g:coc_global_extensions += ['coc-json']
"
" Coc prettier IS USELESS
" CAUSE THERE IS ALREADY https://github.com/prettier/vim-prettier
" :CocInstall coc-prettier
"
" :CocInstall coc-css
let g:coc_global_extensions += ['coc-css']
"
" https://github.com/neoclide/coc-vetur
" Vue language server extension ==> deprecated, use volar for Vue3
" :CocInstall @yaegassy/coc-volar
" :CocInstall coc-vetur
let g:coc_global_extensions += ['@yaegassy/coc-volar']
" let g:coc_global_extensions += ['@yaegassy/coc-volar-tools']
"
" :CocInstall coc-dictionary
"
" Emmet is already included in coc-vetur, but not in HTML so adding it
" :CocInstall coc-emmet
" let g:coc_global_extensions += ['coc-emmet']
"
" :CocInstall coc-html
" See https://github.com/neoclide/coc-html
" Note options are set in coc-settings.json
let g:coc_global_extensions += ['coc-html']
"
" :CocInstall coc-markdownlint
" 2023-10-19 MarkdownLint is already provided by ALE
" let g:coc_global_extensions += ['coc-markdownlint']
"
" :CocInstall coc-vimlsp
" See https://github.com/iamcco/coc-vimlsp
let g:coc_global_extensions += ['coc-vimlsp']
"
" See https://github.com/neoclide/coc-yaml
" :CocInstall coc-yaml
let g:coc_global_extensions += ['coc-yaml']

" See https://github.com/josa42/coc-docker
" :CocInstall coc-docker
let g:coc_global_extensions += ['coc-docker']
"
" SH language server extension using bash-language-server for coc.nvim
" See : https://github.com/josa42/coc-sh
" :CocInstall coc-sh
let g:coc_global_extensions += ['coc-sh']
"
" Pyright is a full-featured, standards-based static type checker for Python.
" See: https://github.com/fannheyward/coc-pyright
" See: https://github.com/microsoft/pyright
" :CocInstall coc-pyright
let g:coc_global_extensions += ['coc-pyright']
"
" Tabnine : IA local computer based completion
" See: https://github.com/neoclide/coc-tabnine
" NBO : disabled on 2023-06-21 cause mac warning popup about not certified
"       CocUninstall coc-tabnine
" let g:coc_global_extensions += ['coc-tabnine']
"
" :CocInstall coc-go
let g:coc_global_extensions += ['coc-eslint', 'coc-css', 'coc-dictionary', 'coc-markdownlint',  'coc-go']

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

" configs
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
"
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" bug turn around : most terminals send <NUL> for Ctrl-space
inoremap <silent><expr> <Nul> coc#refresh()

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" Use `[c` and `]c` to navigate diagnostics
nmap <silent> gcp <Plug>(coc-diagnostic-prev)
nmap <silent> gcn <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gri :call CocAction("showIncomingCalls")<CR>
nmap <silent> gro :call CocAction("showOutgoingCalls")<CR>

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" NBO : Mapping ctrl+k to show signature in insert mode
" This is done to force signature display when not opened automatically by
" typing '('
inoremap <silent> <C-K> <C-r>=CocActionAsync('showSignatureHelp')<CR>

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

" Note : configuration of diagnostic display messages is done in coc-settings.json

"**************** end of Coc suggested configuration *****************
" }}}
" }}}

" {{{ vim-sass-colors : Plugin to colorize color texts in (s)css files
" Also tried following, but does not work on scss variables :
" Plug 'gko/vim-coloresque'
Plug 'shmargum/vim-sass-colors', { 'for': ['sass', 'scss'] }
" }}}

" {{{ vim-prettier : plugin to call Prettier, to format sources (on save)
" See : https://github.com/prettier/vim-prettier
" A vim plugin wrapper for prettier, pre-configured with custom default prettier settings
" By default it will auto format javascript, typescript, less, scss, css, json, graphql
" and markdown files if they have/support the "@format" pragma annotation in the header of the file.
"
" See project local configuration in .prettierrc.js
Plug 'prettier/vim-prettier', {
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'vue', 'svelte', 'yaml', 'html'] }
" Enable auto formatting of files that have "@format" or "@prettier" tag in header
let g:prettier#autoformat = 1
" }}}

" {{{ vim-multiple-cursors : Plugin for multiple cursors
" see : https://github.com/mg979/vim-visual-multi
" Originally to use with ctrlsf to change multiple words at a time
" usage : press ctrl-n n n
" or q to skip current
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

" {{{ Plugin vim-expand-region
" See : https://github.com/terryma/vim-expand-region
" usage : v to expand/increase selection, ctrl-v to reduce
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'terryma/vim-expand-region'
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
" special expand config for golang
let g:expand_region_textobj_go = {
      \ 'iw'  :0,
      \ 'iW'  :0,
      \ 'i"'  :0,
      \ 'i''' :0,
      \ 'i]'  :1,
      \ 'ib'  :1,
      \ 'iB'  :1,
      \ 'il'  :0,
      \ 'ip'  :0,
      \ 'if'  :0,
      \ 'af'  :0,
      \ }
" }}}

" {{{ Adding plugin to highlight trailing whitespace
" https://github.com/ntpeters/vim-better-whitespace
" To launch manual stripping of whitespaces :
" :StripWhitespace
Plug 'ntpeters/vim-better-whitespace'
let g:better_whitespace_filetypes_blacklist=['diff', 'gitcommit', 'unite', 'qf', 'help', 'mail', 'startify', 'git', 'taskedit', 'csv', 'minimap']
"To highlight space characters that appear before or in-between tabs
let g:show_spaces_that_precede_tabs=1
" To enable highlighting of trailing whitespace
let g:better_whitespace_enabled=1
"Enabling stripping on save (with confirmation)
let g:strip_whitespace_on_save=1
let g:startify_change_to_dir=0
" Note that overwriting this with a b: is ignored
let g:strip_whitespace_confirm=0
" }}}

" {{{ delimitMate : Plugin to auto close brackets, parenthesis, quotes
" while typing in insert mode
" See : https://github.com/Raimondi/delimitMate
" Rem : not responsible for HTML tags, it is coc-html
Plug 'Raimondi/delimitMate'
" Disabled on HTML files cause that disturbs copilot
autocmd FileType htm let b:loaded_delimitMate = 0
" Disabled on single quotes in plantuml cause quotes are used for comments
autocmd FileType plantuml let b:delimitMate_quotes = "\""
" }}}

" {{{ tagbar : Displaying a tag bar on right side
" see https://github.com/majutsushi/tagbar
" Relies on external tag generator :
" Tried exuberant ctags, but did not work
" Replaced by Universal ctags :
" https://ctags.io/
" https://github.com/universal-ctags/ctags
" install with : brew install --HEAD universal-ctags/universal-ctags/universal-ctags
" see also : npm install -g git+https://github.com/ramitos/jsctags.git
Plug 'majutsushi/tagbar'
" NOT USING lazy loading for tagbar, cause it interfers with autoopening
cabbrev tagbar Tagbar
set tags=tags
" If you use multiple tabs and want Tagbar to also open in the current tab when
" you switch to an already loaded, supported buffer:
if exists('g:started_by_firenvim')
  " do nothing
else
  autocmd BufEnter * nested :call tagbar#autoopen(0)
endif

" show a preview window on top of screen (ugly)
let g:tagbar_autopreview = 0
" do not sort alphabetically
let g:tagbar_sort = 0
" Extending, see wiki : https://github.com/preservim/tagbar/wiki
" and :help tagbar-extend
" Adding support of YAML files by tagbar
" ...at least anchors
let g:tagbar_type_yaml = {
    \ 'ctagstype' : 'yaml',
    \ 'kinds' : [
        \ 'a:anchors',
        \ 's:section',
        \ 'e:entry'
    \ ],
  \ 'sro' : '.',
    \ 'scope2kind': {
      \ 'section': 's',
      \ 'entry': 'e'
    \ },
    \ 'kind2scope': {
      \ 's': 'section',
      \ 'e': 'entry'
    \ },
    \ 'sort' : 0
    \ }
" Adding support of cucumber files by tagbar
" ...at least scenarios, generated by me
" https://github.com/preservim/tagbar/wiki#cucumber
" and
" /Users/nbossard/.ctags.d/cucumber.ctags
let g:tagbar_type_cucumber = {
    \ 'ctagstype' : 'cucumber',
    \ 'kinds' : [
	\ 'b:background',
	\ 'r:rule',
	\ 's:scenario',
	\ 'o:scenariooutline',
    \ ],
    \ 'sort' : 0
    \ }
"  changing display for proto files, to hide fields
let g:tagbar_type_proto ={
    \ 'kinds' : [
      \ 'p:package',
      \ 'm:message',
      \ 's:service',
      \ 'r:rpc'
    \ ]
  \ }
" Changing display for golang, folding imports, renaming
let g:tagbar_type_go ={
    \ 'kinds' : [
      \ 'p:packages:0:0',
      \ 'i:imports:1:0',
      \ 'c:constants:0:0',
      \ 's:structs:0:1',
      \ 'w:struct fields:0:0',
      \ 'm:struct methods:0:0',
      \ 't:types:0:1',
      \ 'f:functions:0:1',
      \ 'v:variables:0:0',
      \ 'n:TODO:0:0',
      \ 'e:TODO2:0:0',
    \ ]
  \ }
" Position the (global) quickfix window at the very bottom of the window
" (useful for making sure that it appears underneath tagbar splits)
" NOTE: Using a check here to make sure that window-specific location-lists
" aren't effected, as they use the same `FileType` as quickfix-lists.
autocmd FileType qf if (getwininfo(win_getid())[0].loclist != 1) | wincmd J | endif
"
" }}}

" {{{ File-line : plugin
" Allow opening a filename with line number
" See https://github.com/bogado/file-line
Plug 'bogado/file-line'
" }}}

" {{{ vim-markdown plugin for syntax and folding
" See https://github.com/preservim/vim-markdown
" Improve display, replace formatting by result for bold and italic
autocmd Filetype markdown setlocal conceallevel=2
Plug 'godlygeek/tabular', { 'for': 'markdown' }
Plug 'preservim/vim-markdown', { 'for': 'markdown' }
" Enable color column for markdown files
"autocmd Filetype markdown setlocal highlight ColorColumn ctermbg=darkmagenta guibg=darkmagenta
autocmd Filetype markdown setlocal colorcolumn=80
" Allow coloring of fenced blocks
let g:vim_markdown_fenced_languages = ['javascript', 'typescript', 'sh', 'go']
" NOTE :
" Format at a maximum width using ':gq'
" NOTE :
" View result in browser using :OpenBrowserCurrent
" }}}

" {{{ speeddating : Allow intelligent increase of dates
" See https://github.com/tpope/vim-speeddating
" Usage : traditional <C-X> or <C-A>
Plug 'tpope/vim-speeddating'
" }}}

" {{{ Extended for customise : vim-CtrlXA
" Booleans and many more : yes /no, enable/disable, git rebase,
" see : https://github.com/Konfekt/vim-CtrlXA
" Usage : traditional <C-X> or <C-A>
" See also vim-speeddating above
Plug 'Konfekt/vim-CtrlXA'
nmap <Plug>SpeedDatingFallbackUp   <Plug>(CtrlXA-CtrlA)
nmap <Plug>SpeedDatingFallbackDown <Plug>(CtrlXA-CtrlX)

" NBO CANT MAKE THIS WORK !!!! SO USING ADDITIONAL RULES PER FILETYPE
augroup VimAfterCtrlXA
    autocmd!
    autocmd VimEnter let g:CtrlXA_Toggles = [
    \ ['Nicolas', 'James'],
    \ ['BOSSARD', 'ZHIHONG_GUO'],
    \ ['janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'],
    \ ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'],
    \ ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
    \ ] + g:CtrlXA_Toggles
augroup END

" additional rules for javascript
autocmd FileType javascript
      \ let b:CtrlXA_Toggles = [
      \ ['DOIT','SKIPIT'],
      \ ['FAKE','DOCHANGES'],
      \ ['us','task'],
      \ ['POST','GET', 'PUT', 'DELETE'],
      \ ] + g:CtrlXA_Toggles

" additional rules for feature files
autocmd FileType cucumber
      \ let b:CtrlXA_Toggles = [
      \ ['Given', 'When', 'Then', 'And', 'But'],
      \ ] + g:CtrlXA_Toggles

" additional rules for rest files
autocmd FileType rest
      \ let b:CtrlXA_Toggles = [
      \ ['GET', 'POST', 'PUT', 'DELETE'],
      \ ] + g:CtrlXA_Toggles
" }}}

" additionnal rules for taskedit files
autocmd FileType taskedit
      \ let b:CtrlXA_Toggles = [
      \ ['janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'],
      \ ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'],
      \ ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
      \ ] + g:CtrlXA_Toggles

" {{{ tcomment_vim : Quick comment uncomment
" see https://github.com/tomtom/tcomment_vim
" Usage : gc<motion>
" gcc for current line
Plug 'tomtom/tcomment_vim'
"}}}

" {{{ scrollbar : display a scrollbar on the right for info (not for clicking)
" See : https://github.com/Xuyuanp/scrollbar.nvim
" Rem : Does not work on vim, only for neovim
if has('nvim')
  Plug 'Xuyuanp/scrollbar.nvim'
  let g:scrollbar_excluded_filetypes = ['nerdtree', 'tagbar']
  " See also completed elsewhere
  " Suggested configuration by plugin website
  augroup ScrollbarInit
    autocmd!
    autocmd WinScrolled,VimResized,QuitPre * silent! lua require('scrollbar').show()
    autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
    autocmd WinLeave,BufLeave,BufWinLeave,FocusLost            * silent! lua require('scrollbar').clear()
  augroup END
endif
" }}}

" {{{ minimap: display a right-side minimap
" See : https://github.com/wfxr/minimap.vim
" requires brew install code-minimap
Plug 'wfxr/minimap.vim'
" No lazy loading, as it is not working with autoopen
" recommanded configuration
let g:minimap_width = 10
" If set to `1`, the minimap window will show on startup.
if exists('g:started_by_firenvim')
  let g:minimap_auto_start = 0
else
  let g:minimap_auto_start = 1
endif
let g:minimap_auto_start_win_enter = 0
let g:minimap_highlight_search = 1
let g:minimap_highlight_range = 1
let g:minimap_git_colors = 1
" NBO custom config
" Disable minimap for specific file types.
let g:minimap_block_filetypes = ['fugitive', 'nerdtree', 'fzf', 'help', 'markdown', 'tagbar']
" Close minimap for specific file types.  If a filetype listed here is also
" present in `g:minimap_block_filetypes`, the minimap will prefer to close
" rather than disable.
let g:minimap_close_filetypes = ['startify', 'netrw', 'vim-plug', 'terminal']
" Disable minimap for specific buffer types.
let g:minimap_close_buftypes = ['json','help']
" }}}

" {{{ Plugin to generate remark slides
" See https://github.com/mauromorales/vim-remark
" Commands :
" :RemarkBuild
" :RemarkPrview
Plug 'mauromorales/vim-remark', {'for': 'markdown'}
" }}}

" {{{ To ease table creation in remark
" https://github.com/dhruvasagar/vim-table-mode
" invoke vim-table-mode’s table mode with <leader>tm
" enter | twice to write a properly formatted horizontal line
Plug 'dhruvasagar/vim-table-mode', {'for': 'markdown'}
let g:table_mode_corner="|"
" }}}

" {{{ Plugin jacinto can be used to validate json files
" see: https://github.com/alfredodeza/jacinto.vim
" usage :Jacinto validate
Plug 'https://github.com/alfredodeza/jacinto.vim', { 'for': 'json' }
" }}}

" {{{ vim-grammarous : Plugin for grammar check, in addition to spell
" see : https://github.com/rhysd/vim-grammarous
" NOTE : REQUIRES JAVA 8
" Usage : :GrammarousCheck
Plug 'rhysd/vim-grammarous'
let g:grammarous#default_comments_only_filetypes = {
            \ '*' : 1, 'help' : 0, 'markdown' : 0,
            \ }
command! GrammarousCheckFR :GrammarousCheck --lang=fr
" }}}

" {{{ vim-conflicted : Plugin for efficiently use vim with mergetool
"See https://github.com/christoomey/vim-conflicted
" usage (out of vim) : git mergetool
" or : git conflicted
Plug 'christoomey/vim-conflicted'
" Adding info in statusline
set stl+=%{ConflictedVersion()}
" }}}

" {{{ yaml-vim : Plugin to support yaml file format
" https://github.com/mrk21/yaml-vim
" Plug 'mrk21/yaml-vim', {'for': 'yaml'}
" Additional configuration for yaml files
autocmd FileType yaml set foldmethod=indent
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

" {{{ try again splitjoin plugin
" See : https://github.com/AndrewRadev/splitjoin.vim
" usage : gS gJ
Plug 'AndrewRadev/splitjoin.vim', {'for': ['go', 'md', 'javascript', 'yaml', 'json']}
" changing mapping from gS to,S and gJ to ,J
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
nmap <Leader>j :SplitjoinJoin<cr>
nmap <Leader>s :SplitjoinSplit<cr>
" }}}

" {{{ mundo : Plugin for displaying undo tree
" https://github.com/simnalamburt/vim-mundo
" Usage : https://simnalamburt.github.io/vim-mundo/
" Usage: :MundoToggle or :MundoShow
Plug 'simnalamburt/vim-mundo', {'on': ['MundoToggle', 'MundoShow']}
autocmd! User vim-mundo echom 'Mundo is now lazy loaded!'
" }}}

" {{{ vim-base64
" https://github.com/christianrondeau/vim-base64
" Usage : select then
" <leader>atob   ===> to convert from base 64 to string
"  or
" <leader>btoa   ===> to convert from string to base 64
Plug 'christianrondeau/vim-base64'
""}}}

" {{{ cheatsheet / reminder / aide-mémoire
" See : https://github.com/adambard/learnxinyminutes-docs
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
command! LearnXInMinutes call HelpLearnXInMinutes(&filetype)
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
" Note : By default, ripgrep will respect gitignore rules and automatically skip hidden files/directories and binary files
Plug 'jremmen/vim-ripgrep', {'on': ['Rg']}
autocmd! User vim-ripgrep echom 'Ripgrep is now lazy loaded!'
" config -vimgrep : to display multiple results in the same line in multiple
" line in quickfix
" config -S : to use smart casing syntax (minuscule means minuscule or majuscule)
"
" Will search from current dir, to search from another use :RgRoot
let g:rg_command = 'rg --vimgrep -S'
cabbrev rg Rg
" }}}

" {{{ Asyncrun
" See: https://github.com/skywind3000/asyncrun.vim
" Required by vim-ripgrep
" Usage: :AsyncRun <command>
" DONT FORGET TO :copen quickfix before
" Output is displayed in the quickfix window
Plug 'skywind3000/asyncrun.vim', {'on': ['AsyncRun']}
autocmd! User asyncrun echom 'Asyncrun is now lazy loaded!'
" }}}

" {{{ bufexplore : Plugin for buffers list display and management
" https://github.com/jlanzarotta/bufexplorer
" Usage : <leader>be    ,be
" Aimed to improve buffer list display (:ls ou :buffers ou via ctrl-P plugin)
" Plug 'jlanzarotta/bufexplorer'
" NOTE : disabling it to use FzfBuffers cause it has a preview and looks smarter
map <leader>be  :echo "Calling ':FzfBuffers', also try classic way ':buffers' of ':ls' then ':ls\<number\>'" <bar> :FzfBuffers<cr>
" }}}
"
"{{{ figlet : To transform selected text in ascii art
" Usage : select text then :FIGlet
Plug 'fadein/vim-FIGlet' , {'on': ['FIGlet']}
autocmd! User vim-FIGlet echom 'FIGlet is now lazy loaded!'
" }}}

" {{{ Distraction free writing hides everything except current window
" see: https://github.com/junegunn/goyo.vim
" Usage :
" :Goyo
" :Gogyo!
Plug 'junegunn/goyo.vim', {'on': ['Goyo', 'Goyo!']}
autocmd! User goyo echom 'Goyo is now lazy loaded!'
" }}}

" {{{ taboo.vim : plugin for renaming tabs
" See: https://github.com/gcmt/taboo.vim
" To edit tab names
" Usage : TabooOpen toto
Plug 'gcmt/taboo.vim', {'on': ['TabooOpen']}
autocmd! User taboo echom 'Taboo is now lazy loaded!'
" }}}

" {{{ vim-template : To allow usage of templates on new files
" see : https://github.com/aperezdc/vim-template
" Usage : create a new file with accurate extension (.vue)
" open it and type :Template
" Note that template folder can be defined at project level with for example:
" let g:templates_directory='./.vim/templates'
Plug 'aperezdc/vim-template', {'on': ['Template']}
autocmd! User vim-template echom 'vim-template is now lazy loaded!'
" }}}

" {{{ ===== Various colorscheme s ====
"Enables 24-bit RGB color
set termguicolors
"Enable quick switch schemecolor
"See https://github.com/xolox/vim-colorscheme-switcher
" Use F8 and shift+F8 to quick switch
" Required by plugin colorscheme_switcher
Plug 'xolox/vim-misc'
Plug 'xolox/vim-colorscheme-switcher'
:let g:colorscheme_switcher_exclude = ['default', 'blue', 'shine', 'elflord']
:let g:colorscheme_switcher_exclude_builtins = 1
Plug 'nanotech/jellybeans.vim'
"Pencil color theme
Plug 'reedes/vim-colors-pencil'
" gruvbox : https://github.com/morhetz/gruvbox
Plug 'morhetz/gruvbox'
let g:gruvbox_improved_warnings=1
let g:gruvbox_improved_errors=1
" alternative to gruvbox that supports neovim
" Plug 'luisiacc/gruvbox-baby'
" dracula : https://draculatheme.com/vim
" It seems dracula does not support treesiter
Plug 'dracula/vim', { 'name': 'dracula' }
" Go dedicated colorscheme
" Plugin'bitfield/vim-gitgo'
" visual studio code like dark theme
Plug 'tomasiser/vim-code-dark'
" https://vimawesome.com/plugin/landscape-vim
Plug 'itchyny/landscape.vim'
Plug 'hzchirs/vim-material'
" https://github.com/glepnir/oceanic-material
" For mattis pres slides
Plug 'glepnir/oceanic-material'

"https://github.com/hzchirs/vim-material
" " Dark
" Plug 'hzchirs/vim-material'
" set background=dark
" colorscheme vim-material
" " Palenight
" let g:material_style='palenight'
" set background=dark
" colorscheme vim-material
" " Oceanic
" let g:material_style='oceanic'
" set background=dark
" colorscheme vim-material
" " Light
" set background=light
" colorscheme vim-material
"}}}


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

" {{{ Enable viewing of man page in vim
" Using command :Man
runtime! ftplugin/man.vim
" }}}

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
set listchars=tab:>-,trail:.,extends:>,precedes:<,space:.,nbsp:!
" list of filetypes for wich we want spaces to be displayed
autocmd FileType vim setlocal list
autocmd FileType yaml setlocal list
"highlight SpecialKey ctermfg=DarkGray

" Set the hidden option: so any buffer can be hidden (keeping its changes) without first writing the buffer to a file.
" This affects all commands and all buffers.
set hidden

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
" :set spell spelllang=en,fr
" Usual commands :
" zg => add word to dico
" zw => remove word from dico
" z= => suggest word
" defining custom alias
map gsn ]s
map gsp [s
" Add spell suggestions defined by me on top of suggestions
set spellsuggest=file:~/.vim/spell_suggestions.txt,best
" grammar check : see vim-grammarous plugin above


" Allow search of currently selected text using //
vnoremap // y/<C-R>"<CR>
" Allow clearing of searched text using ///
noremap /// :nohl<CR>
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
" Sets the model to use for the mouse.
" popup_setpos : place cursor, start or extend selection
:set mousemodel=popup_setpos

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

" To see the named color list
" open file ~/.vim/colortest.vim

" Adding display of matching while typing search pattern
" Enabled by default in neovim but not in vim
:set incsearch

" set diff options
if has('nvim')
  if has("patch-8.1.0360")
      set diffopt+=internal,algorithm:patience
  endif
endif

" Keep at least 5 lines visible at top and bottom of screen
:set scrolloff=5

"{{{ Common typo autofix/alias by replacing word
iabbrev improcing improving
iabbrev splitted split
iabbrev splited split
iabbrev throught through
iabbrev TODDO TODO
iabbrev TOOD TODO
iabbrev Addding Adding
iabbrev addding adding
iabbrev gitlab GitLab
iabbrev backend back-end
iabbrev frontend front-end
iabbrev 0th 0Th
iabbrev 19th 19Th
iabbrev 8th 8Th
iabbrev 7th 7Th
iabbrev 6th 6Th
iabbrev 5th 5Th
iabbrev 4th 4Th
iabbrev Seee See
iabbrev donee done
iabbrev doees does
iabbrev gomicro go-micro
iabbrev USSDD USSD
iabbrev lreaddy lready
cabbrev spllit split
cabbrev dedvelop develop
"}}}

" Adding command to generate a random password
" for use in 'pass edit'
command Password :r!pwgen --no-vowels --numerals --symbols --remove-chars "'\"~" 16 1

" Adding command to insert current date
" for use in changelog by example
imap <C-d> <C-R>=strftime("%Y-%m-%d")<CR>

" {{{ Call external tool called gocloc to count lines of code
" see: https://github.com/hhatto/gocloc
" rem : '!' ===> run external command
" rem : 'r' ===> read command output to current buffer
function! Rungocloc()
   :enew | r ! gocloc .
endfunction
command Gocloc :call Rungocloc()
" }}}

" {{{ cfilter : official plugin to filter quickfix list content
" to filter clist results
" See https://github.com/vim/vim/blob/master/runtime/pack/dist/opt/cfilter/plugin/cfilter.vim
" ex to filter out results containing "v2" :Cfilter! "v2"
" NOTE: colder can rollback cfilter effect
:packadd cfilter
" }}}

" Config for neovide graphical client
" Also impacts firenvim
" See: https://github.com/neovide/neovide
set guifont=Hack\ Nerd\ Font\ Mono:h24

" {{{ wildmenu : set wildmenu to allow a menu of matching items in command line when TAB is
" pressed
" it appears as a vertical menu in Neovim and as a horizontal list in vim
" e.g. :colors <TAB>
" e.g. :find order<TAB>
set wildmenu
set wildmode=longest:full,full
" }}}

" {{{ Improving copier-coller classic support
"  When the "unnamed" string is included in the 'clipboard' option, the unnamed
" register is the same as the "* register.  Thus you can yank to and paste the
" selection without prepending "* to commands.
set clipboard+=unnamed  " use the clipboards of vim and win

" Define command to copy in clipboard current file and line
command FullPath echom expand("%:h") . '/' . expand("%:t") . ':' . line(".")

" This should not be set in vimrc (see :checkhealth warning)
" Cause it disables too many features
" https://vimhelp.org/options.txt.html#%27paste%27
"set paste               " Paste from a windows or from vim

set guioptions+=a       " Visual selection automatically copied to the clipboard

" for version of vim compiled without -clipboard
vnoremap <C-y> :'<,'>w !xclip -selection clipboard<Cr><Cr>
" }}}

" {{{ Modify the cursor shape in insert mode
" See : https://stackoverflow.com/questions/6488683/how-to-change-the-cursor-between-normal-and-insert-modes-in-vim
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
" }}}

" Adding command shortcut for "set nospell"
command Nospell set nospell

" Additional configuration for yaml files
autocmd FileType yaml setlocal foldmethod=indent

" Additional configurationfor typescript files
autocmd FileType typescript setlocal foldmethod=syntax

" shortcuts to set tiletypes (command alias)
command Json set filetype=json|Prettier
command Markdown set filetype=markdown

" Shortcuts to move lines up or down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
" Disabling it in insert mode cause conflicts with snippet next field
" inoremap <C-j> <Esc>:m .+1<CR>==gi
" inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Additionall commands for taskwarrior
" t for listing all tasks
if !has('nvim')
  nmap <leader>t :call popup_create(systemlist('task'), {'close': 'click', 'moved':'any', 'border': [2,2,2,2], 'drag': 1, 'maxheight': 29, 'scrollbar': 1, 'resize': 1})<CR>
endif
if has('nvim')
   nmap <leader>t :!task<CR>
endif
