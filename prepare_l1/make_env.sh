source ../env/l2_chain_id.env
source ../env/l1.env
source ../env/contract_addr_l1.env
source ../env/contract_addr_l2.env

pushd ../account
deployer_sk=`bash api.sh sk l1 deployer`
proposer_sk=`bash api.sh sk l1 proposer`
prover_sk=`bash api.sh sk l1 prover`
proposer_addr=`bash api.sh addr l1 proposer`
prover_addr=`bash api.sh addr l1 prover`
popd

cat /dev/null > env
printf "export CHAIN_ID_L2=%s\n" $CHAIN_ID_L2 >> env
printf "export RPC_URL_L1=%s\n" $RPC_URL_L1 >> env
printf "export deployer_sk=%s\n" $deployer_sk >> env
printf "export proposer_sk=%s\n" $proposer_sk >> env
printf "export prover_sk=%s\n" $prover_sk >> env
printf "export proposer_addr=%s\n" $proposer_addr >> env
printf "export prover_addr=%s\n" $prover_addr >> env
printf "export ADDR_SHARED_ADDRESS_MANAGER_L1=%s\n" $ADDR_SHARED_ADDRESS_MANAGER_L1 >> env
printf "export ADDR_TAIKO_L1=%s\n" $ADDR_TAIKO_L1 >> env
printf "export ADDR_TAIKO_TOKEN_L1=%s\n" $ADDR_TAIKO_TOKEN_L1 >> env
printf "export ADDR_PROVER_SET_L1=%s\n" $ADDR_PROVER_SET_L1 >> env
printf "export ADDR_BRIDGE_L2=%s\n" $ADDR_BRIDGE_L2 >> env
printf "export ADDR_SIGNAL_SERVICE_L2=%s\n" $ADDR_SIGNAL_SERVICE_L2 >> env