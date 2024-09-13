uname=`uname`

if [ ${uname} = "Darwin" ]; then
  sed -i "" -e "s/TAIKO_MAINNET = 167_000/TAIKO_MAINNET = ${CHAIN_ID_L2}/g" contracts/libs/LibNetwork.sol
elif [ ${uname} = "Linux" ]; then
  sed -i "s/TAIKO_MAINNET = 167_000/TAIKO_MAINNET = ${CHAIN_ID_L2}/g" contracts/libs/LibNetwork.sol
fi