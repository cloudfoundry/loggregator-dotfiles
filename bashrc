# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

NO_COLOR='\[\e[0m\]'
YELLOW='\[\e[1;33m\]'
GREEN='\[\033[01;32m\]'
BLUE='\[\033[01;34m\]'
PURPLE='\[\033[35m\]'
WHITE='\[\033[00m\]'
GIT_PS1_SHOWDIRTYSTATE=true
function color_my_prompt {
    local __user_and_host="\u@\h"
    local __cur_location="\w"
    local __git_info='$(__git_ps1 "(%s)")'
    local __prompt_tail="$"
    export PS1="$GREEN$__user_and_host $BLUE$__cur_location $YELLOW$__git_info$PURPLE$__prompt_tail$WHITE "
}
color_my_prompt


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# Custom Additions
eval "$(direnv hook bash)"
/usr/bin/setxkbmap -option "ctrl:nocaps"
# set default editor
export EDITOR=vim

source /usr/local/share/chruby/chruby.sh

if [ -f ~/.bash_custom ]; then
    . ~/.bash_custom
fi

