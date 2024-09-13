source env.in

nohup ./build/bin/geth \
    --taiko \
    --networkid ${CHAIN_ID_L2} \
    --gcmode archive \
    --datadir ${TAIKO_GETH_DATA_ROOT} \
    --metrics \
    --metrics.expensive \
    --metrics.addr "0.0.0.0" \
    --authrpc.addr "0.0.0.0" \
    --authrpc.port ${AUTH_RPC_PORT_L2} \
    --authrpc.vhosts "*" \
    --authrpc.jwtsecret ${JWT_PATH} \
    --http \
    --http.api "admin,debug,eth,net,web3,txpool,miner,taiko" \
    --http.addr "0.0.0.0" \
    --http.port ${RPC_PORT_L2} \
    --http.vhosts "*" \
    --http.corsdomain="*" \
    --ws \
    --ws.api admin,debug,eth,net,web3,txpool,miner,taiko \
    --ws.addr "0.0.0.0" \
    --ws.port ${WS_PORT_L2} \
    --ws.origins "*" \
    --gpo.defaultprice "10000000" \
    --port 30304 \
    --syncmode full \
    --state.scheme=hash > taiko-geth.log 2>&1 &