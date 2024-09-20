./start_local_testnet.sh 2>&1 | tee -a output
if [ $? -eq 0 ]; then
  bash get_ports.sh
else
  echo "start lighthouse failed"
fi