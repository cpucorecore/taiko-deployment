source ../env/l1_chain_id.env
source ../env/l2_chain_id.env

get_contract_owner_fail=0
pushd ../account
contract_owner=`bash api.sh addr l2 contract_owner`
if [ $? -ne 0 ]; then
  get_contract_owner_fail=1
fi
popd

if [ $get_contract_owner_fail -eq 1 ]; then
  echo "get contract owner fail"
  exit -1
fi

export CONTRACT_OWNER=${contract_owner}
export SEED_ACCOUNTS_FILE=../account/accounts/l2/index
export INIT_AMOUNT=10000000
