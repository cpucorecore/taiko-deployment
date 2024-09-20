source ./env

sk=${KEEP_ALIVE_WORKER_SK}
to=${KEEP_ALIVE_WORKER_ADDR} # transfer to self
rpc=${RPC_URL_L2}

priority_gas_price=600gwei
gas_price=900gwei

if [ ! -e active_cnt_file ];
then
	echo 0 > active_cnt_file
fi
active_cnt=`cat active_cnt_file`

current_block_height=0
while true
do
txpool_status=`curl -s -H "Content-Type: application/json" $rpc  --data '{"method":"txpool_status","params":[],"id":1,"jsonrpc":"2.0"}'`
pending=`echo $txpool_status | jq ".result.pending" | awk -F '"' '{print $2}'`
queued=`echo $txpool_status | jq ".result.queued" | awk -F '"' '{print $2}'`
pending=`printf '%d' $pending`
queued=`printf '%d' $queued`

block=`curl -s -H "Content-Type: application/json" $rpc -X POST --data '{"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["latest", true],"id":1}'`
tx_cnt=`echo $block | jq ".result.transactions" | jq ".|length"`
block_height=`echo $block | jq ".result.number" | awk -F '"' '{print $2}'`
block_height=`printf '%d' $block_height`

if [ $block_height -le $current_block_height ]; then
	continue
fi
current_block_height=$block_height

printf '[%s]-->active_cnt=%d\n\t[block_height|tx_cnt|txpool_pending|txpool_queued]: \n\t[%012d|%06d|%014d|%013d]\n' `date +%F@%T` $active_cnt $block_height $tx_cnt $pending $queued
if [ $tx_cnt -le 1 -a $pending -gt 0 ];
then
	echo "found it, do active tx"
	active_cnt=$((active_cnt+1))
	echo $active_cnt > active_cnt_file
	cast send --value 1 --priority-gas-price $priority_gas_price --gas-price $gas_price -r $rpc --private-key $sk $to
fi


sleep 10

done