source ../env/contract_addr_l1.env
source ../env/contract_addr_l2.env
source ../env/l1.env
source ../taiko_geth/l2.env.out

# indexer
## l1-l2 indexer
l1l2_indexer_file="local_test/l1l2_indexer.env"
touch $l1l2_indexer_file
cat /dev/null > $l1l2_indexer_file
printf "METRICS_HTTP_PORT=46061\n" >> $l1l2_indexer_file
bash make_db_env.sh $l1l2_indexer_file
printf "\n" >> $l1l2_indexer_file
bash make_mq_env.sh $l1l2_indexer_file
printf "\n" >> $l1l2_indexer_file
printf "EVENT_NAME=MessageSent\n" >> $l1l2_indexer_file
printf "SRC_SIGNAL_SERVICE_ADDRESS=${ADDR_SIGNAL_SERVICE_L1}\n" >> $l1l2_indexer_file
printf "SRC_BRIDGE_ADDRESS=${ADDR_BRIDGE_L1}\n" >> $l1l2_indexer_file
printf "DEST_BRIDGE_ADDRESS=${ADDR_BRIDGE_L2}\n" >> $l1l2_indexer_file
printf "SRC_TAIKO_ADDRESS=${ADDR_TAIKO_L1}\n" >> $l1l2_indexer_file
printf "SRC_RPC_URL=${WS_URL_L1}\n" >> $l1l2_indexer_file
printf "DEST_RPC_URL=${RPC_URL_L2}\n" >> $l1l2_indexer_file
printf "CORS_ORIGINS=*\n" >> $l1l2_indexer_file
printf "NUM_GOROUTINES=50\n" >> $l1l2_indexer_file
printf "BLOCK_BATCH_SIZE=100\n" >> $l1l2_indexer_file

## l2-l1 indexer
l2l1_indexer_file="local_test/l2l1_indexer.env"
touch $l2l1_indexer_file
cat /dev/null > $l2l1_indexer_file
printf "METRICS_HTTP_PORT=46063\n" >> $l2l1_indexer_file
bash make_db_env.sh $l2l1_indexer_file
printf "\n" >> $l2l1_indexer_file
bash make_mq_env.sh $l2l1_indexer_file
printf "\n" >> $l2l1_indexer_file
printf "EVENT_NAME=MessageSent\n" >> $l2l1_indexer_file
printf "SRC_SIGNAL_SERVICE_ADDRESS=${ADDR_SIGNAL_SERVICE_L2}\n" >> $l2l1_indexer_file
printf "SRC_BRIDGE_ADDRESS=${ADDR_BRIDGE_L2}\n" >> $l2l1_indexer_file
printf "DEST_BRIDGE_ADDRESS=${ADDR_BRIDGE_L1}\n" >> $l2l1_indexer_file
printf "SRC_TAIKO_ADDRESS=0x0000000000000000000000000000000000000000\n" >> $l2l1_indexer_file
printf "SRC_RPC_URL=${WS_URL_L2}\n" >> $l2l1_indexer_file
printf "DEST_RPC_URL=${RPC_URL_L1}\n" >> $l2l1_indexer_file
printf "CORS_ORIGINS=*\n" >> $l2l1_indexer_file
printf "NUM_GOROUTINES=50\n" >> $l2l1_indexer_file
printf "BLOCK_BATCH_SIZE=100\n" >> $l2l1_indexer_file

# processor
pushd ../account
bridge_processor_sk_l2=`bash api.sh sk l2 bridge_processor`
bridge_processor_sk_l2=${bridge_processor_sk_l2:2}
bridge_processor_sk_l1=`bash api.sh sk l1 bridge_processor`
bridge_processor_sk_l1=${bridge_processor_sk_l1:2}
popd

## l1-l2 processor
l1l2_processor_file=local_test/l1l2_processor.env
touch $l1l2_processor_file
cat /dev/null > $l1l2_processor_file
printf "METRICS_HTTP_PORT=46062\n" >> $l1l2_processor_file
bash make_db_env.sh $l1l2_processor_file
printf "\n" >> $l1l2_processor_file
bash make_mq_env.sh $l1l2_processor_file
printf "\n" >> $l1l2_processor_file
printf "PROCESSOR_PRIVATE_KEY=$bridge_processor_sk_l2\n" >> $l1l2_processor_file
printf "DEST_BRIDGE_ADDRESS=${ADDR_BRIDGE_L2}\n" >> $l1l2_processor_file
printf "SRC_ERC20_VAULT_ADDRESS=${ADDR_ERC20_VAULT_L1}\n" >> $l1l2_processor_file
printf "DEST_ERC20_VAULT_ADDRESS=${ADDR_ERC20_VAULT_L2}\n" >> $l1l2_processor_file
printf "DEST_ERC721_VAULT_ADDRESS=${ADDR_ERC721_VAULT_L2}\n" >> $l1l2_processor_file
printf "DEST_ERC1155_VAULT_ADDRESS=${ADDR_ERC1155_VAULT_L2}\n" >> $l1l2_processor_file
printf "DEST_TAIKO_ADDRESS=${ADDR_TAIKO_L2}\n" >> $l1l2_processor_file
printf "SRC_SIGNAL_SERVICE_ADDRESS=${ADDR_SIGNAL_SERVICE_L1}\n" >> $l1l2_processor_file
printf "SRC_RPC_URL=${WS_URL_L1}\n" >> $l1l2_processor_file
printf "DEST_RPC_URL=${RPC_URL_L2}\n" >> $l1l2_processor_file
printf "CONFIRMATIONS_BEFORE_PROCESSING=2\n" >> $l1l2_processor_file
printf "CORS_ORIGINS=*\n" >> $l1l2_processor_file
printf "NUM_GOROUTINES=50\n" >> $l1l2_processor_file
printf "BLOCK_BATCH_SIZE=100\n" >> $l1l2_processor_file
printf "HEADER_SYNC_INTERVAL_IN_SECONDS=2\n" >> $l1l2_processor_file

## l2-l1 processor
l2l1_processor_file=local_test/l2l1_processor.env
touch $l2l1_processor_file
cat /dev/null > $l2l1_processor_file
printf "METRICS_HTTP_PORT=46062\n" >> $l2l1_processor_file
bash make_db_env.sh $l2l1_processor_file
printf "\n" >> $l2l1_processor_file
bash make_mq_env.sh $l2l1_processor_file
printf "\n" >> $l2l1_processor_file
printf "PROCESSOR_PRIVATE_KEY=$bridge_processor_sk_l1\n" >> $l2l1_processor_file
printf "DEST_BRIDGE_ADDRESS=${ADDR_BRIDGE_L1}\n" >> $l2l1_processor_file
printf "SRC_ERC20_VAULT_ADDRESS=${ADDR_ERC20_VAULT_L2}\n" >> $l2l1_processor_file
printf "DEST_ERC20_VAULT_ADDRESS=${ADDR_ERC20_VAULT_L1}\n" >> $l2l1_processor_file
printf "DEST_ERC721_VAULT_ADDRESS=${ADDR_ERC721_VAULT_L1}\n" >> $l2l1_processor_file
printf "DEST_ERC1155_VAULT_ADDRESS=${ADDR_ERC1155_VAULT_L1}\n" >> $l2l1_processor_file
printf "DEST_TAIKO_ADDRESS=${ADDR_TAIKO_L1}\n" >> $l2l1_processor_file
printf "SRC_SIGNAL_SERVICE_ADDRESS=${ADDR_SIGNAL_SERVICE_L2}\n" >> $l2l1_processor_file
printf "SRC_RPC_URL=${WS_URL_L2}\n" >> $l2l1_processor_file
printf "DEST_RPC_URL=${RPC_URL_L1}\n" >> $l2l1_processor_file
printf "CONFIRMATIONS_BEFORE_PROCESSING=2\n" >> $l2l1_processor_file
printf "CORS_ORIGINS=*\n" >> $l2l1_processor_file
printf "NUM_GOROUTINES=50\n" >> $l2l1_processor_file
printf "BLOCK_BATCH_SIZE=100\n" >> $l2l1_processor_file
printf "HEADER_SYNC_INTERVAL_IN_SECONDS=2\n" >> $l2l1_processor_file