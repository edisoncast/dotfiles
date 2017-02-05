# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Aliases
if [ -f "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# Custom environment vars
if [ -f "$HOME/.customvars" ]; then
  source "$HOME/.customvars"
fi

export EDITOR=vim
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=screen-256color-bce
# Hide Docker legacy commands in --help (Since Docker 1.13)
export DOCKER_HIDE_LEGACY_COMMANDS=1
source ~/.dotfiles/tmuxinator.zsh

if [ "$(tmux ls 2> /dev/null | wc -l)" -eq "0" ]; then
  tmuxinator general
fi
