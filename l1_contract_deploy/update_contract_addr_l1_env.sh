input_file=${TAIKO_MONO_PROTOCOL_DEPLOYMENTS_ROOT}/deploy_l1.json
output_file=../env/contract_addr_l1.env

function get_address() {
  cat ${input_file} | grep $1 | awk -F '"' '{print $4}'
}

cat /dev/null > $output_file
printf "export ADDR_TAIKO_L1=%s\n" `get_address "\"taiko\""` >> $output_file
printf "export ADDR_BRIDGE_L1=%s\n" `get_address "\"bridge\""` >> $output_file
printf "export ADDR_SIGNAL_SERVICE_L1=%s\n" `get_address "\"signal_service\""` >> $output_file
printf "export ADDR_TAIKO_TOKEN_L1=%s\n" `get_address "\"taiko_token\""` >> $output_file
printf "export ADDR_PROVER_SET_L1=%s\n" `get_address "\"prover_set\""` >> $output_file
printf "export ADDR_SHARED_ADDRESS_MANAGER_L1=%s\n" `get_address "\"shared_address_manager\""` >> $output_file
printf "export ADDR_ERC20_VAULT_L1=%s\n" `get_address "\"erc20_vault\""` >> $output_file
printf "export ADDR_ERC721_VAULT_L1=%s\n" `get_address "\"erc721_vault\""` >> $output_file
printf "export ADDR_ERC1155_VAULT_L1=%s\n" `get_address "\"erc1155_vault\""` >> $output_file