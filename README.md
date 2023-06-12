![rezoningcover](https://github.com/kartoza/rezoning-2-project/assets/107027990/2c784caf-b110-42c1-8670-1ee5a8f44bf9)

# rezoning-2-project

- [Rezoning technical docs](https://kartoza.github.io/rezoning-2-project/) site for development of the second version of [Rezoning](https://rezoning.energydata.info/).
- The code for rezoning is available at:
    - Backend: [rezoning-explorer-api](https://github.com/worldbank/WB-rezoning-explorer-api)
    - Frontend: [rezoning-explorer](https://github.com/worldbank/WB-rezoning-explorer)


# Building the document locally

- Assuming that you have python3 installed, run the following commands to install the necessary modules:
```
pip install mkdocs
pip install mkdocs-material
pip install mkdocs-material-extensions
```

- View on the browser locally using the following commands:

```
cd ./docs
./create-mkdocs-html-config.sh
python3 -m mkdocs serve
```
