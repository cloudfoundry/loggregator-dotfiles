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
echo /usr/local/etc/bash_completion.d/*.sh | while read line; do
    source $line
done

# source profile that is shared between shells
if [ -f ~/.common_profile ]; then
    source ~/.common_profile
fi

# source aliases if present
if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

# enable direnv
if [ which -a direnv ]; then
    eval "$(direnv hook bash)"
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

##############################################################################
# CUSTOM ADDITIONS
##############################################################################
# local stuff
[ -f ~/.bash_local ] && . ~/.bash_local
