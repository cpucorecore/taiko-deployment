help() {
  echo "api.sh [sk/addr] [l1/l2] [account_name]"
}

if [ $# -ne 3 ]; then
  help
  exit -1
fi

cmd=$1
if [ ${cmd} != "sk" -a ${cmd} != "addr" ]; then
  echo "wrong cmd, must 'sk' or 'addr'"
  help
  exit -1
fi

chain=$2
if [ ${chain} != "l1" -a ${chain} != "l2" ]; then
  echo "wrong chain, must 'l1' or 'l2'"
  help
  exit -1
fi

account_name=$3
key_file=accounts/${chain}/${account_name}
if [ ! -e ${key_file} ]; then
  printf "account %s not exist\n" $account_name
  exit -1
fi

if [ ${cmd} = "sk" ]; then
  sk=`grep "Private key" ${key_file} | awk '{print $3}'`
  echo ${sk}
else
  addr=`grep "Address" ${key_file} | awk '{print $2}'`
  echo ${addr}
fi