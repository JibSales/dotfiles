if [[ "$OSTYPE" == darwin* ]]; then
  export NVM_DIR=~/.nvm
  source $(brew --prefix nvm)/nvm.sh
fi
