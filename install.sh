#!/usr/bin/env bash

function install_dotfile() {
  echo "Installing $1 dotfile..."
  if [ -a "$HOME/.$1" ]; then
    echo "  Creating .$1 backup file..."
    md5sum=$(md5sum $HOME/.$1 | cut -d ' ' -f 1)
    if [ -a "$HOME/.$1.backup.$md5sum" ]; then
      echo "  Backup already exists... $HOME/.$1.backup.$md5sum"
    else
      echo '  '$(cp -v "$HOME/.$1" "$HOME/.$1.backup.$md5sum")
    fi
  fi
  echo '  '$(cp -v $1 $HOME/.$1)
}


echo '-------------------'
echo 'INSTALLING tmuxinator, zsh, xclip and git'
sudo apt-get -qq update
sudo apt-get install -qq tmuxinator zsh git-core xclip
sudo usermod -s $(which zsh) $USER

echo '-------------------'
echo 'INSTALLING PREREQUISITES SCRIPTS...'

if [ ! -d $HOME/.dotfiles ]; then
  mkdir $HOME/.dotfiles
fi 

SCRIPTS="https://raw.githubusercontent.com/richo/battery/master/bin/battery https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh"

for script in $SCRIPTS 
do
  echo "Installing ${script##*/} in $HOME/.dotfiles/${script##*/}"
  wget -q $script -O "$HOME/.dotfiles/${script##*/}"
  chmod +x "$HOME/.dotfiles/${script##*/}"
done
echo "Installing blue.tmuxtheme in $HOME/.dotfiles/blue.tmuxtheme"
cp blue.tmuxtheme $HOME/.dotfiles/blue.tmuxtheme

# Install PowerLine Fonts
echo '----------------'
echo 'INSTALLING POWERLINE FONTS'

if [ ! -d "$HOME/.local/share/fonts" ]; then
  mkdir -p "$HOME/.local/share/fonts"
fi

git clone https://github.com/powerline/fonts /tmp/fonts
bash /tmp/fonts/install.sh

# Install pathogen.vim
echo '----------------'
echo 'INSTALLING PATHOGEN.VIM'

if [ ! -d $HOME/.vim/autoload ]; then
  mkdir -p $HOME/.vim/autoload
fi

if [ ! -d $HOME/.vim/bundle ]; then
  mkdir -p $HOME/.vim/bundle
fi

curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install VIM Plugins
echo '----------------'
echo 'INSTALLING VIM PLUGINS'

echo 'Installing vim-tmux...'
git clone git://github.com/tmux-plugins/vim-tmux.git $HOME/.vim/bundle/vim-tmux
echo 'Installing nerdtree...'
git clone https://github.com/scrooloose/nerdtree.git $HOME/.vim/bundle/nerdtree

# Install Oh-My-ZSH
echo '----------------'
echo 'INSTALLING Oh-My-ZSH'
sh -c "$(wget -q https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Install dotfiles
echo '----------------'
echo 'INSTALLING DOTFILES'


DOTFILES="tmux.conf vimrc zshrc aliases"
for dotfile in $DOTFILES
do
  install_dotfile $dotfile
done
