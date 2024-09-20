source ../env/l1.env
source ../env/contract_addr_l1.env
source ../env/contract_addr_l2.env
source ../taiko_geth/l2.env.out
source ../env/deployment_dir.env

# cfg
cfg_TX_GAS_LIMIT=20000000

pushd ../account
PROPOSER_SK=`bash api.sh sk l1 proposer`
PROVER_SK=`bash api.sh sk l1 prover`
fee_recipient=`bash api.sh addr l1 prover`
popd

env_file=env
cat /dev/null > ${env_file}
printf "export WS_URL_L1=%s\n" ${WS_URL_L1} >> ${env_file}
printf "export BEACON_URL_L1=%s\n" ${BEACON_URL_L1} >> ${env_file}
printf "export WS_URL_L2=%s\n" ${WS_URL_L2} >> ${env_file}
printf "export RPC_URL_L2=%s\n" ${RPC_URL_L2} >> ${env_file}
printf "export ADDR_TAIKO_L1=%s\n" ${ADDR_TAIKO_L1} >> ${env_file}
printf "export ADDR_TAIKO_TOKEN_L1=%s\n" ${ADDR_TAIKO_TOKEN_L1} >> ${env_file}
printf "export ADDR_PROVER_SET_L1=%s\n" ${ADDR_PROVER_SET_L1} >> ${env_file}
printf "export ADDR_TAIKO_L2=%s\n" ${ADDR_TAIKO_L2} >> ${env_file}
printf "export AUTH_RPC_URL_L2=%s\n" ${AUTH_RPC_URL_L2} >> ${env_file}
printf "export JWT_PATH=%s\n" ${JWT_PATH} >> ${env_file}
printf "export PROPOSER_SK=%s\n" ${PROPOSER_SK} >> ${env_file}
printf "export PROVER_SK=%s\n" ${PROVER_SK} >> ${env_file}
printf "export FEE_RECIPIENT=%s\n" ${fee_recipient} >> ${env_file}
printf "export TX_GAS_LIMIT=%s\n" ${cfg_TX_GAS_LIMIT} >> ${env_file}
