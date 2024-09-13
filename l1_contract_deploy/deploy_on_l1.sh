#!/bin/sh

PROPOSER=${PROPOSER} \
TAIKO_TOKEN=0x0000000000000000000000000000000000000000 \
PROPOSER_ONE=0x0000000000000000000000000000000000000000 \
GUARDIAN_PROVERS="0x1000777700000000000000000000000000000001,0x1000777700000000000000000000000000000002,0x1000777700000000000000000000000000000003,0x1000777700000000000000000000000000000004,0x1000777700000000000000000000000000000005,0x1000777700000000000000000000000000000006,0x1000777700000000000000000000000000000007" \
TAIKO_L2_ADDRESS=${ADDR_TAIKO_L2} \
L2_SIGNAL_SERVICE=${ADDR_SIGNAL_SERVICE_L2} \
CONTRACT_OWNER=${DEPLOYER} \
PROVER_SET_ADMIN=${DEPLOYER} \
TAIKO_TOKEN_PREMINT_RECIPIENT=${DEPLOYER} \
TAIKO_TOKEN_NAME="Taiko Token Test" \
TAIKO_TOKEN_SYMBOL=TKOt \
SHARED_ADDRESS_MANAGER=0x0000000000000000000000000000000000000000 \
L2_GENESIS_HASH=${L2_GENESIS_HASH} \
PAUSE_TAIKO_L1=false \
PAUSE_BRIDGE=false \
NUM_MIN_MAJORITY_GUARDIANS=7 \
NUM_MIN_MINORITY_GUARDIANS=2 \
TIER_PROVIDER="devnet" \
forge script script/DeployOnL1.s.sol:DeployOnL1 \
    --fork-url ${RPC_URL_L1} \
    --broadcast \
    --ffi \
    -vvvv \
    --private-key ${DEPLOYER_SK} \
    --block-gas-limit 100000000