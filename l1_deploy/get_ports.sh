beacon_port=`cat output | grep "cl-1-lighthouse-geth" | awk '{print $6}' | awk -F ':' '{print $3}'`
rpc_ports=`cat output | grep "rpc: 8545" | awk '{print $4}' | awk -F ':' '{print $2}'`
ws_ports=`cat output | grep "ws: 8546" | awk '{print $4}' | awk -F ':' '{print $2}'`
echo -e "beacon_port:"$beacon_port
echo -e "rpc_ports:"$rpc_ports
echo -e "ws_ports:"$ws_ports