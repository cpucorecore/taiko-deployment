source ../env/l1.env
source parent_account_l1.env

rpc_url=${RPC_URL_L1}
to=$1

cast balance -r ${rpc_url} ${PARENT_ACCOUNT_L1}
cast send --value ${TRANSFER_AMT}ether -r ${rpc_url} --private-key ${PARENT_ACCOUNT_L1_SK} ${to}
