#!/usr/bin/env bash
eval "$(curl -fsSL https://raw.githubusercontent.com/daniil-tokarchuk/.files/master/.zshrc 2>&1 | grep -e DOT_FILES= -e N_PREFIX=)"

ED="$HOME/.ssh/ed"
ssh-keygen -qt ed25519 -f $ED -P ""
ssh-add -q $ED
ssh-keyscan github.com >> $HOME/.ssh/known_hosts
cat $ED.pub
read -srn 1 -p "Add key↗ to github & press any key to continue\n"

mkdir -p $DOT_FILES
git clone git@github.com:daniil-tokarchuk/.files.git $DOT_FILES

ln -sf $DOT_FILES/.zshrc       $HOME/.zshrc
ln -sf $DOT_FILES/.gitconfig   $HOME/.gitconfig
mkdir -p $HOME/.config/nvim/ftplugin
ln -sf $DOT_FILES/lua/init.lua $HOME/.config/nvim/init.lua
