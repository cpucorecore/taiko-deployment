source ../taiko_geth/l2.env.out


pushd ../account
keep_alive_worker_sk=`bash api.sh sk l2 keep_alive_worker`
keep_alive_worker_addr=`bash api.sh addr l2 keep_alive_worker`
popd

env_file=env
cat /dev/null > ${env_file}
printf "export KEEP_ALIVE_WORKER_SK=%s\n" ${keep_alive_worker_sk} >> ${env_file}
printf "export KEEP_ALIVE_WORKER_ADDR=%s\n" ${keep_alive_worker_addr} >> ${env_file}
printf "export RPC_URL_L2=%s\n" ${RPC_URL_L2} >> ${env_file}
