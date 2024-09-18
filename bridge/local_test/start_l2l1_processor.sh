export RELAYER_ENV_FILE=./l2l1_processor.env
nohup ../relayer processor > l2l1_processor.log 2>&1 &
