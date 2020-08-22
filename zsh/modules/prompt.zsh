CUSTOM_REMOTE_SESSION_PROMPT=""
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  CUSTOM_REMOTE_SESSION_PROMPT="%F{7} %f "
  if [ "$TERM" = "screen" ] || [ -n "$TMUX" ]; then
    CUSTOM_REMOTE_SESSION_PROMPT=""
  fi
fi

function update_base_directory() {
  local base_directory=$(basename $(pwd))
  echo "%B%F{7}${base_directory}%f%b"
}

zstyle ':prezto:module:editor:info:keymap:primary' format '%B%F{4}❯%f%b'
zstyle ':prezto:module:editor:info:keymap:alternate' format '%B%F{5}❮%f%b'
zstyle ':prezto:module:git:info:branch' format ' %%B%F{2}%b%f%%b'

PROMPT='$CUSTOM_REMOTE_SESSION_PROMPT${editor_info[keymap]} '
