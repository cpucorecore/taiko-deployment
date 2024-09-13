ws_port=`bash get_ports.sh | grep ws_ports | awk -F ':' '{print $2}' | awk '{print $1}'`
echo $ws_port