echo "Creating a zgen save"

# prezto options
zgen prezto prompt theme 'sorin'

# prezto and modules
zgen prezto
zgen prezto git
zgen prezto command-not-found
zgen prezto syntax-highlighting

# custom plugins
zgen load "${ZDOTDIR:-$HOME}/.dotfiles/zsh/plugins/colors.zsh"
zgen load "${ZDOTDIR:-$HOME}/.dotfiles/zsh/plugins/docker.zsh"
zgen load "${ZDOTDIR:-$HOME}/.dotfiles/zsh/plugins/helpers.zsh"
zgen load "${ZDOTDIR:-$HOME}/.dotfiles/zsh/plugins/key-bindings.zsh"
zgen load "${ZDOTDIR:-$HOME}/.dotfiles/zsh/plugins/nvm.zsh"
zgen load "${ZDOTDIR:-$HOME}/.dotfiles/zsh/plugins/phantomjs.zsh"

# save all to the init script
zgen save
