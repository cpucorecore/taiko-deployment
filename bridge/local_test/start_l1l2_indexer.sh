export RELAYER_ENV_FILE=./l1l2_indexer.env
nohup ../relayer indexer > l1l2_indexer.log 2>&1 &
