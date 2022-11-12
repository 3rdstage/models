

## Collection

| Function | Endpoint | Remarks |
| -------- | -------- | ------- |
| Start a new collection | `POST collections?name={name}&symbol={symbol}[&descr={descr}][&type={type:ERC721}]` |   |
| List collections | `GET collections?[page={page:1}][&pageSize={pageSize:5}]` |   |
| Find recent collections | `GET collections/recent[?duration={days:5}][&type={type}]` |   |
| Find popular collections | `GET collections/popular[?type={type}]` |   |

## Asset

| Function | Endpoint | Remarks |
| -------- | -------- | ------- |
| Mint a new asset | `POST collections/{collectionId}/assets` |   |
| List assets from a collection | `GET collections/{collectionId}/assets?[page={page:1}][&pageSize={pageSize:5}][&from={from}][&to={to:$now}]` |   | 
| Find recently minted assets from a collection | `GET collections/{collectionId}/assets/recent[?limit={n:5}]` |
| Find recently transferred assets from a collection | `GET collections/{collectionId}/assets/active[?=limit={n:5}]` |   |  
| List assets from all collections | `GET collections/_/assets?[page={page:1}][&pageSize={pageSize:5][&from={from}][&to={to:$now}]` |   |
| Find recently minted assets from all collections | `GET collections/_/assets/recent[?limit={n:5}]` |
| Find recently transferred assets from a collection | `GET collections/{collectionId}/assets/active[?=limit={n:5}]` |   |  

## Asset Transfer

| Function | Endpoint | Remarks |
| -------- | -------- | ------- |
| Transfer an asset | `POST collections/{collectionId}/assets/{assetId}/transfer?sender={senderAddr}&recipient={recipientAddr}&amount={amount}` | async |
