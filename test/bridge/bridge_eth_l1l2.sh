source ../env

#Message{
#  uint64 id (# Message ID whose value is automatically assigned.)
#  uint64 fee
#  uint32 gasLimit
#  address from (# The value is automatically assigned.)
#  uint64 srcChainId (# Source chain ID whose value is automatically assigned.)
#  address srcOwner
#  uint64 destChainId
#  address destOwner
#  address to (# The destination address on the destination chain.)
#  uint256 value (# value to invoke on the destination chain.)
#  bytes data (# callData to invoke on the destination chain.)
#}

bridge_amount=100000000000000000000 # 100ether

# parameter assign:
id=0
fee=200000000000 # 200Gwei
gasLimit=1000000
from=${TEST_ADDR_L1}
srcChainId=0
srcOwner=${TEST_ADDR_L1}
destChainId=${CHAIN_ID_L2}
destOwner=${TEST_ADDR_L1} # self
to=${TEST_ADDR_L1}
value=${bridge_amount}
data=0x

total_value=$(bc <<< "$value+$fee")

echo "before bridge asset from l1 to l2:"
printf "%s balance on l1:" ${TEST_ADDR_L1}
cast balance -r ${RPC_URL_L1} ${TEST_ADDR_L1}
printf "%s balance on l2:" ${TEST_ADDR_L1}
cast balance -r ${RPC_URL_L2} ${TEST_ADDR_L1}

cast send \
--value ${total_value} \
-r ${RPC_URL_L1} \
--private-key ${TEST_SK_L1} \
${ADDR_BRIDGE_L1} \
"sendMessage((uint64,uint64,uint32,address,uint64,address,uint64,address,address,uint256,bytes))" \
"(${id},${fee},${gasLimit},${from},${srcChainId},${srcOwner},${destChainId},${destOwner},${to},${value},0x)"

echo "after bridge asset from l1 to l2:"
printf "%s balance on l1:" ${TEST_ADDR_L1}
cast balance -r ${RPC_URL_L1} ${TEST_ADDR_L1}
printf "%s balance on l2:" ${TEST_ADDR_L1}
cast balance -r ${RPC_URL_L2} ${TEST_ADDR_L1}