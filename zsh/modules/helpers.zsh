function set_ip {
  export EXTERNAL_IP=$({ ifconfig utun0 2>/dev/null || ifconfig en5 } | awk '$1 == "inet" {print $2}')
  echo -e "EXTERNAL_IP set to \033[0;36m$EXTERNAL_IP\033[0m"
}
