#!/bin/bash

# Set up Postman Env Files
echo 'Creating Postman Empty Test file'
export dir=$(basename `git rev-parse --show-toplevel`)
touch postman/$dir.json

# Set up pip-compile to compile requirements files
pip install pip-tools
pip-compile --allow-unsafe --output-file=requirements/workflow-requirements.txt requirements/workflow-requirements.in
pip-compile --allow-unsafe --output-file=requirements/test-requirements.txt requirements/test-requirements.in
pip-compile --allow-unsafe --output-file=requirements/requirements.txt requirements/requirements.in

# Set up Project Dependencies
echo 'Installing Project Dependencies'
pip install -r ./requirements/test-requirements.txt

echo 'Initialising Pre-commit Hooks'
pre-commit install






