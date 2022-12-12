### Infrastructure Documentation

The software has 2 main parts:
## The front end: 
- The front facing interface of the software built with ReactJS. 
- The code's repository is at [WB-rezoning-explorer](https://github.com/worldbank/WB-rezoning-explorer). 
- The front end uses [MapBox](https://www.mapbox.com/) to display the map.

## The backend: 
- The backend of the application providing access to a list of API calls that can be explored at [API-docs](https://d2b8erzy6y494p.cloudfront.net/docs)
- The backend's code is at [WB-rezoning-explorer-api](https://github.com/worldbank/WB-rezoning-explorer-api)


## Backend architecture:

Depending on the API calls made, some different parts of the infrastructure will be triggered

- Export endpoint: 
![image](../img/backend-endpoint-export-architecture.png)
The backend will put a request into the SQS export queue. A seperate queue processing code will process the export request and in the meantime an export id will be returned to the caller. The caller waits asynchrounosly for the export to finish and investigates the export progrgress using the API end point '/v1/export/status/{id}'
- Filter endpoint:
Will take a tile from a dataset stored in the data S3 bucket and apply filters to it and return a Tile.
- Zone, LCOE, score endpoint:
Will do same calculations on an area using data stored in the data S3 bucket.
- Layers endpoint:
Will return the list of layers or a tile from that layer. 

## Additional dependencies:
- Airtable: A table that stores IRENA dataset needed by the application.
- [vector tile server](reztileserver.com): Some vector tile layers are hosted in this address. 

## Software componenets:
- Frontend app server.
- Backend api server.
- AWS SQS queue.
- AWS S3 Export bucket.
- AWS S3 Data bucket.
- AWS SQS queue processor (rezoning-explorer-api/export/export.py).
- Airtable: IRENA dataset.
- [vector tile server](reztileserver.com): Vector tiles server.
