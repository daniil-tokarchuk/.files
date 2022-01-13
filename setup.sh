#!/usr/bin/env bash
eval "$(curl -fsSL https://raw.githubusercontent.com/daniil-tokarchuk/.files/master/.zshrc 2>&1 | grep DOT_FILES=)"
sudo sed -i "" $'2a\\\nauth       sufficient     pam_tid.so\n' /etc/pam.d/sudo

ED="${HOME}/.ssh/ed"
ssh-keygen -qt ed25519 -C "daniil.v.tokarchuk@gmail.com" -f $ED -P ""
ssh-add -q --apple-use-keychain $ED
ssh-keyscan github.com >> ~/.ssh/known_hosts
pbcopy < $ED.pub
read -psn 1 $'Paste key to github & press any key to continue\n'

mkdir -p $DOT_FILES
git clone git@github.com:daniil-tokarchuk/.files.git $DOT_FILES

ln -sf $DOT_FILES/.zshrc     ~/.zshrc
ln -sf $DOT_FILES/.gitconfig ~/.gitconfig
ln -sf $DOT_FILES/config     ~/.ssh/config
mkdir -p ~/.config/nvim/
ln -sf $DOT_FILES/init.lua   ~/.config/nvim/init.lua
mkdir -p ~/.aws/
ln -sf $DOT_FILES/aws-config ~/.aws/config

if test ! $(which brew); then ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install)"; fi
BREW_FORMULAE=(
	zsh-completions
	neovim
)
BREW_CASKS=(
	iterm2
	google-chrome
	intellij-idea
	docker
    slack
	microsoft-teams
    spotify
	discord
)
brew install ${BREW_FORMULAE[@]}
brew install --cask ${BREW_CASKS[@]}
brew completions link
brew autoremove
brew cleanup --prune=all
