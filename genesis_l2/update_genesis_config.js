const fs = require('fs');

let genesis_config = require('./genesis_config_template.js');

const contract_owner = process.env.CONTRACT_OWNER;
const l1_chain_id = process.env.CHAIN_ID_L1;
const chain_id = process.env.CHAIN_ID_L2;
const seed_accounts_file = process.env.SEED_ACCOUNTS_FILE;
const init_amount = process.env.INIT_AMOUNT;

genesis_config.contractOwner = contract_owner;
genesis_config.l1ChainId = parseInt(l1_chain_id, 10);
genesis_config.chainId = parseInt(chain_id, 10);

let seed_accounts_arr = fs.readFileSync(seed_accounts_file, 'utf8').split('\n');
seed_accounts_arr = seed_accounts_arr.filter((line)=>{if (line) return true}).map(account => {
    let obj = {};
    obj[account] = parseInt(init_amount, 10);
    return obj;
});
genesis_config.seedAccounts = seed_accounts_arr;

fs.writeFileSync('./genesis_config.js', 'module.exports = ' + JSON.stringify(genesis_config, null, 4));