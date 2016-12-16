#
# Executes Amazon specific commands at the start of an interactive session.
#
# Authors:
#   Sean R. Quinn <srquinn21@gmail.com>
#
#==============================================================================
#  Env Variables
#==============================================================================

# Path mods
path=(
  $path
  /apollo/env/SDETools/bin
)

# Setup for Node/Brazil
export NODE_BINARY_PATH=$(which node)
export NPM_BINARY_PATH=$(which npm)
export I_WANT_NO_DEVTOOLS_SUPPORT_NOW_AND_FOREVER=NODE_BINARY_PATH

#==============================================================================
#  Aliases
#==============================================================================

# Brazil
alias bb="brazil-build"
alias rbb="brazil-recursive-cmd build-build"

# Brazil Workspaces
alias wsls="cd $HOME/workspaces && ls -lh" 
alias wsc="brazil ws create --name $1"
alias wss="brazil ws show"
alias wscl="brazil ws clean"
alias wsmd="brazil ws sync --md"
alias wsvs="brazil ws use --vs $1"
alias wsap="brazil ws use -p $1"
alias wsrp="brazil ws remove -p $1"

function ws-open {
  cd ${HOME}/workspaces/${1}/src
  ls -1
}

# Odin
alias odin="ssh -L 2009:localhost:2009 banthiaj.desktop.amazon.com -f -N"
