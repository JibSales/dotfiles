# Map 'jj' to ESC when in insert mode
bindkey -M viins 'jj' vi-cmd-mode

# [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
bindkey '^r' history-incremental-search-backward

# Search backwards and forwards with a pattern
bindkey -M vicmd '/' history-incremental-pattern-search-backward
bindkey -M vicmd '?' history-incremental-pattern-search-forward

# set up for insert mode too
# bindkey -M viins '^R' history-incremental-pattern-search-backward
# bindkey -M viins '^F' history-incremental-pattern-search-forward
