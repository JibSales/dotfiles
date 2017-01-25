echo "Creating a zgen save"

# prezto and modules
zgen prezto
zgen prezto prompt theme 'sorin'
zgen prezto editor key-bindings 'vi'
zgen prezto utility:ls color 'yes'
zgen prezto '*:*' color 'yes'
zgen prezto git
zgen prezto environment
zgen prezto terminal
zgen prezto editor
zgen prezto directory
zgen prezto spectrum
zgen prezto utility
zgen prezto completion
zgen prezto prompt
zgen prezto archive

# make things pretty
zgen load zsh-users/zsh-syntax-highlighting
zgen load zsh-users/zsh-history-substring-search

# save all to the init script
zgen save
