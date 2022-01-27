export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if [[ ! -z $PYENV_ROOT ]]; then
  eval "$(pyenv init --path)"
fi
