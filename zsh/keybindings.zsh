#==============================================================================
#  Shell Key Bindings
#==============================================================================

# Use vim commands in the ZLE
bindkey -v

# Make mac delete key work as expected
stty erase ^H
stty erase '^?'

# Map 'jj' to ESC when in insert mode
bindkey -M viins 'jj' vi-cmd-mode
