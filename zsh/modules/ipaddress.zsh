function parse_ifconfig_for_ip {
  ifconfig -a | grep inet | grep -v '127.0.0.1' | awk '{print $2}' | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | tail -1
}

function get_ip_address {
  export MY_IP_ADDRESS=$(parse_ifconfig_for_ip)
}

get_ip_address
