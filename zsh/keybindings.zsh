#==============================================================================
#  Shell Key Bindings
#==============================================================================

# Make mac delete key work as expected
stty erase ^H

# Map 'jj' to ESC when in insert mode
bindkey -M viins 'jj' vi-cmd-mode

