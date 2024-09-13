source ./env

nohup ./bin/taiko-client proposer \
    --l1.ws ${WS_URL_L1} \
    --l2.http ${RPC_URL_L2} \
    --l2.auth ${AUTH_RPC_URL_L2} \
    --taikoL1 ${ADDR_TAIKO_L1} \
    --taikoL2 ${ADDR_TAIKO_L2} \
    --taikoToken ${ADDR_TAIKO_TOKEN_L1} \
    --jwtSecret ${JWT_PATH} \
    --l1.proposerPrivKey ${PROPOSER_SK} \
    --l2.suggestedFeeRecipient ${FEE_RECIPIENT} \
    --tx.gasLimit ${TX_GAS_LIMIT} \
    --verbosity 3 \
    --proverSet ${ADDR_PROVER_SET_L1} > proposer.log 2>&1 &