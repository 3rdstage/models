
### Ethereum Signing

* Transaction signing in practice
    * Create a transaction data structure, containing 9 fields: `[nonce, gasPrice, gasLimit, to, value, data, chainID, 0, 0]`
    * Produce an RLP-encoded serialized message of the transaction data structure
    * Compute the Keccak256 hash of this serialized message
    * Compute the ECDSA signature, signing the hash with the originating EOA’s private key.
    * Append the ECDSA signature’s computed v, r, and s values to the transaction.

#### web3.js/ethereumjs

* [`Accounts.prototype.signTransaction(tx, privateKey, callback)`](https://github.com/ChainSafe/web3.js/blob/v1.7.0/packages/web3-eth-accounts/src/index.js#L146)
    * [`signed(tx)`](https://github.com/ChainSafe/web3.js/blob/v1.7.0/packages/web3-eth-accounts/src/index.js#L182)
        * [`static TransactionFactory.fromTxData(txData, txOptions)`](https://github.com/ethereumjs/ethereumjs-monorepo/blob/%40ethereumjs/tx%403.4.0/packages/tx/src/transactionFactory.ts#L22)
        * [`BaseTransaction.sign(privateKey: Buffer)`](https://github.com/ethereumjs/ethereumjs-monorepo/blob/%40ethereumjs/tx%403.4.0/packages/tx/src/baseTransaction.ts#L289)
            * [`LegacyTransaction.getMessageToSign(hashMessage)`](https://github.com/ethereumjs/ethereumjs-monorepo/blob/%40ethereumjs/tx%403.4.0/packages/tx/src/legacyTransaction.ts#L210)
                * [`util.rlphash(a)`](https://github.com/ethereumjs/ethereumjs-monorepo/blob/ethereumjs-util%407.1.0/packages/util/src/hash.ts#L157)
                    * [`rlp.encode(input)`](https://github.com/ethereumjs/rlp/blob/v2.2.6/src/index.ts#L14)
                * [`util.keccak(a: Buffer, bits: number = 256)`](https://github.com/ethereumjs/ethereumjs-monorepo/blob/cc9872972a657583eb1e3ef8d04b9f5b72562466/packages/util/src/hash.ts#L12) 
            * [`ecsign(msgHash: Buffer, privateKey: Buffer, chainId: any)`](https://github.com/ethereumjs/ethereumjs-monorepo/blob/ethereumjs-util%407.1.3/packages/util/src/signature.ts#L25)
                * `const v = chainId ? recovery + (chainId * 2 + 35) : recovery + 27`

##### Web3j

* [`org.web3j.tx.RawTransactionManager.sendTransaction()`](https://github.com/web3j/web3j/blob/v4.8.8/core/src/main/java/org/web3j/tx/RawTransactionManager.java#L111)
* [`org.web3j.crypto.RawTransaction.createTransaction()`](https://github.com/web3j/web3j/blob/v4.8.8/crypto/src/main/java/org/web3j/crypto/RawTransaction.java#L85)
* [`org.web3j.crypto.transaction.type.LegacyTransaction.createTransaction()`](https://github.com/web3j/web3j/blob/v4.8.8/crypto/src/main/java/org/web3j/crypto/transaction/type/LegacyTransaction.java#L128)
* [`org.web3j.crypto.transaction.type.LegacyTransaction.LegacyTransaction()`](https://github.com/web3j/web3j/blob/v4.8.8/crypto/src/main/java/org/web3j/crypto/transaction/type/LegacyTransaction.java#L52)
* [`org.web3j.crypto.RawTransaction.RawTransaction()`](https://github.com/web3j/web3j/blob/v4.8.8/crypto/src/main/java/org/web3j/crypto/RawTransaction.java#L31)
* [`org.web3j.tx.RawTransactionManager.signAndSend()`](https://github.com/web3j/web3j/blob/v4.8.8/core/src/main/java/org/web3j/tx/RawTransactionManager.java#L193)
* [`org.web3j.tx.RawTransactionManager.sign()`](https://github.com/web3j/web3j/blob/v4.8.8/core/src/main/java/org/web3j/tx/RawTransactionManager.java#L180)
* [`org.web3j.crypto.TransactionEncoder.signMessage()`](https://github.com/web3j/web3j/blob/v4.8.8/crypto/src/main/java/org/web3j/crypto/TransactionEncoder.java#L42)
* [`org.web3j.crypto.TransactionEncoder.encode()`](https://github.com/web3j/web3j/blob/v4.8.8/crypto/src/main/java/org/web3j/crypto/TransactionEncoder.java#L83)
* [`org.web3j.crypto.Sign.SignatureData()`](https://github.com/web3j/web3j/blob/v4.8.8/crypto/src/main/java/org/web3j/crypto/Sign.java#L340)
* ...

