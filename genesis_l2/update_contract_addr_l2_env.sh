input_file=genesis_config.js
output_file=../env/contract_addr_l2.env

function get_address() {
  cat $input_file | grep $1 | awk -F '"' '{print $4}'
}

cat /dev/null > $output_file
printf "export ADDR_TAIKO_L2=%s\n" `get_address "\"TaikoL2\""` >> $output_file
printf "export ADDR_BRIDGE_L2=%s\n" `get_address "\"Bridge\""` >> $output_file
printf "export ADDR_SIGNAL_SERVICE_L2=%s\n" `get_address "\"SignalService\""` >> $output_file
printf "export ADDR_SHARED_ADDRESS_MANAGER_L2=%s\n" `get_address "\"SharedAddressManager\""` >> $output_file