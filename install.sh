#!/bin/bash

all_dotfiles="bashrc bash_darwin bash_profile common_profile tmux.conf vimrc vim aliases git-authors gitconfig alacritty.yml rbenv"

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

function update_submodules {
    git submodule update --init --recursive
}

function initialize_vim_plugins {
    # install vim plugins with vundle
    vim +PluginInstall +qall
}

function initialize_rbenv {
    pushd ~/.rbenv
        src/configure && make -C src
        mkdir -p $HOME/.rbenv/plugins
        git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build
    popd
}

update_submodules
link_all_dotfiles
initialize_vim_plugins
initialize_rbenv
