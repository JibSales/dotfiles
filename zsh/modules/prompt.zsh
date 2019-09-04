CUSTOM_REMOTE_SESSION_PROMPT=""
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  CUSTOM_REMOTE_SESSION_PROMPT="%F{7}☁ %f"
  if [ "$TERM" = "screen" ] || [ -n "$TMUX" ]; then
    CUSTOM_REMOTE_SESSION_PROMPT=""
  fi
fi

PROMPT='$CUSTOM_REMOTE_SESSION_PROMPT %F{4}${_prompt_sorin_pwd}%(!. %B%F{1}#%f%b.)${editor_info[keymap]} '
