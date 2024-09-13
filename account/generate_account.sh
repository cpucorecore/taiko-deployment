source ../env/deployment_dir.env

if [ -d "accounts" ]; then
  mv accounts accounts.`date +%s`
fi

for chain in `ls chains`
do
  accounts_path=accounts/${chain}

  if [ ! -e ${accounts_path} ]; then
    mkdir -p ${accounts_path}
  fi

  for account_name in `cat chains/${chain}`
  do
    cast wallet new-mnemonic > ${accounts_path}/${account_name}
  done

  grep Address ${accounts_path}/* | awk '{print $2}' > ${accounts_path}/index
done

cp -r accounts api.sh ${ACCOUNT_ROOT}
