echo "Creating a zgen save"

# prezto options
zgen prezto prompt theme 'sorin'

# prezto and modules
zgen prezto
zgen prezto git
zgen prezto command-not-found
zgen prezto syntax-highlighting

# save all to the init script
zgen save
