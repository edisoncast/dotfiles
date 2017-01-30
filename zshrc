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
source ~/.dotfiles/tmuxinator.zsh

tmuxinator general
