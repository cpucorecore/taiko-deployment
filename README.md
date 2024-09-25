deploy [taiko](https://github.com/taikoxyz/taiko-mono) local testnet

# deploy requirement

## hardware
| CPU  | MEM | HDD  |
|------|-----|------|
| 8C16T | 32G | 300G |

## software dependencies
- jq
- foundry
- node
- golang: 1.22.7(1.23.x not supported)
- openssl

## os
- ubuntu 24.04LTS 

macOS not tested

## network proxy
make sure the deployment env can access github, dockerhub, registry.npmjs.org

```bash
cd
git clone https://github.com/cpucorecore/taiko-deployment
cd taiko-deployment
```

# configure deployment root
modify `DEPLOYMENT_ROOT` in env/deployment_dir.env
```bash
source env/deployment_dir.env
```

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
git clone --depth 1 -b v5.3.0 https://github.com/sigp/lighthouse.git
popd

cp l1_deploy/lighthouse.patch ${LIGHTHOUSE_L1_ROOT}
cp l1_deploy/*.sh ${LIGHTHOUSE_L1_LOCAL_TESTNET_ROOT}

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
pushd ${DEPLOYMENT_ROOT}
git clone --depth 1 --branch bridge-ui-v2.12.0 https://github.com/taikoxyz/taiko-mono.git
git clone --depth 1 --branch v1.5.0 https://github.com/taikoxyz/taiko-geth.git

pushd ${EXPLORER_L1_ROOT}
  git clone https://github.com/blockscout/blockscout.git
  pushd blockscout
    git checkout 8382c357f4240b3e3c7704d2fb88986d685b0a6f
  popd
popd

pushd ${EXPLORER_L2_ROOT}
  git clone https://github.com/blockscout/blockscout.git
  pushd blockscout
    git checkout 8382c357f4240b3e3c7704d2fb88986d685b0a6f
  popd
popd

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

# explorer l1
cp explorer_l1/l1.patch ${EXPLORER_BS_L1_ROOT}
pushd ${EXPLORER_BS_L1_ROOT}
git apply l1.patch
popd

# explorer l2
cp explorer_l2/l2.patch ${EXPLORER_BS_L2_ROOT}
pushd ${EXPLORER_BS_L2_ROOT}
git apply l2.patch
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

### tips: make geth failed
if you `make geth` failed after you upgrade your macOS to Sequoia(version 15.0) you can try to replace `make geth` with cmd below:
```bash
go build -ldflags --buildid=none -tags urfave_cli_no_docs,gozkg -trimpath -v -o ./build/bin/geth ./cmd/geth
```

or upgrade go.mod with diff below:
```diff
diff --git a/go.mod b/go.mod
index b12ec2c..d6a175f 100644
--- a/go.mod
+++ b/go.mod
@@ -58,7 +58,7 @@ require (
 	github.com/shirou/gopsutil v3.21.4-0.20210419000835-c7a38de76ee5+incompatible
 	github.com/status-im/keycard-go v0.2.0
 	github.com/stretchr/testify v1.8.4
-	github.com/supranational/blst v0.3.11
+	github.com/supranational/blst v0.3.13
 	github.com/syndtr/goleveldb v1.0.1-0.20210819022825-2ae1ddf74ef7
 	github.com/tyler-smith/go-bip39 v1.1.0
 	github.com/urfave/cli/v2 v2.25.7

```

after update go.mod don't forget to run the command: 
```bash
go mod tidy
```

- ref [issue](https://github.com/taikoxyz/taiko-mono/issues/18168)
- ref [issue](https://github.com/ethereum/go-ethereum/issues/30494)

# deploy l1 contract
put private key into account/parent_account_l1.sk
```bash
pushd account
bash fund_l1_account_all.sh
popd
```

```bash
pushd l1_contract_deploy
    bash make_env.sh
    cp env deploy_on_l1.sh ${TAIKO_MONO_PROTOCOL_SCRIPT_ROOT}
    cp update_contract_chain_id_l2.sh ${TAIKO_MONO_PROTOCOL_ROOT}
    pushd ${TAIKO_MONO_PROTOCOL_ROOT}
      source ${TAIKO_MONO_PROTOCOL_SCRIPT_ROOT}/env
      bash update_contract_chain_id_l2.sh
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

### tips: `make build` failed:
[tips: make geth failed](#tips:-make-geth-failed)

# prepare l2
wait about 10min, let L2 generate some blocks

```bash
pushd prepare_l2
  bash make_env.sh
  cp env prepare-l2.sh ${PREPARE_L2}
    pushd ${PREPARE_L2}
      bash prepare-l2.sh
    popd
popd
```

# bridge
```bash
cp bridge/db.cfg.template bridge/db.cfg
cp bridge/mq.cfg.template bridge/mq.cfg
```

update bridge/db.cfg
update bridge/mq.cfg

```bash
pushd bridge
  bash make_env.sh
  cp -r local_test ${TAIKO_MONO_TAIKO_RELAYER_ROOT}
  pushd ${TAIKO_MONO_TAIKO_RELAYER_ROOT}
    go build -o relayer ./cmd/
    pushd docker-compose
      docker compose up -d
    popd
    pushd local_test
        bash start_l1l2_processor.sh
        bash start_l1l2_indexer.sh
        bash start_l2l1_processor.sh
        bash start_l2l1_indexer.sh
    popd
  popd
popd
```

# explorer
## start l1 explorer(optional)

### update config
#### blockscout/docker-compose/docker-compose.yml
```txt
environment:
    ETHEREUM_JSONRPC_HTTP_URL: http://{l1 host}:{l1 rpc port}/
    ETHEREUM_JSONRPC_TRACE_URL: http://{l1 host}:{l1 rpc port}/
    ETHEREUM_JSONRPC_WS_URL: ws://{l1 host}:{l1 ws port}/
    CHAIN_ID: '{l1 chain id}'
```

#### blockscout/docker-compose/envs/common-blockscout.env
```txt
ETHEREUM_JSONRPC_HTTP_URL=http://{l1 host}:{l1 rpc port}/
ETHEREUM_JSONRPC_TRACE_URL=http://{l1 host}:{l1 rpc port}/
```

#### blockscout/docker-compose/envs/common-frontend.env
```txt
NEXT_PUBLIC_API_HOST=192.168.100.77:20080
NEXT_PUBLIC_STATS_API_HOST=http://{deployment host ip}:28080
NEXT_PUBLIC_WALLET_CONNECT_PROJECT_ID=
NEXT_PUBLIC_NETWORK_RPC_URL={l1 host}:{l1 rpc port}
NEXT_PUBLIC_NETWORK_NAME=local eth testnet
NEXT_PUBLIC_NETWORK_SHORT_NAME=l1 chain
NEXT_PUBLIC_NETWORK_ID={l1 chain id}
NEXT_PUBLIC_NETWORK_CURRENCY_NAME=Tether
NEXT_PUBLIC_NETWORK_CURRENCY_SYMBOL=Eth
NEXT_PUBLIC_NETWORK_CURRENCY_DECIMALS=18
NEXT_PUBLIC_APP_HOST={deployment host ip}:20080
NEXT_PUBLIC_VISUALIZE_API_HOST=http://{deployment host ip}:28081
```

#### blockscout/docker-compose/proxy/default.conf.template
```txt
add_header 'Access-Control-Allow-Origin' 'http://{deployment host ip}:20080' always;
```

#### blockscout/docker-compose/proxy/microservices.conf.template
```txt
add_header 'Access-Control-Allow-Origin' 'http://{deployment host ip}:3001' always;
```

```bash
pushd ${EXPLORER_BS_L1_ROOT}/docker-compose
docker compose up -d
popd
```

## start l2 explorer
```bash
pushd ${EXPLORER_BS_L2_ROOT}/docker-compose
docker compose up -d
popd
```

# keep alive l2
txs in l2 will block forever in some cases, to bypass this issue and make l2 process the txs blocked:
```bash
pushd keep_alive_l2
bash make_env.sh
cp env keep_alive.sh ${KEEP_ALIVE_L2_ROOT}
pushd ${KEEP_ALIVE_L2_ROOT}
nohup bash keep_alive.sh > keep_alive.log 2>&1 &
popd
popd
```

# tx test l2
```bash
pushd test
  bash make_env.sh
  cp -r env bridge ${TX_TEST_ROOT}
  pushd ${TX_TEST_ROOT}/bridge
    bash bridge_eth_l1l2.sh # l1-->l2
    bash bridge_eth_l2l1.sh # l2-->l1
  popd
popd
```

## Stress Testing
[taiko-test](https://github.com/cpucorecore/taiko-test)

# some links
name | url | user&passwd
-- | -- | --
mq | http://{your deployment host ip}:15672/#/queues | bridge/mq.cfg
bridge db | jdbc:mysql://{your deployment host ip}:3306/relayer | bridge/db.cfg
L1 explorer(optional) | http://{your deployment host ip}:20080/ | -
L2 explorer | http://{your deployment host ip}/ | -

