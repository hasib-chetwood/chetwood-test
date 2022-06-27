install:
	pip install -r ./requirements/test-requirements.txt

pip-compile-all:
	pip install pip-tools
	pip-compile --allow-unsafe --output-file=requirements/workflow-requirements.txt requirements/workflow-requirements.in
	pip-compile --allow-unsafe --output-file=requirements/test-requirements.txt requirements/test-requirements.in
	pip-compile --allow-unsafe --output-file=requirements/requirements.txt requirements/requirements.in

# checks:
# 	pre-commit run --all-files

# unit-tests:
# 	pytest -m "not integration"

# watch-unit-tests:
# 	ptw . -m "not integration"

# integration-tests:
# 	pytest -m "integration"

# watch-integration-tests:
# 	ptw . -m integration

# all-tests:
# 	pytest

# mutation-tests:
# 	mutmut run

# deploy-non-prod:
# 	cdk deploy --all --hotswap --require-approval never

# deploy:
# 	cdk deploy --all --require-approval never

# get-deployed-api-url:
# 	tools/get-deployed-api-url.sh

# get-deployed-host-name:
# 	make get-deployed-api-url -s | sed 's/https:\/\///' | sed 's/\/.*//'

# get-deployed-path:
# 	make get-deployed-api-url -s | sed 's/\/$$//' | sed 's/.*\///'

# smoke-test:
# 	tools/smoke-test.sh

# zap-scan:
# 	tools/zap-scan.sh

# schemathesis:
# 	tools/schemathesis.sh

# cdk-diagram:
# 	npx cdk-dia

# api-docs:
# 	npx redoc-cli build docs/openapi.json
