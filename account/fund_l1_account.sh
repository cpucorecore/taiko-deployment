source ../env/l1.env
source parent_account_l1.env

rpc_url=${RPC_URL_L1}

cast balance -r ${rpc_url} ${PARENT_ACCOUNT_L1}

for to in `cat accounts/l1/index`
do
  if [ -n ${to} ]; then
    cast send --value ${TRANSFER_AMT}ether -r ${rpc_url} --private-key ${PARENT_ACCOUNT_L1_SK} ${to}
  fi
done