#!/bin/bash

# This is only intended for local
# testing. See github workflows for 
# how this build is automated.

# this will create mkdocs.yml
./create-mkdocs-pdf-config.sh
# and this will build the PDF document
python -m mkdocs build > /tmp/document.html
