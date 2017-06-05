if [[ "$OSTYPE" == darwin* ]]; then
  export NVM_DIR=~/.nvm
  source $(brew --prefix nvm)/nvm.sh
else
  export NVM_DIR="/local${HOME}/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
fi
