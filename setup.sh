DOT_FILES=~/Projects/.files

ED="$HOME/.ssh/ed"
ssh-keygen -qt ed25519 -f $ED -P ""
ssh-add -q $ED
ssh-keyscan github.com >> ~/.ssh/known_hosts
cat $ED.pub
echo -n "Add key↗ to github & press any key to continue\n"
read

mkdir -p $DOT_FILES
git clone git@github.com:daniil-tokarchuk/.files.git $DOT_FILES

ln -sf $DOT_FILES/.zshrc     ~/.zshrc
ln -sf $DOT_FILES/.gitconfig ~/.gitconfig
mkdir -p ~/.config/nvim/
ln -sf $DOT_FILES/init.lua   ~/.config/nvim/init.lua
