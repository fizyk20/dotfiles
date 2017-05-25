#!/bin/bash
MAINDIR=$(pwd)
cd ~

# install oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
ln -s $MAINDIR/zsh/ebvalaim.zsh-theme ~/.oh-my-zsh/themes/ebvalaim.zsh-theme

# link .zshrc
rm ~/.zshrc	# delete .zshrc created by oh-my-zsh
ln -s $MAINDIR/zsh/.zshrc ~/.zshrc

# link .vimrc
ln -s $MAINDIR/vim/.vimrc ~/.vimrc
ln -s $MAINDIR/vim/.vimrc.git ~/.vimrc.git

# link .Xresources
ln -s $MAINDIR/.Xresources ~/.Xresources

git config --global core.editor "nvim -u $HOME/.vimrc.git"
