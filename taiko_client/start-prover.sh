source ./env

# cfg
METRICS_PORT=36060

nohup ./bin/taiko-client prover \
    --metrics \
    --metrics.port ${METRICS_PORT} \
    --tx.numConfirmations 1 \
    --tx.receiptQueryInterval 2s \
    --l1.ws ${WS_URL_L1} \
    --l2.ws ${WS_URL_L2} \
    --l2.http ${RPC_URL_L2} \
    --taikoL1 ${ADDR_TAIKO_L1} \
    --taikoL2 ${ADDR_TAIKO_L2} \
    --taikoToken ${ADDR_TAIKO_TOKEN_L1} \
    --l1.proverPrivKey ${PROVER_SK} \
    --raiko.host http://localhost:18080 \
    --prover.capacity 100 \
    --prover.allowance 20000000 \
    --prover.blockConfirmations 1 \
    --proverSet ${ADDR_PROVER_SET_L1} > prover.log 2>&1 &