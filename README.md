# loggregator-dotfiles

Shared dotfiles for the cloudfoundry-loggregator team

We use an Ubuntu base with xfce4 on top.
`sudo apt-get install xfce4-desktop xfce4-default-settings`

Grab git to install the next few things from src.
`sudo apt-get install git`

Move on to install [alacritty](https://github.com/jwilm/alacritty#installation),
vim: `sudo apt-get install vim`,
ruby `sudo apt-get install ruby`,
and [chruby](https://github.com/postmodern/chruby).

Tmux dependencies:
```
$ sudo apt install -y automake
$ sudo apt install -y build-essential
$ sudo apt install -y pkg-config
$ sudo apt install -y libncurses5-dev
$ sudo apt install -y libevent-dev
```

Now you should be all set to follow the rest of the [tmux](https://github.com/tmux/tmux) README to 
```
$ ./configure && make
$ sudo make install
```

Finally, cd into `~/workspace/loggregator-dotfiles` and `./install.sh`.
