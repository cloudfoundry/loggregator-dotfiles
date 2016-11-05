# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export GIT_DUET_GLOBAL=true
export GIT_DUET_ROTATE_AUTHOR=1

export PATH=~/bin:~/.bin:~/go/bin:/usr/local/go/bin:"$PATH"

export GEM_HOME=$HOME/.gem
export GEM_PATH=$HOME/.gem
