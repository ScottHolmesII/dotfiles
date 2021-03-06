#################################
# copy from https://github.com/carlhuda/janus/blob/master/bootstrap.sh

function die()
{
  echo "${@}"
  exit 1
}

DOTFILES=$HOME/.dotfiles

# Add <strong>.old</strong> to any existing Vim file in the home directory
for i in $HOME/.gitconfig \
         $HOME/.exports \
         $HOME/.functions \
         $HOME/.gitconfig \
         $HOME/.gitignore \
         $HOME/.inputrc \
         $HOME/.gemrc \
         $HOME/.dircolors \
         $HOME/.osx; do
  if [[ ( -e $i ) || ( -h $i ) ]]; then
    echo "${i} has been renamed to ${i}.old"
    mv "${i}" "${i}.old" || die "Could not move ${i} to ${i}.old"
  fi
done
#################################

git clone --recursive git://github.com/aaronlake/dotfiles.git $HOME/.dotfiles \
    || die "Could not clone the repository to ${HOME}/.dotfiles"

echo "Installing antibody"
curl -sL git.io/antibody | sh -s

echo "Link configuration files"
ln -s $DOTFILES/gitconfig $HOME/.gitconfig
ln -s $DOTFILES/exports $HOME/.exports
ln -s $DOTFILES/functions $HOME/.functions
ln -s $DOTFILES/gitignore $HOME/.gitignore_global
ln -s $DOTFILES/inputrc $HOME/.inputrc
ln -s $DOTFILES/gemrc $HOME/.gemrc
ln -s $DOTFILES/zshrc $HOME/.zshrc
ln -s $DOTFIlES/dircolors-solarized/dircolors.256dark $HOME/.dircolors

echo "Setting global gitignore"
git config --global core.excludesfile ~/.gitignore_global

echo "Install successfully."

