source ./env

cast send --value 0 -r $RPC_URL_L1 --private-key $deployer_sk $ADDR_TAIKO_TOKEN_L1 "transfer(address,uint256)" $prover_addr   100000000000000000000000000
cast send --value 0 -r $RPC_URL_L1 --private-key $deployer_sk $ADDR_TAIKO_TOKEN_L1 "transfer(address,uint256)" $proposer_addr 100000000000000000000000000
cast send --value 0 -r $RPC_URL_L1 --private-key $proposer_sk $ADDR_TAIKO_TOKEN_L1 "approve(address,uint256)" $ADDR_TAIKO_L1 20000000000000000000000000
cast send --value 0 -r $RPC_URL_L1 --private-key $prover_sk   $ADDR_TAIKO_TOKEN_L1 "approve(address,uint256)" $ADDR_TAIKO_L1 20000000000000000000000000

cast send --value 0 -r $RPC_URL_L1 --private-key $deployer_sk $ADDR_TAIKO_TOKEN_L1 "transfer(address,uint256)" $ADDR_PROVER_SET_L1 20000000000000000000000000
cast send --value 0 -r $RPC_URL_L1 --private-key $deployer_sk $ADDR_PROVER_SET_L1 "enableProver(address,bool)" $prover_addr true
cast send --value 0 -r $RPC_URL_L1 --private-key $deployer_sk $ADDR_PROVER_SET_L1 "enableProver(address,bool)" $proposer_addr true

cast send -r $RPC_URL_L1 --private-key $deployer_sk $ADDR_SHARED_ADDRESS_MANAGER_L1 "setAddress(uint64,bytes32,address)" ${CHAIN_ID_L2} 0x6272696467650000000000000000000000000000000000000000000000000000 ${ADDR_BRIDGE_L2}
cast send -r $RPC_URL_L1 --private-key $deployer_sk $ADDR_SHARED_ADDRESS_MANAGER_L1 "setAddress(uint64,bytes32,address)" ${CHAIN_ID_L2} 0x7369676e616c5f73657276696365000000000000000000000000000000000000 ${ADDR_SIGNAL_SERVICE_L2}
