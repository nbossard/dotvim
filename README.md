
Installation:

    export https_proxy=http://proxy:8080
    git clone git://github.com/nbossard/dotvim.git ~/.vim

Create symlinks for console usage and android studio:

    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/vimrc ~/.ideavimrc

Switch to the `~/.vim` directory, and install vundle (plugin manager):

    cd ~/.vim
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    Launch vim and run :PluginInstall	
