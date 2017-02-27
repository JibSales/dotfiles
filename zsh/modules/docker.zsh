if [[ $OSTYPE == "linux-gnu" ]]; then
  export DOCKER_HOST=tcp://127.0.0.1:4243
fi

alias dka='docker kill $(docker ps -aq)'
alias dra='docker rm $(docker ps -aq)'
alias dps='docker ps'
alias dpS='docker ps -a'

function dsh {
  docker exec -it $1 /bin/bash
}
