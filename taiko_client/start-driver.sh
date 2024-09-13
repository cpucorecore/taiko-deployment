source ./env

nohup ./bin/taiko-client driver \
    --l1.ws ${WS_URL_L1} \
    --l1.beacon ${BEACON_URL_L1} \
    --l2.ws ${WS_URL_L2} \
    --taikoL1 ${ADDR_TAIKO_L1} \
    --taikoL2 ${ADDR_TAIKO_L2} \
    --l2.auth ${AUTH_RPC_URL_L2} \
    --verbosity 5 \
    --jwtSecret ${JWT_PATH} > driver.log 2>&1 &