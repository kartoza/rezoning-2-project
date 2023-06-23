![image](https://github.com/LunaAsefaw/rezoning-2-project/assets/90245715/667fe560-1cc6-4721-b60b-a0fd460e1d2b)

## How to run the backend locally:

The API for rezoning contains two parts: the **Rezoning API** and the **Export Function**. Each needs to be run individually. But before running any of the two, localstack needs to be running.


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

## Running localstack:
- Make sure you have localstack setup by following instructions from [LocalStack CLI offical install instruction](https://docs.localstack.cloud/getting-started/installation/#localstack-cli)
## Start LocalStack in the background:  
Start local stack using:  


```
localstack start -d
```


> **Note:** One common problem might happen with permissions, here is an article on how to fix it: [Solving docker permissions](https://dhananjay4058.medium.com/solving-docker-permission-denied-while-trying-to-connect-to-the-docker-daemon-socket-2e53cccffbaa)


- ## Install aws cli tool:
    - Install AWS CLI tools by following instructions from [Installing or updating the latest version of the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
    - Check if aws cli was installed correctly using ```aws --version```: this will display the version of the installed aws-cli toolchain.

- Set up AWS configuration:
```
  aws configure

```
  It will ask for AWS Access Key, AWS Secret Key and Region, for example us-east-2.
  
- Create the SQS queue in localstack:  

```
aws sqs create-queue --queue-name export-queue --endpoint-url=http://localhost:4566/
```  

- Create the export bucket used to communicate the exporting requests between the API and the export function:  

```
aws s3 mb s3://rezoning-exports --endpoint-url=http://localhost:4566/
```

## Running Rezoning API:
In order to work with Rezoning locally, you need AWS access to the processed data (Currently around 330Gb of data) and a certain Airtable. 

- You can do this by setting the following environment variables:  Replace <%> with the keys but omit <%>

```
export AIRTABLE_KEY=<%AIRTABLE_KEY> AWS_ACCESS_KEY_ID=<%AWS_ACCESS_KEY_ID> AWS_SECRET_ACCESS_KEY=<%AWS_SECRET_ACCESS_KEY>
```

- Optional: 
If your network is slow, you need to download data using the following command that will make sure every file in the AWS data bucket will be copied over locally to the rezoning-data directory in your home directory:

```
aws s3 cp s3://gre-processed-data/ ~/rezoning-data/
```

- Optional:
To work with the local data, the following environment variables need to be set:  

```
export REZONING_IS_LOCAL_DEV=True
export REZONING_LOCAL_DATA_PATH=<%YOUR_DATA_PATH>
```


- Install the dependencies using:

```
pip install -e '.[dev]'
```

- Install [Uvicorn](https://www.uvicorn.org/) using:  

```
pip install uvicorn
```

- Start the server using:

```
python3 -m uvicorn rezoning_api.main:app --reload
```

### Run export function locally:  

> **Note:**: Make sure to replace **<% %>** placeholders with your AWS information before running the code below.

```
export AIRTABLE_KEY=<%AIRTABLE_KEY> AWS_ACCESS_KEY_ID=<%AWS_ACCESS_KEY_ID> AWS_SECRET_ACCESS_KEY=<%AWS_SECRET_ACCESS_KEY>
REGION=us-east-2 REZONING_IS_LOCAL_DEV=True QUEUE_NAME=export-queue 
```
