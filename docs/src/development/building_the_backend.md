## How to run the backend locally

The API of rezoning contains 2 parts: the rezoning API and the export function. Each needs to be run individually. But before running any of the 2, Localstack needs to be running.

## Clone repo & checkout to the development branch:
1. First, you need to fetch the source code for the backend using the following command:
```sh
git clone https://github.com/worldbank/WB-rezoning-explorer-api.git
```
2. Move into the directory using:
```sh
cd WB-rezoning-explorer-api
```
3. Using the current development branch (the main branch contains the production code)
```sh
git checkout develop_belgacem
```
## Running Localstack:
1. Make sure you have Localstack setup by following instructions from [Localstack's CLI official install instruction](https://docs.localstack.cloud/getting-started/installation/#localstack-cli)
- Start LocalStack in the background: 
```sh
localstack start -d
```

2. One common problem might happen with permissions, here is an article on how to fix it: [Docker permissions issue fix](https://dhananjay4058.medium.com/solving-docker-permission-denied-while-trying-to-connect-to-the-docker-daemon-socket-2e53cccffbaa)


2. Install AWS CLI tool:
    - Install AWS CLI tools by following instructions from [the AWS CLI official install instructions](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
    - Check if AWS CLI was installed correctly using `aws --version`: this will display the version of the installed AWS-CLI toolchain.


3. Configure AWS CLI with dummy credentials:
```sh
echo "test\ntest\nus-east-2\njson" | aws configure
```

4. Create the SQS queue in Localstack:
```sh
aws sqs create-queue --queue-name export-queue --region us-east-2 --endpoint-url=http://localhost:4566/
```
5. Create the export bucket used to communicate the exporting requests between the API and the export function:
```sh
aws s3 mb s3://rezoning-exports --endpoint-url=http://localhost:4566/
```

## Running Rezoning API:
To work with Rezoning locally, you need AWS access to the processed data (Currently around 330Gb of data) and a certain Airtable. 

1. You can do this by setting the following environment variables:
```sh
export AIRTABLE_KEY=<%AIRTABLE_KEY> AWS_ACCESS_KEY_ID=<%AWS_ACCESS_KEY_ID> AWS_SECRET_ACCESS_KEY=<%AWS_SECRET_ACCESS_KEY>
```

2. Optional: 
If your network is slow, you need to download data using the following command that will make sure every file in the AWS data bucket will be copied over locally to the rezoning-data directory in your home directory:

```sh
aws s3 cp s3://gre-processed-data/ ~/rezoning-data/
```

3. Optional:
To work with the local data, the following environment variables need to be set:
```sh
export REZONING_IS_LOCAL_DEV=True
export REZONING_LOCAL_DATA_PATH=<%YOUR_DATA_PATH>
```


4. Install the dependencies using:

```sh
pip install -e '.[dev]'
```

5. Install [Uvicorn](https://www.uvicorn.org/) using:
```sh
pip install uvicorn
```

6. Start the server using:

```sh
python3 -m uvicorn rezoning_api.main:app --reload
```

7. View the API endpoints at http://127.0.0.1:8000/docs/

### Run export function locally:
```sh
export AIRTABLE_KEY=<%AIRTABLE_KEY> AWS_ACCESS_KEY_ID=<%AWS_ACCESS_KEY_ID> AWS_SECRET_ACCESS_KEY=<%AWS_SECRET_ACCESS_KEY>
REGION=us-east-2 REZONING_IS_LOCAL_DEV=True QUEUE_NAME=export-queue python ./export/export.py
```
