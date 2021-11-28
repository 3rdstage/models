
Ethereum Signing
====

* Transaction signing in practice
    * Create a transaction data structure, containing 9 fields: nonce, gasPrice, gasLimit, to, value, data, chainID, 0, 0
    * Produce an RLP-encoded serialized message of the transaction data structure
    * Compute the Keccak256 hash of this serialized message
    * Compute the ECDSA signature, signing the hash with the originating EOA’s private key.
    * Append the ECDSA signature’s computed v, r, and s values to the transaction.

web3.js
=====

~~~~
[nonce, gasPrice, gasLimit, to , value, data, chainId, 0, 0]

Transaction.getMessageToSign() 
-> Transaction._getMessageToSign()
-> rlphash                     / ethereumj-util             
-> rlp.encode                  / rlp     
~~~~                               

ethereumjs
=====

* https://github.com/ethereumjs/ethereumjs-monorepo/blob/%40ethereumjs/tx%403.3.0/packages/tx/src/legacyTransaction.ts#L208
* https://github.com/ethereumjs/ethereumjs-monorepo/blob/%40ethereumjs/tx%403.3.0/packages/tx/src/legacyTransaction.ts#L172
* https://github.com/ethereumjs/ethereumjs-monorepo/blob/ethereumjs-util%407.1.0/packages/util/src/hash.ts#L157
* https://github.com/ethereumjs/rlp/blob/v2.2.6/src/index.ts#L14


Web3j
=====

* `org.web3j.tx.RawTransactionManager.sendTransaction()`
    * https://github.com/web3j/web3j/blob/v4.8.8/core/src/main/java/org/web3j/tx/RawTransactionManager.java#L111
* `org.web3j.crypto.RawTransaction.createTransaction()`
    * https://github.com/web3j/web3j/blob/v4.8.8/crypto/src/main/java/org/web3j/crypto/RawTransaction.java#L85
* `org.web3j.crypto.transaction.type.LegacyTransaction.createTransaction()`
    * https://github.com/web3j/web3j/blob/v4.8.8/crypto/src/main/java/org/web3j/crypto/transaction/type/LegacyTransaction.java#L128
* `org.web3j.crypto.transaction.type.LegacyTransaction.LegacyTransaction()`
    * https://github.com/web3j/web3j/blob/v4.8.8/crypto/src/main/java/org/web3j/crypto/transaction/type/LegacyTransaction.java#L52
* `org.web3j.crypto.RawTransaction.RawTransaction()`
    * https://github.com/web3j/web3j/blob/v4.8.8/crypto/src/main/java/org/web3j/crypto/RawTransaction.java#L31
* `org.web3j.tx.RawTransactionManager.signAndSend()`
    * https://github.com/web3j/web3j/blob/v4.8.8/core/src/main/java/org/web3j/tx/RawTransactionManager.java#L193
* `org.web3j.tx.RawTransactionManager.sign()`
    * https://github.com/web3j/web3j/blob/v4.8.8/core/src/main/java/org/web3j/tx/RawTransactionManager.java#L180
* `org.web3j.crypto.TransactionEncoder.signMessage()`
    * https://github.com/web3j/web3j/blob/v4.8.8/crypto/src/main/java/org/web3j/crypto/TransactionEncoder.java#L42
* `org.web3j.crypto.TransactionEncoder.encode()`
    * https://github.com/web3j/web3j/blob/v4.8.8/crypto/src/main/java/org/web3j/crypto/TransactionEncoder.java#L83
* `org.web3j.crypto.Sign.SignatureData()`
    * https://github.com/web3j/web3j/blob/v4.8.8/crypto/src/main/java/org/web3j/crypto/Sign.java#L340
* ...

    