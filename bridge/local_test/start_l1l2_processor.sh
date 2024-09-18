export RELAYER_ENV_FILE=./l1l2_processor.env
nohup ../relayer processor > l1l2_processor.log 2>&1 &
