# Clone the front end:
First, you need to fetch the source code for the front end using the following command:
```
git clone https://github.com/worldbank/WB-rezoning-explorer.git
```
Move into the directory using:
```
cd WB-rezoning-explorer
```

# Building the front end:

To build the front end properly a specific version of Node needs to be used.

- Setup node version manager (nvm) following instructions from [NVM Github](https://github.com/nvm-sh/nvm)
- install Nodejs 12 using the commands:
```
nvm install v12
nvm use v12
```
- Install Yarn on Ubuntu using:
```
npm install -g yarn
```
- Install npm dependencies using:
Start the server with live code reload at [http://localhost:9000](http://localhost:9000):
```
yarn serve
```
- Run tests with:
```
yarn test
```

# Using the front end with different rezoning API deployment settings: 

- In ```app/scripts/config/``` there are setting files for each environment type (local, production or staging).
- You can set which environment to use by setting the `NODE_ENV` environment variable to "testing", "staging" or "development". 
- You can use a different MapBox key by writing a different mbToken in the config file.
- ```apiEndpoint``` in the settings file indicates the URL to the ```rezoning-explorer-api``` in use.