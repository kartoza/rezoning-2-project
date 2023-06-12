
# Clone the frontend:
First you need to fetch the source code for the frontend using the following command:  

```
git clone https://github.com/worldbank/WB-rezoning-explorer.git
```   

Move into the directory using:  


```
cd WB-rezoning-explorer
```

# Building the frontend:

To buid the frontend properly a specific version of Node needs to be used.

- Setup node version manager (nvm) following instructions from [NVM github](https://github.com/nvm-sh/nvm)
- install nodejs 12 using the commands:
```
nvm install v12
nvm use v12
```  

- Install Yarn on ubunut using:  

```
npm install -g yarn
```  

- Install npm dependendencies using:

```
yarn install
```  

- Start server with live code reload at [http://localhost:9000](http://localhost:9000):  

```
yarn serve
```  

- Run tests with:  

```
yarn test
```

# Using the front end with different rezoning API deployment setting: 

- In ```app/scripts/config/``` there are setting files for each envirnment type (local, production or staging).
- You can set which envirnment to use by setting NODE_ENV envirnment variable to "testing", "staging" or "development". 
- You can use a different MapBox key by writing a different mbToken in the config file.
- apiEndpoint in the settings file indicates the URL to the rezoning-explorer-api in use.
