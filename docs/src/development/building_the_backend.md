## How to run the backend locally

The API of rezoning contains 2 parts: the rezoning API and the export function. Each needs to be run individually. But before running any of the 2, Localstack needs to be running.

## Clone repo & checkout to the development branch:
First, you need to fetch the source code for the backend using the following command:
```
git clone https://github.com/worldbank/WB-rezoning-explorer-api.git
```
Move into the directory using:
```
cd WB-rezoning-explorer-api
```
Using the current development branch (the main branch contains the production code)
```
git checkout develop_belgacem
```
## Running Localstack:
- Make sure you have Localstack setup by following instructions from [Localstack's CLI official install instruction](https://docs.localstack.cloud/getting-started/installation/#localstack-cli)
- Start LocalStack in the background: 
```sh
localstack start -d
```

- One common problem might happen with permissions, here is an article on how to fix it https://dhananjay4058.medium.com/solving-docker-permission-denied-while-trying-to-connect-to-the-docker-daemon-socket-2e53cccffbaa


- Install AWS CLI tool:
    - Install AWS CLI tools by following instructions from: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
    - Check if AWS CLI was installed correctly using ```aws --version```: this will display the version of the installed AWS-CLI toolchain.


- Create the SQS queue in Localstack:
```
aws sqs create-queue --queue-name export-queue --endpoint-url=http://localhost:4566/
```
- Create the export bucket used to communicate the exporting requests between the API and the export function:
```sh
aws s3 mb s3://rezoning-exports --endpoint-url=http://localhost:4566/
```

## Running Rezoning API:
To work with Rezoning locally, you need AWS access to the processed data (Currently around 330Gb of data) and a certain Airtable. 

- You can do this by setting the following environment variables:
```sh
export AIRTABLE_KEY=<%AIRTABLE_KEY> AWS_ACCESS_KEY_ID=<%AWS_ACCESS_KEY_ID> AWS_SECRET_ACCESS_KEY=<%AWS_SECRET_ACCESS_KEY>
```

- Optional: 
If your network is slow, you need to download data using the following command that will make sure every file in the AWS data bucket will be copied over locally to the rezoning-data directory in your home directory:

```sh
aws s3 cp s3://gre-processed-data/ ~/rezoning-data/
```

- Optional:
To work with the local data, the following environment variables need to be set:
```sh
export REZONING_IS_LOCAL_DEV=True
export REZONING_LOCAL_DATA_PATH=<%YOUR_DATA_PATH>
```


- Install the dependencies using:

```sh
pip install -e '.[dev]'
```

- Install [Uvicorn](https://www.uvicorn.org/) using:
```
pip install uvicorn
```

- Start the server using:

```sh
python -m uvicorn rezoning_api.main:app --reload
```

### Run export function locally:
```sh
export AIRTABLE_KEY=<%AIRTABLE_KEY> AWS_ACCESS_KEY_ID=<%AWS_ACCESS_KEY_ID> AWS_SECRET_ACCESS_KEY=<%AWS_SECRET_ACCESS_KEY>
REGION=us-east-2 REZONING_IS_LOCAL_DEV=True QUEUE_NAME=export-queue python ./export/export.py
```
