#==============================================================================
#  PATH
#==============================================================================

export PATH="/apollo/env/SDETools/bin:$PATH"
export PATH="/apollo/env/WDETools/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="/usr/local/bin:/usr/local/sbin:/Users/srquinn/bin:$PATH"

#==============================================================================
#  Environment Variables
#==============================================================================

# Set Language
export LANG=en_US.UTF-8

# Editor of Choice
export EDITOR=vim
export VISUAL="$EDITOR"

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Hostnames
export EC2_HOSTNAME="softlines-tech-srquinn-i-b8655f42.us-east-1.amazon.com"
export HOSTNAME_ALIAS="MacBookPro"

# LS Color Config
export LSCOLORS=exFxCxDxBxegedabagaced

# NodeJS
export NODE_BINARY_PATH="/usr/local/bin/node"
export I_WANT_NO_DEVTOOLS_SUPPORT_NOW_AND_FOREVER=NODE_BINARY_PATH

# Code Review
export REVIEW_DSC_FILE="/Users/srquinn/Documents/templates/post_review/description.txt"
export REVIEW_TST_FILE="/Users/srquinn/Documents/templates/post_review/testing-done.txt"
export REVIEW_TARGET_GROUPS="sl-fabric-dev"

# Files and Directories
export PROJECTS_LOCAL="$HOME/Projects"
export PROJECTS_REMOTE="/home/$USER/Projects"

# Register workspace locations
typeset -A WORKSPACES 
WORKSPACES[widgets]="$PROJECTS_LOCAL/Widgets:$PROJECTS_REMOTE/Widgets"
WORKSPACES[voodoo]="$PROJECTS_LOCAL/Voodoo:$PROJECTS_REMOTE/Widgets"
WORKSPACES[tests]="$PROJECTS_LOCAL/AutomatedTests:$PROJECTS_REMOTE/Tests" 

#==============================================================================
#  Shell Hacks
#==============================================================================

# Make mac delete key work as expected
stty erase ^H

# Map 'jj' to ESC when in insert mode
bindkey -M viins 'jj' vi-cmd-mode

#==============================================================================
#  Aliases 
#==============================================================================

# Recursively remove all those pesky .DS_Store files
alias rmDS="find ./ -name ".DS_Store" -depth -exec rm {} \;"
