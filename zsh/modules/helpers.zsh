# Clear the formatting from the text in the clipboard
alias clf="pbpaste | pbcopy"

function set_ip {
  export EXTERNAL_IP=$({ ifconfig utun0 2>/dev/null || ifconfig en5 2>/dev/null || ifconfig en0 } | awk '$1 == "inet" {print $2}')
  echo -e "EXTERNAL_IP set to \033[0;36m$EXTERNAL_IP\033[0m"
}

function kill-all {
  local pattern=$1
  ps -ef | grep $1 | grep -v grep | awk '{print $3}' | xargs kill -9
}

function disable_fw {
  while true; do sudo pfctl -d; sleep 1; done
}
