source ../env/l1.env
source ../env/contract_addr_l1.env
source ../env/contract_addr_l2.env
source ../taiko_geth/l2.env.out
source ../env/deployment_dir.env

# cfg
cfg_FEE_RECIPIENT=0xE25583099BA105D9ec0A67f5Ae86D90e50036425
cfg_TX_GAS_LIMIT=20000000

pushd ../account
PROPOSER_SK=`bash api.sh sk l1 proposer`
PROVER_SK=`bash api.sh sk l1 prover`
popd

env=env
cat /dev/null >${env}
printf "export WS_URL_L1=%s\n" ${WS_URL_L1} >> ${env}
printf "export BEACON_URL_L1=%s\n" ${BEACON_URL_L1} >> ${env}
printf "export WS_URL_L2=%s\n" ${WS_URL_L2} >> ${env}
printf "export RPC_URL_L2=%s\n" ${RPC_URL_L2} >> ${env}
printf "export ADDR_TAIKO_L1=%s\n" ${ADDR_TAIKO_L1} >> ${env}
printf "export ADDR_TAIKO_TOKEN_L1=%s\n" ${ADDR_TAIKO_TOKEN_L1} >> ${env}
printf "export ADDR_PROVER_SET_L1=%s\n" ${ADDR_PROVER_SET_L1} >> ${env}
printf "export ADDR_TAIKO_L2=%s\n" ${ADDR_TAIKO_L2} >> ${env}
printf "export AUTH_RPC_URL_L2=%s\n" ${AUTH_RPC_URL_L2} >> ${env}
printf "export JWT_PATH=%s\n" ${JWT_PATH} >> ${env}
printf "export PROPOSER_SK=%s\n" ${PROPOSER_SK} >> ${env}
printf "export PROVER_SK=%s\n" ${PROVER_SK} >> ${env}
printf "export FEE_RECIPIENT=%s\n" ${cfg_FEE_RECIPIENT} >> ${env}
printf "export TX_GAS_LIMIT=%s\n" ${cfg_TX_GAS_LIMIT} >> ${env}

