# 
# Customize the Prompt
#
PROMPT='%{$fg[blue]%}$HOSTNAME_ALIAS: %{$fg[magenta]%}$(get_pwd)
$(vi_mode_prompt_info)$(prompt_status)%{$reset_color%}'

RPROMPT='$(git_prompt_info)'

# vi-mode Indicator
MODE_INDICATOR="%(?:%{$fg[green]%}[NORMAL] :%{$fg[yellow]%}[NORMAL] %s)"

# Prompt Status
function prompt_status() {
    echo "%(?:%{$fg[green]%}➜ :%{$fg[yellow]%}✘ %s)"
}

function get_pwd () {
    echo "${PWD/$HOME/~}"
}

# Git Information
ZSH_THEME_GIT_PROMPT_PREFIX="[git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}+"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"

function git_prompt_info() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}


#=====================================================================================================
# DEPRECATED
#=====================================================================================================

# Set Spacing
function put_spacing() {
    # First we get the git prompt length
    local git=$(git_prompt_info)
    if [ ${#git} != 0 ]; then
        ((git=${#git} - 10))
    else
        git=0
    fi

    # Then we determin how many spaces total based on current prompt width
    local termwidth
    (( termwidth = ${COLUMNS} - 2 - ${#HOSTNAME_ALIAS} - ${#$(get_pwd)} - ${git} ))

    # Finally, lets print!
    local spacing=""
    for i in {1..$termwidth}; do
        spacing="${spacing} "
    done
    echo $spacing
}

