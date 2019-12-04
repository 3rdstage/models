
# Model for core concepts in Hashicorp Vault


* Core Concepts
    * encryption keys
    * unseal keys
    * initial root token


## Core Workflow

* Init
    * The key used to encrypt data is also encrypted using 256-bit AES in CGM mode. -> master     * The encrypted encryption key is stored in the backend storage.
    * The master key is then split using Shamir's Secret Sharing. -> unseal keys
    * To decrypt the data, a threshold number of keys are required to unseal the Vault.
    * These keys are expected to be with three different places/individuals.
    * Root tokens are tokens that have the root policy attached to them. Root tokens can do anything in Vault.
    * The Vault team recommends that root tokens are only used for just enough initial setup (usually, setting up auth methods and policies necessary to allow administrators to acquire more limited tokens) or in emergencies, and are revoked immediately after they are no longer needed.

* Authentication
    * Before a client can interact with Vault, it must authenticate against an auth method.
    * Upon authentication, a token is generated.
    * This token is conceptually similar to a session ID on a website.
    * Authentication works by verifying your identity and then generating a token to associate with that identity.


## References

* [Authentication](https://www.vaultproject.io/docs/concepts/auth.html)
* [Tokens](https://www.vaultproject.io/docs/concepts/tokens.html)
