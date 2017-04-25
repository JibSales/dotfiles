#! /usr/bin/env bash
set -e

dotfiles_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

###############################################################################
# UTILITIES
###############################################################################

function symlink_files {
  for file in $1; do
    echo -e "\033[0;33mSymlinking\033[0m $file \033[0;35m-->\033[0m .$(basename $file)"
    ln -nfs $file $HOME/.$(basename $file)
  done
}

function log_info {
  echo -e "\033[0;34m$1\033[0m"
}

function banner {
  echo
  echo -e "\033[0;34m=====================================================\033[0m"
  echo -e "\033[0;33m$@\033[0m"
  echo -e "\033[0;34m=====================================================\033[0m"
}

function log_done {
  echo -e "\033[0;35m$1\033[0m"
}

function already_installed {
  echo -e "\033[0;33m$1 is already installed.\033[0m Skipping..."
}

###############################################################################
# TASKS
###############################################################################

function install_homebrew {
  banner "Installing Homebrew"

  local brew=$(which brew)
  if [ $? == 0 ]; then
    already_installed "brew"
  else
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  banner "Updating Homebrew"
  brew update
  log_done "DONE"
}

function install_packages {
  banner "Installing packages"
  if [[ $OSTYPE == darwin* ]]; then
    while read install_string; do
      local package=$(echo $install_string | awk '{ print $1 };')
      if brew ls --versions $package > /dev/null; then
        already_installed $package
      else
        brew install $install_string
      fi
    done <$dotfiles_dir/packages/osx.txt
  fi
  log_done "DONE"
}

function install_applications {
  banner "Installing Applications"
  brew tap caskroom/cask
  for application in $(cat $dotfiles_dir/packages/applications.txt | tr '\n' ' '); do
    if brew cask ls --versions $application > /dev/null; then
      already_installed $application
    else
      brew cask install $application 2>/dev/null
    fi
  done
  log_done "DONE"
}

function install_vim_config {
  banner "Installing Vim Configuration"

  ln -nfs $dotfiles_dir/vim $HOME/.vim
  ln -nfs $dotfiles_dir/vim/vimrc $HOME/.vimrc

  local vundle_path=$dotfiles_dir/vim/bundle/vundle

  if [ ! -d "$vundle_path" ]; then
    cd $dotfiles_dir
    git clone https://github.com/gmarik/vundle.git $vundle_path
  fi

  # Update vundle
  vim --noplugin -u $HOME/.vim/vundles.vim -N \"+set hidden\" \"+syntax on\" +BundleClean +BundleInstall! +qall

  log_done "DONE"
}

function set_zsh_to_default_shell {
  banner "Setting zsh to the default shell"

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
  log_done "DONE"
}

function install_zsh_config {
  banner "Installing zsh configuration"

  if [ ! -d $HOME/.zprezto ]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"
  fi

  symlink_files "$dotfiles_dir/zsh/z*"

  log_done "DONE"
}

function install_fonts {
  banner "Installing patched fonts for Powerline/Lightline."

  if [[ $OSTYPE == darwin* ]]; then
    cp -f $dotfiles_dir/fonts/* $HOME/Library/Fonts
  fi

  if [[ $OSTYPE == linux* ]]; then
    mkdir -p ~/.fonts && cp $dotfiles_dir/fonts/* ~/.fonts && fc-cache -vf ~/.fonts
  fi
  log_done "DONE"
}

function install_iterm_solarized_theme {
  banner "Installing iTerm2 solarized theme."

  # Query and save the value; suppress any error message, if key not found.
  local plist_file=$HOME/Library/Preferences/com.googlecode.iterm2.plist
  local solarized_light=$(/usr/libexec/PlistBuddy -c "Print 'Custom Color Presets':'Solarized Light'" $plist_file 2>/dev/null)
  local solarized_dark=$(/usr/libexec/PlistBuddy -c "Print 'Custom Color Presets':'Solarized Dark'" $plist_file 2>/dev/null)

  if [[ ! $solarized_light == 0 ]]; then
    already_installed "Solarized Light"
  else
    local key_path=":'Custom Color Presets':'Solarized Light'"
    local file="$dotfiles_dir/iTerm2/Solarized Light.itermcolors"
    /usr/libexec/PlistBuddy -c "Add '$itermcolor_file' $key_path dict" $plist_file
    /usr/libexec/PlistBuddy -c "Merge '$file' $key_path" $plist_file
  fi
  if [[ ! $solarized_dark == 0 ]]; then
    already_installed "Solarized Dark"
  else
    local key_path=":'Custom Color Presets':'Solarized Dark'"
    local file="$dotfiles_dir/iTerm2/Solarized Dark.itermcolors"
    /usr/libexec/PlistBuddy -c "Add $key_path dict" $plist_file
    /usr/libexec/PlistBuddy -c "Merge '$file' $key_path" $plist_file
  fi
  log_done "DONE"
}


###############################################################################
#  Task Runner
###############################################################################

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

banner "Adding miscellaneous configurations"
symlink_files $dotfiles_dir/git/*
symlink_files $dotfiles_dir/ctags/*
symlink_files $dotfiles_dir/tmux/*
log_done "DONE"
