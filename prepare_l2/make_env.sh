source ../env/l1_chain_id.env
source ../taiko_geth/l2.env.out
source ../env/contract_addr_l1.env
source ../env/contract_addr_l2.env

pushd ../account
contract_owner_sk=`bash api.sh sk l2 contract_owner`
popd

cat /dev/null > env
printf "export CHAIN_ID_L1=%s\n" $CHAIN_ID_L1 >> env
printf "export RPC_URL_L2=%s\n" $RPC_URL_L2 >> env
printf "export contract_owner_sk=%s\n" $contract_owner_sk >> env
printf "export ADDR_SHARED_ADDRESS_MANAGER_L2=%s\n" $ADDR_SHARED_ADDRESS_MANAGER_L2 >> env
printf "export ADDR_BRIDGE_L1=%s\n" $ADDR_BRIDGE_L1 >> env
printf "export ADDR_SIGNAL_SERVICE_L1=%s\n" $ADDR_SIGNAL_SERVICE_L1 >> env