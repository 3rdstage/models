
* Model for core concepts in Hashicorp Vault


* Core Concepts
    * encryption keys
    * unseal keys
    * initial root token


* Core Workflow
    * The key used to encrypt data is also encrypted using 256-bit AES in CGM mode. -> master key
    * The encrypted encryption key is stored in the backend storage.
    * The master key is then split using Shamir's Secret Sharing.
    * To decrypt the data, a threshold number of keys are required to unseal the Vault.
    * These keys are expected to be with three different places/individuals.