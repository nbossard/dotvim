
Installation:

    export https_proxy=http://proxy:8080
    git clone git://github.com/nbossard/dotvim.git ~/.vim

Create symlinks for console usage and android studio and neovim:

    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/vimrc ~/.ideavimrc
    mkdir ~/.config/nvim
    ln -s ~/.vim/vimrc ~/.config/nvim/init.vim

Switch to the `~/.vim` directory, and install vim-plug

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

Launch vim and run :PlugInstall
