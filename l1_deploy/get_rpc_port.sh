rpc_port=`bash get_ports.sh | grep rpc_ports | awk -F ':' '{print $2}' | awk '{print $1}'`
echo $rpc_port