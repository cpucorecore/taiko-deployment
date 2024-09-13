source ../env/l2_chain_id.env
source ../env/deployment_dir.env

WS_PORT=28546
RPC_PORT=28545
AUTH_RPC_PORT=28551

env_in=env.in
cat /dev/null > ${env_in}

printf "export CHAIN_ID_L2=%s\n" ${CHAIN_ID_L2} >> ${env_in}
printf "export TAIKO_GETH_DATA_ROOT=%s\n" ${TAIKO_GETH_DATA_ROOT} >> ${env_in}
printf "export JWT_PATH=%s\n" ${JWT_PATH} >> ${env_in}
printf "export WS_PORT_L2=%d\n" ${WS_PORT} >> ${env_in}
printf "export RPC_PORT_L2=%d\n" ${RPC_PORT} >> ${env_in}
printf "export AUTH_RPC_PORT_L2=%d\n" ${AUTH_RPC_PORT} >> ${env_in}

http_protocol=http
ws_protocol=ws

env_out=l2.env.out
cat /dev/null > ${env_out}
printf "export AUTH_RPC_PORT_L2=%d\n" ${AUTH_RPC_PORT} >> ${env_out}
lan_ipv4_addr=`bash ../env/get_lan_ipv4_addr.sh`
printf "export WS_URL_L2=%s\n" ${ws_protocol}://${lan_ipv4_addr}:${WS_PORT} >> ${env_out}
printf "export RPC_URL_L2=%s\n" ${http_protocol}://${lan_ipv4_addr}:${RPC_PORT} >> ${env_out}
printf "export AUTH_RPC_URL_L2=%s\n" ${http_protocol}://${lan_ipv4_addr}:${AUTH_RPC_PORT} >> ${env_out}