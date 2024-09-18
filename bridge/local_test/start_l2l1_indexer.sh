export RELAYER_ENV_FILE=./l2l1_indexer.env
nohup ../relayer indexer > l2l1_indexer.log 2>&1 &
