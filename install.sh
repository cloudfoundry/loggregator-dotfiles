#!/bin/bash

all_dotfiles="bashrc zshrc profile tmux.conf vimrc vim aliases"

function link {
    echo Attempting to link $1
    ln -is $PWD/$1 $HOME/.$1
}

function print_error {
    echo Failed to link $1
}

function link_all_dotfiles {
    for dotfile in $all_dotfiles; do
        if [ -f $HOME/.$1 ];
        then
            # file exists
            print_error $dotfile
        else
            # file does not exist
            link $dotfile
        fi
    done
}

function initialize_vim_config {
    # pull in vundle (vim package manager)
    git submodule update --init
    # install vim plugins with vundle
    vim +PluginInstall +qall
}

initialize_vim_config
link_all_dotfiles
