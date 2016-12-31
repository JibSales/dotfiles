echo "Creating a zgen save"

# prezto options
zgen prezto prompt theme 'sorin'
zgen prezto module editor key-bindings 'vi'

# make things pretty
zgen load zsh-users/zsh-syntax-highlighting
zgen load zsh-users/zsh-history-substring-search

# prezto and modules
zgen prezto
zgen prezto git
zgen prezto command-not-found

# save all to the init script
zgen save
