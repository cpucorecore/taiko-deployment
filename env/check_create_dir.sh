source deployment_dir.env

if [ -d ${DEPLOYMENT_ROOT} ]; then
  echo "deployment root: ${DEPLOYMENT_ROOT} exist, backup and delete it to continue"
  exit -1
fi

dir_list=(${ACCOUNT_ROOT} ${JWT_ROOT} ${EXPLORER_L1_ROOT} ${EXPLORER_L2_ROOT} ${PREPARE_L1} ${PREPARE_L2} ${TX_TEST_ROOT})
for dir in ${dir_list[@]}
do
  if [ ! -d ${dir} ]; then
    mkdir -p ${dir}
  fi
done