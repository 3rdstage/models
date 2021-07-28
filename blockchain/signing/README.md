
Ethereum Signing
=====

* Transaction signing in practice
    * Create a transaction data structure, containing 9 fields: nonce, gasPrice, gasLimit, to, value, data, chainID, 0, 0
    * Produce an RLP-encoded serialized message of the transaction data structure
    * Compute the Keccak256 hash of this serialized message
    * Compute the ECDSA signature, signing the hash with the originating EOA’s private key.
    * Append the ECDSA signature’s computed v, r, and s values to the transaction.

~~~~
[nonce, gasPrice, gasLimit, to , value, data, chainId, 0, 0]

Transaction.getMessageToSign() 
-> Transaction._getMessageToSign()
-> rlphash                     / ethereumj-util             
-> rlp.encode                  / rlp     
~~~~                               

* https://github.com/ethereumjs/ethereumjs-monorepo/blob/%40ethereumjs/tx%403.3.0/packages/tx/src/legacyTransaction.ts#L208
* https://github.com/ethereumjs/ethereumjs-monorepo/blob/%40ethereumjs/tx%403.3.0/packages/tx/src/legacyTransaction.ts#L172
* https://github.com/ethereumjs/ethereumjs-monorepo/blob/ethereumjs-util%407.1.0/packages/util/src/hash.ts#L157
* https://github.com/ethereumjs/rlp/blob/v2.2.6/src/index.ts#L14
