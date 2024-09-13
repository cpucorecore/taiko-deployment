source ../env/l1.env
source ../env/contract_addr_l2.env

pushd ../account
deployer=`bash api.sh addr l1 deployer`
deployer_sk=`bash api.sh sk l1 deployer`
proposer=`bash api.sh addr l1 proposer`
popd

cat /dev/null > env
printf "export DEPLOYER=%s\n" ${deployer} >> env
printf "export DEPLOYER_SK=%s\n" ${deployer_sk} >> env
printf "export PRIVATE_KEY=%s\n" ${deployer_sk} >> env
printf "export RPC_URL_L1=%s\n" ${RPC_URL_L1} >> env
printf "export PROPOSER=%s\n" ${proposer} >> env
printf "export L2_GENESIS_HASH=%s\n" `bash get_l2_block0_hash.sh` >> env
printf "export ADDR_TAIKO_L2=%s\n" ${ADDR_TAIKO_L2} >> env
printf "export ADDR_SIGNAL_SERVICE_L2=%s" ${ADDR_SIGNAL_SERVICE_L2} >> env