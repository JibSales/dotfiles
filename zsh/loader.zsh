echo -e "\033[36mCreating a zgen init...\e[0m"

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

# load local plugins
# zgen load ./modules/colors.zsh
# zgen load ./modules/docker.zsh
# zgen load ./modules/helpers.zsh
# zgen load ./modules/key-bindings.zsh
# zgen load ./modules/nvm.zsh
# zgen load ./modules/phantomjs.zsh

# save all to the init script
zgen save

echo -e "\033[36m[DONE]\e[0m"
