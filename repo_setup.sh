#!/bin/bash

# Set up Postman Env Files
echo 'Creating Postman Empty Test file'
export dir=$(basename `git rev-parse --show-toplevel`)
touch postman/$dir.json

# Set up Project Dependencies
echo 'Installing Project Dependencies'
pip install -r ./requirements/requirements.txt

echo 'Initialising Pre-commit Hooks'
pre-commit install






