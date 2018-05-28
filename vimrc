" Nicolas Bossard, 28th may 2018, personal syntax for VIM editor
" Saved in git for history and for sharing accross computers.
" As described here : 
" http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/
" See README.md for configuration.

" Display line number in left gutter
:set number

" Allow syntax coloring
" Syntax are located in *.vim files, e.g. : "java.vim", try "locate java.vim" 
:syntax on

" Use pathogen as plugin manager
" Uses folders "autoload" and "bundle"
execute pathogen#infect()
