
### Sequence diagram represenstation

#### Current code

~~~text

  transferFrom(from, to, tokenId)     _isApprovedOrOwner     _transferFrom(from, to, tokenId)
         |                                      |                          |
         +------------------------------------>[ ]                         |
         |                                      |                          |
         |                                      |                          |
         +--------------------------------------------------------------->[ ]
         |                                      |                          |


  safeTrasferFrom          safeTransferFrom               _isApprovedOrOwner      _safeTransferFrom              _trasferFrom             _checkOnERC721Received
   (from, to, tokenId)      (from, to, tokenId, data)      (spender, tokenId)      (from, to, tokenId, data)      (from, to, tokenId)       (from, to, tokenId, data)
         |                            |                            |                         |                            |                         |
         +-------------------------->[ ]                           |                         |                            |                         |
         |                           [ +------------------------->[ ]                        |                            |                         |
         |                           [ ]                           |                         |                            |                         |
         |                           [ +--------------------------------------------------->[ ]                           |                         |
         |                           [ ]                           |                        [ +------------------------->[ ]                        |
         |                           [ ]                           |                        [ ]                           |                         |
         |                           [ ]                           |                        [ +--------------------------------------------------->[ ]
         |                           [ ]                           |                        [ ]                           |                         |
         |                            |                            |                         |                            |                         |
         |                            |                            |                         |                            |                         |

~~~

### Call tree represenstation

#### Current codes

~~~text

  transferFrom(from, to, tokenId)
         |
         +------------> _isApprovedOrOwner(spender, tokenId)
         |
         +------------> _transferFrom(from, to, tokenId)


  safeTransferFrom(from, to, tokenId)
         |
         +----------> safeTransferFrom(from, to, tokenId, data)
                                  |
                                  +----------> _isApprovedOrOwner(spender, tokenId)
                                  |
                                  +----------> _safeTransferFrom(from, to, tokenId, data)
                                                         |
                                                         +----------> _transferFrom(from, to, tokenId)
                                                         |
                                                         +----------> _checkOnERC721Received(from, to, tokenId, data)

~~~


#### Proposed code

~~~text

  transferFrom(from, to, tokenId)
         |
         +------------> _transferFrom(from, to, tokenId)


  safeTransferFrom(from, to, tokenId)
         |
         +----------> safeTransferFrom(from, to, tokenId, data)
                                  |
                                  +----------> _safeTransferFrom(from, to, tokenId, data)
                                                         |
                                                         +----------> _transferFrom(from, to, tokenId)
                                                         |                      |
                                                         |                      +----------> _isApprovedOrOwner(spender, tokenId)
                                                         |
                                                         +----------> _checkOnERC721Received(from, to, tokenId, data)
~~~

#### Enhancement

* The `_transferFrom` function become to contain full preconditions and to get more coherent and reusable.
* Code readability also improved a little.
