#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#==============================================================================
#  Shell Key Bindings
#==============================================================================

# Use vim commands in the ZLE
bindkey -v

# Display the vi mode in the RPROMPT
zstyle ':prezto:module:editor:info:keymap:alternate' format '%F{yellow}--- COMMAND ---%f'
zstyle ':prezto:module:editor:info:completing' format '%F{green}...%f'
RPROMPT='${editor_info[keymap]}'

# Make mac delete key work as expected
#stty erase ^H

# Map 'jj' to ESC when in insert mode
bindkey -M viins 'jj' vi-cmd-mode

#==============================================================================
#  Aliases 
#==============================================================================

# Recursively remove all those pesky .DS_Store files
alias rmDS="find ./ -name ".DS_Store" -depth -exec rm {} \;"

# Easy Config Editing
alias zshconfig="vim ~/.zshrc"
alias zshenv="vim ~/.zshenv"
alias vimconfig="vim ~/.vimrc"
alias dotfiles="cd ~/config/dot-files && vim"
alias sshconfig="vim ~/.ssh/config"

# Eclipse
alias eclipse="open -a Eclipse.app"
