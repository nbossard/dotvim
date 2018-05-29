
Installation:

    export https_proxy=http://proxy:8080
    git clone --recursive git://github.com/nbossard/dotvim.git ~/.vim

Create symlinks for console usage and android studio:

    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/vimrc ~/.ideavimrc

Switch to the `~/.vim` directory, and fetch submodules:

    cd ~/.vim
    git submodule init
    git submodule update
