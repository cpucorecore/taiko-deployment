source ./env

cast send -r ${RPC_URL_L2} --private-key $contract_owner_sk ${ADDR_SHARED_ADDRESS_MANAGER_L2} "setAddress(uint64,bytes32,address)" ${CHAIN_ID_L1} 0x6272696467650000000000000000000000000000000000000000000000000000 ${ADDR_BRIDGE_L1}
cast send -r ${RPC_URL_L2} --private-key $contract_owner_sk ${ADDR_SHARED_ADDRESS_MANAGER_L2} "setAddress(uint64,bytes32,address)" ${CHAIN_ID_L1} 0x7369676e616c5f73657276696365000000000000000000000000000000000000 ${ADDR_SIGNAL_SERVICE_L1}