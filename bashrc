##############################################################################
# INIT
##############################################################################
# if not running interactively, don't do anything
[ -z "$PS1" ] && return

# platform specific script comes first!
platform_script=~/.bash_`uname | awk '{ print tolower($0) }'`
[ -f $platform_script ] && . $platform_script
unset platform_script

##############################################################################
# GENERAL
##############################################################################
export EDITOR=vim
export TERM=screen-256color

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi

# source bash_completion.d
if [ -d /usr/local/etc/bash_completion.d ]; then
    for line in $(echo /usr/local/etc/bash_completion.d/*.sh); do
        source $line
    done
fi

# source profile that is shared between shells
if [ -f ~/.common_profile ]; then
    source ~/.common_profile
fi

# source aliases if present
if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

##############################################################################
# HISTORY
##############################################################################
# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

##############################################################################
# PROMPT
##############################################################################
NO_COLOR='\[\033[0m\]'
YELLOW='\[\033[0;33m\]'
RED='\[\033[1;31m\]'
GREEN='\[\033[0;32m\]'
BLUE='\[\033[0;34m\]'
PURPLE='\[\033[0;35m\]'
WHITE='\[\033[0;37m\]'
GIT_PS1_SHOWDIRTYSTATE=true
function color_my_prompt {
    local EXIT="$?"
    local __user_and_host="\u@\h"
    local __cur_location="\W"
    local __git_info='$(__git_ps1 "(%s)")'
    local __prompt_tail="$PURPLE$"
    if [ $EXIT -gt 0 ]; then
        __prompt_tail="$RED$EXIT $__prompt_tail"
    fi
    export PS1="$GREEN$__user_and_host $BLUE$__cur_location $YELLOW$__git_info $__prompt_tail$NO_COLOR "
}
PROMPT_COMMAND=color_my_prompt

# enable direnv
if [ which -a direnv ]; then
    eval "$(direnv hook bash)"
fi

##############################################################################
# CUSTOM ADDITIONS
##############################################################################
# local stuff
[ -f ~/.bash_local ] && . ~/.bash_local

# fix ssh-agent
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

# Arrow search history
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# enable ginkgo focus in editors
export GINKGO_EDITOR_INTEGRATION=true

source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
