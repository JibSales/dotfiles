#! /usr/bin/env bash
set -e

dotfiles_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function symlink_files {
  for file in $1; do
    echo "Symlinking $file --> .$(basename $file)"
    ln -nfs $file $HOME/.$(basename $file)
  done
}

function install_homebrew {
  echo
  echo "====================================================="
  echo " Installing Homebrew"
  echo "====================================================="

  local brew=$(which brew)
  if [ $? == 0 ]; then
    echo "Already installed. Continuing..."
  else
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  echo
  echo "====================================================="
  echo " Updating Homebrew"
  echo "====================================================="
  brew update
  echo "DONE"
}

function install_packages {
  echo
  echo "====================================================="
  echo " Installing packages"
  echo "====================================================="
  local packages=
  if [[ $OSTYPE == darwin* ]]; then
    for package in $(cat $dotfiles_dir/packages/osx.txt | tr '\n' ' '); do
      if brew ls --versions $package > /dev/null; then
        echo "$package is already installed. Skipping..."
      else
        brew install $package
      fi
    done
  fi
  echo "DONE"
}

function install_applications {
  echo
  echo "====================================================="
  echo " Installing Applications"
  echo "====================================================="
  brew tap caskroom/cask
  for application in $(cat $dotfiles_dir/packages/applications.txt | tr '\n' ' '); do
    if brew cask ls --versions $application > /dev/null; then
      echo "$application is already installed. Skipping..."
    else
      brew cask install $application 2>/dev/null
    fi
  done
  echo "DONE"
}

function install_vim_config {
  echo
  echo "====================================================="
  echo " Installing Vim Configuration"
  echo "====================================================="

  ln -nfs $dotfiles_dir/vim $HOME/.vim
  ln -nfs $dotfiles_dir/vim/vimrc $HOME/.vimrc

  local vundle_path=$dotfiles_dir/vim/bundle/vundle

  if [ ! -d "$vundle_path" ]; then
    cd $dotfiles_dir
    git clone https://github.com/gmarik/vundle.git $vundle_path
  fi

  # Update vundle
  vim --noplugin -u $HOME/.vim/vundles.vim -N \"+set hidden\" \"+syntax on\" +BundleClean +BundleInstall! +qall

  echo "DONE"
}

function set_zsh_to_default_shell {
  echo
  echo "====================================================="
  echo " Setting zsh to the default shell"
  echo "====================================================="

  if [[ $SHELL == *"zsh" ]]; then
    echo "Zsh is already configured"
  else
    echo "Setting zsh as the default shell"
    if [ -e /usr/local/bin/zsh ]; then
      if [ "$(cat /private/etc/shells | grep '/usr/local/bin/zsh')" != "" ]; then
        echo "Adding zsh to standard shell list"
        echo "/usr/local/bin/zsh" | sudo tee -a /private/etc/shells
      fi
      chsh -s /usr/local/bin/zsh
    else
      chsh -s /bin/zsh
    fi
  fi
  echo "DONE"
}

function install_zsh_config {
  echo
  echo "====================================================="
  echo " Installing zsh configuration"
  echo "====================================================="

  if [ ! -d $HOME/.zgen ]; then
    git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
  fi

  ln -nfs $dotfiles_dir/zsh/zshrc $HOME/.zshrc

  echo "DONE"
}

function install_fonts {
  echo
  echo "======================================================"
  echo "Installing patched fonts for Powerline/Lightline."
  echo "======================================================"

  if [[ $OSTYPE == darwin* ]]; then
    cp -f $dotfiles_dir/fonts/* $HOME/Library/Fonts
  fi

  if [[ $OSTYPE == linux* ]]; then
    mkdir -p ~/.fonts && cp $dotfiles_dir/fonts/* ~/.fonts && fc-cache -vf ~/.fonts
  fi
  echo "DONE"
}

function install_iterm_solarized_theme {
  echo
  echo "======================================================"
  echo "Installing iTerm2 solarized theme."
  echo "======================================================"

  # Query and save the value; suppress any error message, if key not found.
  local plist_file=$HOME/Library/Preferences/com.googlecode.iterm2.plist
  local solarized_light=$(/usr/libexec/PlistBuddy -c "Print 'Custom Color Presets':'Solarized Light'" $plist_file 2>/dev/null)
  local solarized_dark=$(/usr/libexec/PlistBuddy -c "Print 'Custom Color Presets':'Solarized Dark'" $plist_file 2>/dev/null)

  if [[ ! $solarized_light == 0 ]]; then
    echo "Solarized Light is already installed"
  else
    local key_path=":'Custom Color Presets':'Solarized Light'"
    local file="$dotfiles_dir/iTerm2/Solarized Light.itermcolors"
    /usr/libexec/PlistBuddy -c "Add '$itermcolor_file' $key_path dict" $plist_file
    /usr/libexec/PlistBuddy -c "Merge '$file' $key_path" $plist_file
  fi
  if [[ ! $solarized_dark == 0 ]]; then
    echo "Solarized Dark is already installed"
  else
    local key_path=":'Custom Color Presets':'Solarized Dark'"
    local file="$dotfiles_dir/iTerm2/Solarized Dark.itermcolors"
    /usr/libexec/PlistBuddy -c "Add $key_path dict" $plist_file
    /usr/libexec/PlistBuddy -c "Merge '$file' $key_path" $plist_file
  fi
  echo "DONE"
}


###############################################################################
#  Task Runner
###############################################################################

echo
echo "======================================================"
echo " Installing Dotfiles"
echo "======================================================"

symlink_files $dotfiles_dir

if [[ $OSTYPE == darwin* ]]; then
  install_homebrew
  install_applications
  install_iterm_solarized_theme
fi
install_packages
install_vim_config
set_zsh_to_default_shell
install_zsh_config
install_fonts

echo
echo "======================================================"
echo " Adding miscellaneous configurations"
echo "======================================================"
symlink_files $dotfiles_dir/git/*
symlink_files $dotfiles_dir/ctags/*
symlink_files $dotfiles_dir/tmux/*
echo "DONE"

echo
echo "======================================================"
echo " Finished Installing Dotfiles. Restart your session."
echo "======================================================"
