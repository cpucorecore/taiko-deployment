source l1.env

chain_id_resp=`curl -s -H "Content-Type: application/json" ${RPC_URL_L1} --data '{"method":"eth_chainId","params":[],"id":1,"jsonrpc":"2.0"}'`
if [ $? -ne 0 ]; then
  echo "wrong rpc!"
  exit -1
fi

echo ${chain_id_resp}
CHAIN_ID_L1=`echo ${chain_id_resp} | jq .result | awk -F '"' '{print $2}' | xargs printf "%d"`
echo "chain_id: ${CHAIN_ID_L1}"
cat /dev/null > l1_chain_id.env
echo -n "export CHAIN_ID_L1=${CHAIN_ID_L1}" > l1_chain_id.env
source l1_chain_id.env