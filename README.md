# deploy requirement

## hardware
| CPU  | MEM | HD   |
|------|-----|------|
| 8C16T | 32G | 300G |

## software dependencies
- jq
- foundry
- node
- golang
- openssl

## os
- ubuntu 24.04LTS


```bash
cd
git clone https://github.com/cpucorecore/taiko-deployment
cd taiko-deployment
```

# configure deployment root
modify `DEPLOYMENT_ROOT` in env/deployment_dir.env

```bash
pushd env
bash check_create_dir.sh
popd
```

# setup L1
2 options:
- deploy L1 --> `supply L1 env`
- `supply L1 env`

## deploy L1(optional)
```bash
pushd ${DEPLOYMENT_ROOT}
  git clone --depth 1 --branch v5.2.1 https://github.com/sigp/lighthouse.git
popd

cp l1/lighthouse.patch ${LIGHTHOUSE_L1_ROOT}
cp l1/*.sh ${LIGHTHOUSE_L1_LOCAL_TESTNET_ROOT}

pushd ${LIGHTHOUSE_L1_ROOT}
  git apply lighthouse.patch
  pushd ${LIGHTHOUSE_L1_LOCAL_TESTNET_ROOT}
    bash start.sh
  popd
popd
```

## supply L1 env
update env/l1.env

name | desc
-- | --
WS_URL_L1 | 
RPC_URL_L1 | 
BEACON_URL_L1 | 
http_protocol | http/https
ws_protocol | ws/wss
HOST_L1 | 
WS_PORT_L1 | 
RPC_PORT_L1 | 
BEACON_PORT_L1 | 

```bash
pushd env
bash update_l1_chain_id.sh
popd
```

# create accounts
```bash
pushd account
bash generate_account.sh
popd
```

# git clone repositories
```bash
source env/deployment_dir.env
pushd ${DEPLOYMENT_ROOT}
git clone --depth 1 --branch bridge-ui-v2.12.0 https://github.com/taikoxyz/taiko-mono.git
git clone --depth 1 --branch v1.5.0 https://github.com/taikoxyz/taiko-geth.git
popd
```

# apply patch
```bash
# taiko-mono
cp git_patch/taiko-mono.patch ${TAIKO_MONO_ROOT}
pushd ${TAIKO_MONO_ROOT}
git apply taiko-mono.patch
popd

# taiko-geth
cp git_patch/taiko-geth.patch ${TAIKO_GETH_ROOT}
pushd ${TAIKO_GETH_ROOT}
git apply taiko-geth.patch
popd
```

# generate L2 genesis
update env/l2_chain_id.env

```bash
pushd genesis_l2
source env.sh
node update_genesis_config.js
cp genesis_config.js ${TAIKO_MONO_PROTOCOL_GENESIS_ROOT}
bash update_contract_addr_l2_env.sh
popd
```

```bash
pushd ${TAIKO_MONO_PROTOCOL_ROOT}
pnpm install
rm -rf out && pnpm compile
pnpm run generate:genesis ${TAIKO_MONO_PROTOCOL_GENESIS_ROOT}/genesis_config.js
popd
```

# jwt
```bash
pushd jwt
bash generate_jwt.sh
mkdir -p ${JWT_ROOT}
mv jwt.txt ${JWT_ROOT}
popd
```

# taiko geth
```bash
pushd taiko_geth
  bash make_env.sh
  cp env.in start.sh ${TAIKO_GETH_ROOT}
  bash update_genesis_alloc.sh
  pushd ${TAIKO_GETH_ROOT}
    make geth
    bash start.sh
  popd
popd
```

# deploy l1 contract
```bash
pushd account
bash fund_l1_account.sh
popd
```

```bash
pushd l1_contract_deploy
    bash make_env.sh
    cp env deploy_on_l1.sh ${TAIKO_MONO_PROTOCOL_SCRIPT_ROOT}
    pushd ${TAIKO_MONO_PROTOCOL_ROOT}
      source ${TAIKO_MONO_PROTOCOL_SCRIPT_ROOT}/env
      pnpm test:local_deploy
    popd
    bash update_contract_addr_l1_env.sh
popd
```

# prepare l1

```bash
pushd prepare_l1
    bash make_env.sh
    cp env prepare-l1.sh ${PREPARE_L1}
    pushd ${PREPARE_L1}
      bash prepare-l1.sh
    popd
popd
```

# taiko client
```bash
pushd taiko_client
  bash make_env.sh
  cp env start-driver.sh start-proposer.sh start-prover.sh ${TAIKO_MONO_TAIKO_CLIENT_ROOT}
  pushd ${TAIKO_MONO_TAIKO_CLIENT_ROOT}
    make build
    bash start-driver.sh
    bash start-prover.sh
    bash start-proposer.sh
  popd
popd
```

# bridge

# explorer
