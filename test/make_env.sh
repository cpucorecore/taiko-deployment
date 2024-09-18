source ../env/l1.env
source ../taiko_geth/l2.env.out
source ../env/l1_chain_id.env
source ../env/l2_chain_id.env
source ../env/contract_addr_l1.env
source ../env/contract_addr_l2.env

pushd ../account
test_sk_l1=`bash api.sh sk l1 test`
test_sk_l2=`bash api.sh sk l2 test`
test_addr_l1=`bash api.sh addr l1 test`
test_addr_l2=`bash api.sh addr l2 test`
popd

cat /dev/null > env
printf "export CHAIN_ID_L1=%s\n" $CHAIN_ID_L1 >> env
printf "export CHAIN_ID_L2=%s\n" $CHAIN_ID_L2 >> env
printf "export RPC_URL_L1=%s\n" $RPC_URL_L1 >> env
printf "export RPC_URL_L2=%s\n" $RPC_URL_L2 >> env
printf "export ADDR_BRIDGE_L1=%s\n" $ADDR_BRIDGE_L1 >> env
printf "export ADDR_BRIDGE_L2=%s\n" $ADDR_BRIDGE_L2 >> env
printf "export TEST_ADDR_L1=%s\n" $test_addr_l1 >> env
printf "export TEST_ADDR_L2=%s\n" $test_addr_l2 >> env
printf "export TEST_SK_L1=%s\n" $test_sk_l1 >> env
printf "export TEST_SK_L2=%s\n" $test_sk_l2 >> env
