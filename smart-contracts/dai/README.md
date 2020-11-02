### Concepts


| Concept | Description | Remarks |
| ------- | ----------- | ------- |
| **`lock`** | transfers calletral from a CDP owner to the system's token vault and records an increase of `ink` to the CDP's `Urn` |   |
| **`draw`** | mints new `DAI` for the owner of overcalletralized CDP. |   |
| **`Urn`** | data record for a CDP. |  |
| **`free`** | reclaims collateral from an overcalletralized CDP. |   |
| **`wipe`** |   |   |
| **`Ilk`** | data record for a CDP type. |   |
| **`feel`** | calculates the `Stage` of a CDP. |   |
| **`prod`** | updates the stability feedback mechanism. |   |


### Structure

```solidity

contract End is LibNote{


  mapping(bytes32 => uint256) public tag;


}

```

```solidity

contract Vat{

  mapping(bytes32 => mapping (address => Urn) urns

}
```