

```dbml

table chain {
  id int [pk]
  name varchar(200) [not null]
  endpoint varchar(300)
  explorer_url varchar(300)
  is_valid bool [not null, default: true]
  descr text

}

table eth_acct {
  addr char(42) [pk]
  type_cd varchar(30)
  pub_key char(130)
  is_valid bool [not null, default: true]
  created_at timestamp
  invalid_at timestamp
}

table contract {
  chain_id int [pk]
  addr char(42) [pk]
  contr_src_id int [not null]
  deployer_addr char(42)
  deploy_tx_hash char(66)
  deployed_at timestamp
}

ref: chain.id > contract.chain_id
ref: eth_acct.addr > contract.deployer_addr



```