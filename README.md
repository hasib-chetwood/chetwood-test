[![chetwood](https://chetwood.co/static/dfb4b8ff9ef1be0e7e47420f097093c7/c1755/logo.png)](#)

[![CloudFormation Validation](https://github.com/chetwoodfinancial/chetwood-engineering-api-template/actions/workflows/validate-cloudformation.yaml/badge.svg?branch=master)](https://github.com/chetwoodfinancial/chetwood-engineering-api-template/actions/workflows/validate-cloudformation.yaml)
[![CloudFormation Testing](https://github.com/chetwoodfinancial/chetwood-engineering-api-template/actions/workflows/test-cloudformation.yaml/badge.svg)](https://github.com/chetwoodfinancial/chetwood-engineering-api-template/actions/workflows/test-cloudformation.yaml)
[![Python Blacken](https://github.com/chetwoodfinancial/chetwood-engineering-api-template/actions/workflows/blacken-python.yaml/badge.svg)](https://github.com/chetwoodfinancial/chetwood-engineering-api-template/actions/workflows/blacken-python.yaml)
[![Python Linting & Testing](https://github.com/chetwoodfinancial/chetwood-engineering-api-template/actions/workflows/validate-and-test-python.yaml/badge.svg)](https://github.com/chetwoodfinancial/chetwood-engineering-api-template/actions/workflows/validate-and-test-python.yaml)


# Chetwood Engineering API Template

This Template is compatible with our Api Pipelines and is reserved for development of our Serverless Applications fronted
by an Api Gateway deployment.

Focusing on Python and Cloudformation development, this repository will serve as a template for any new private repositories, containing all the necessary files,
folders and configuration needed to ensure each repository is equipped to be as safe, secure and helpful as possible.  

### What is included on this template?

- 🧰 A purpose built directory structure tht enables easy pipeline integration and feature development.  
- 📦 A basic [template.yaml](./api/template.yaml) file to provide a basic template for developing Cloudformation with SAM.
- 🤖 A [buildspec.yaml](buildspec.yaml) boilerplate file with the most useful sections included with basic commands, formatted correctly and ready to be expanded.
- 📃 Automated release note generation.
- 💬 Pre-defined Pull Request template.
- 🧪 Python Testing using [pytest](https://docs.pytest.org/en/latest/) automated with Github Actions.
- ✅ Python Code linting using [pylint](https://pypi.org/project/pylint/) automated with Github Actions.
- 📊 Cloudformation Analysis using [checkov](https://checko.io) automated with Github Actions.
- 🔧 Cloudformation Testing using [taskcat](https://github.com/aws-ia/taskcat) automated with Github Actions.
- 🪨 Python Code Formatting using [black](https://pypi.org/project/black/) automated with Github Actions. 
Note: A pre-commit hook executing Black is available for initialisation.

### Protections

This repository is subject to the following restrictions and protections; As Github does not offer a way of passing branch
protections down from Repository Template to the inheritor, please manually set up the following protections in your newly 
created repositories.

Branches: **master**, 

- ☑️ **Require a pull request before merging** - all commits must be made to a non-protected branch and submitted via a 
  pull request before they can be merged into a branch that matches this rule.
- ☑️ **Require approvals** - pull requests targeting the above branches require 2 approvals and 
  no changes requested before they can be merged. 
- ☑️ **Dismiss stale pull request approvals when new commits are pushed** - New reviewable commits pushed to a matching 
  branch will dismiss pull request review approvals. 
- ☑️ **Require status checks to pass before merging** - all status checks must pass before branches can be merged into a 
  branch that matches this rule. When enabled, commits must first be pushed to another branch, 
  then merged or pushed directly to a branch that matches this rule after status checks have passed.
- ☑️ **Require branches to be up to date before merging** - this ensures pull requests targeting a matching branch have 
  been tested with the latest code. This setting will not take effect unless at least one status check is enabled.
- ☑️ **Require conversation resolution before merging** - all conversations on code must be resolved before a pull request
  can be merged into a branch that matches this rule.  

## Usage Guide

[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](#)
[![Python Version](https://img.shields.io/badge/python-3.8-blue)](#)
[![Cloudformation Version](https://img.shields.io/badge/cloudformation-2010--09--09-orange)](#)
[![IaC Analysis](https://img.shields.io/badge/iac%20analysis-checkov-yellow)](#)

Sections on how to use various resources within this template.

## Intialise Repository

Once created and cloned locally, please execute the following command:
```bash
bash repo_setup.sh
```

This is a very simple few commands to initialise the Postman test file in json format under the repository name. This is 
important as the 'Accpetance Test' stages in the CI/CD Pipelines rely on this file.

We also install dependencies and initialise pre-commit hooks within this script.


## Pipeline Resources

This template is compatible with our [Api Service Pipeline](https://github.com/chetwoodfinancial/chetwood-service-codepipelines/blob/master/pac/cloudformation/pipelines/api-pipelines/*.yaml).

If you're developing a Lambda Function or State Machine please refer to relevant templates [here](https://github.com/chetwoodfinancial/chetwood-service-codepipelines/tree/master/pac/cloudformation/pipelines).

This template has been built to accommodate the build commands of our CodePipelines in addition to being a helpful and logical structure.
This guide will highlight how to modify the template's existing resources to ensure that your application code is delivered to Development in the smoothest, 
safest, most reliable way possible. 

For a working example of the usage of this template, please see Card's Account Position API [ccc-cards-sample-application](https://github.com/chetwoodfinancial/ccc-cards-sample-application) - An early adopter of this template.

### BuildSpec Files

Found at the project's root and formatted via YAML, buildspec files hold the sequential build instructions passed to 
CodePipeline for the Build stage of our CI/CD processes.

The file found in the root of this project is a basic buildpsec.yaml but has everything needed to successfully build
your application. All that is required is any specific commands neccessary to build your service be added, although the 
existing commands are purpose-written to build and package a serverless template. 

These variables ensure that nothing in the buildspec need be changed:
```bash
aws s3 cp --recursive . "s3://$DEPLOYMENT_BUCKET/projects/$PROJECT_NAME/$APPLICATION_NAME/swagger"
aws s3 cp --recursive . "s3://$DEPLOYMENT_BUCKET/projects/$PROJECT_NAME/$APPLICATION_NAME/postman"
sam package --output-template-file packaged.yaml --s3-bucket $DEPLOYMENT_BUCKET  --s3-prefix projects/$PROJECT_NAME/$APPLICATION_NAME/sam --force-upload
```
The result should look like this when values have been interpolated:
```bash
aws s3 cp --recursive . "s3://chetwood-tooling-deployment-bucket/projects/ccc/cards-sample-application/swagger"
aws s3 cp --recursive . "s3://chetwood-tooling-deployment-bucket/projects/ccc/cards-sample-application/postman"
sam package --output-template-file packaged.yaml --s3-bucket chetwood-tooling-deployment-bucket  --s3-prefix projects/ccc/cards-sample-application/sam --force-upload
```
Remember - The application name is derived directly from it's Github repo name so for the example above the repository name would be:
```bash
ccc-cards-sample-application
```
It's important that our engineering naming convention is followed precisely for these processes to work optimally.

Once these placeholder values have been updated the buildspec.yaml is in fully working order and should not be changed without careful consideration. 

### Template.yaml

The template.yaml can be found in the ./api directory, it's important that it remains in this location. This file is a SAM template and it's used to define infrastructure components that make up your service.
This template is almost entirely up to the service developers to define and allows for near complete flexibility.

There are, however, a few considerations - due to the fact this file will be built, packaged and published as a serverless application to the AWS Serverless Application 
Repository (SAR) the template must only contain services compatible will the ```sam publish``` command. 

Most notably nested stacks can not be published to AWS SAR and should therefore not be included in the template.yaml

Specific documentation on this topic can be found here: [sam publish](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/sam-cli-command-reference-sam-publish.html)

#### MetaData 

MetaData is the most important section of the SAM Template in terms of alignment with our CI/CD processes. 
Specifically the 'Publish' stage of our pipelines which directly refers to the MetaData when executing the ```sam publish``` command.

At the top of your template.yaml (between Globals section & Parameters section) the following section should be included:
(We're using the previously mentioned ```ccc-cards-sample-application``` to illustrate.)
```yaml
Metadata:
  AWS::ServerlessRepo::Application:
    Name: ccc-cards-sample-application
    Description: Sample Cards Application
    Author: your-team-name
    ReadmeUrl: ../README.md
    Labels: ['ccc']
    SourceCodeUrl: https://github.com/chetwoodfinancial/ccc-cards-sample-application
    SemanticVersion: 0.0.3
```

Documentation for configuring the MetaData properties can be found [here.](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-template-publishing-applications.html)

In Short, the MetaData section is providing information to AWS SAR regarding the to-be published application and allows the development teams 
to semantically version their serverless applications. This is important for many reasons that will be covered in Confluence. 

### App.yaml

The App.yaml is again a SAM Template, but this time found at the root of the project. This file is the template that will be created by cloudformation into our target accounts.

The App.yaml has a singular purpose and that is to refer to the previously published Serverless Application that we configured 
via MetaData and published via purpose-built pipeline stage. It does this by adding a CF resource to refer to that application within AWS SAR.

The following extract is an example of the app.yaml resource:
```yaml
  CCCCardsSampleApplication:
    Type: AWS::Serverless::Application
    Properties:
      Location:
        ApplicationId: arn:aws:serverlessrepo:eu-west-1:111634274187:applications/ccc-cards-sample-application
        SemanticVersion: 0.0.2
      Parameters:
        Stage: !Ref Stage
```

This resource declaration within the 'Resources' section of the template refers to the published application using its location
and semantic version. In order to deploy your published application, please ensure that the correct information has been supplied. 

Please find the Cloudformation Refs for this resource [here](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/sam-resource-application.html)

## Postman Directory 

As our new CI/CD processes focus on a type of test driven development, in order to successfully release an application to any environment 
automated acceptance tests must pass successfully. This success is predicated on the exported postman test collections that should 
be present within this repository. A detailed guide to ensure this has been set up correctly can be found in our Confluence space, [here](https://chetwood.atlassian.net/wiki/spaces/AR/pages/2396717098/CI+CD+-+Usage+Guide#Automated-Testing-Requirements)

As mentioned above, in order to comply with our CI/CD pipeline's expectations for automated acceptance testing there are a couple of actions required from 
the developers. 

ToDo - Testing file guide

Found in the ```postman/environments``` directory, there are a number of files in ```.json``` format, prefixed with a shortened 
version of our environment names, excluding production. These are;

```bash
dev.json
uat.json
sit.json
```

These files are point-in-time exports of our Postman Environment variables. These variable files are not updated over time 
in this repository template and for that reason the variable values should be validated. It is also advised that all the variables
not in use by your associated exported collection file be removed for the sake of simplicity.


## GitHub Actions

When a Pull Request is raised to merge a feature branch into either the mainline (master) branch or develop branch, a number 
of Github Actions will be performed against the merging branch. These checks all need to execute successfully in order to
allow the branch to be merged. 

Below are the automated checks conducted by this repository, including; how to adopt them properly and their basic functionalities. 

### Checkov 📊

https://github.com/bridgecrewio/checkov

Checkov is a static code analysis tool for scanning infrastructure as code (IaC) files for misconfigurations that may lead to security or compliance problems.
Checkov includes more than 750 predefined policies to check for common misconfiguration issues. Checkov also supports the creation and contribution of custom policies.

This GitHub action is triggered by raising a PR into a central branch (develop, master). Once triggered Checkov conducts analysis 
on the targeted IAC templates. 

This Repo Template includes a Checkov configuration that inspects cloudformation against a set of default rules provided 
by Checkov.

```yaml
  - name: Run Checkov action
    id: checkov
    uses: bridgecrewio/checkov-action@master
    with:
      directory: ./api
      skip_check: CKV_AWS_158
      quiet: true
      framework: cloudformation
      output_format: json
      log_level: DEBUG
      container_user: 1000
```

This configuration expects cloudformation templates to be stored somewhere within the ```./api``` directory, as do other 
downstream actions. For this reason it's important to adopt the structure offered by the Repository Template. 

As seen above, ```skip_check:``` can be defined followed by a valid check Id relating to that check. While it is encouraged 
to not skip any checks, sometimes it may be necessary to do so and in these events the change configuration should be raised for 
PR review to ensure no important checks are being skipped.

#### How to pass?

- Well defined cloudformation templates
- Resources defined with best practices in mind
- Correcting failures according to Checkov guidance (where necessary)

### TaskCat 🔧

TaskCat is an open-source tool that is used for testing Amazon Web Services (AWS) CloudFormation templates.

This GitHub action is triggered by raising a PR into a central branch (develop, master). Once triggered Taskcat will search 
for Cloudformation templates within a target repository and attempt to provision a stack based on that template into our Sandbox 
Account. This action merely tests that the cloudformation template should build as expected, once successfully built the stack will be 
rooled back and deleted by TaskCat. 

### PyTest 🧪 
The pytest framework makes it easy to write small, readable tests, and can scale to support complex functional testing for applications and libraries.

This action sits within the ```validate-and-test-python.yaml``` file and utilises the pytest tool offered by the pypi package. 
The action is configured to find files with the ```.py``` extension located within the ```api/tests/unit``` directory, it assumes files
found here are unit tests.

pytest command
```bash
pytest -v --cov=api/ tests/unit/ --cov-fail-under=100
```

The current options included in the command are;

```-v``` verbose output. 
```--cov``` dictates which directory to measure code coverage against.
```--cov-fail-under``` sets the number as a percentage of code coverage needed to result in a pass.

#### How to pass?

- Unit tests offer 100% Code Coverage
- Unit test files should be located at ```api/tests/unit```
- Unit tests should be valid, valuable and successful

#### Testing strategy

Where possible the code should be tested without mocks, to present as realistic and production-like an environment as possible. 
However, this will not always be possible, particularly when it comes to external parties or infrastructure. In these cases libraries 
should be used to mock the calls, to avoid manually writing mocking functions. 

If making a call to an s3 component (e.g. an s3 bucket or dynamodb table), the [`moto`](http://docs.getmoto.org/en/latest/index.html)
library should be used. This will allow you to create a bucket or table and treat it as a real component for the duration of the test,
creating/updating/reading/deleting objects as required. 

If mocking a call to an external third party (e.g. mastercard or clearscore), the [`responses`](https://github.com/getsentry/responses)
library should be used. This will allow you to mock calls made using `requests`, specifying matchers for the type and location of a request
and specifying the response. 

If mocking a call to an internal service, you can either follow the `responses` approach as above if you need to customise data, alternatively
you can use the swagger specification file combined with a [`prism`](https://github.com/stoplightio/prism) docker image to provide a mock server 
that will return example responses. 

The [`conftest.py`](https://github.com/chetwoodfinancial/core-document-store-api/blob/master/api/tests/conftest.py) of the `core-document-store-api` 
repo contains examples of setting up moto and prism mocks for that service.

### PyLint ✅
Pylint is a Python static code analysis tool which looks for programming errors, helps enforcing a coding standard, sniffs for code smells and offers simple refactoring suggestions.

This action sits within the ```validate-and-test-python.yaml``` file and utilises the pylint tool offered by the pypi package. 
The action is configured to find files with the ```.py``` extension located within the ```api/src``` directory, any files matching
python file extension will be assessed.

This tool is highly configurable and uses the ```.pylintrc``` file located at the project's root to define its configuration. 

pylint command 
```bash
pylint $(git ls-files './api/src/*.py')
```

This simple command is running pylint against any files returned by the ```git ls-files``` command with the ```.py``` extension. 

#### How to pass?

- .py files should be located at ```api/src```
- Python code should be aligned with our best practices in mind
- Correcting issues found by PyLint scanning



### Black 🪨 
A customisable GitHub action to check the style of Python code with [black](https://github.com/psf/black)

Uses black version 22.1.0

In its current form this Github Action will check the formatting of python code across the repository. If used properly 
the black pre-commit hook should ensure this action will never fail. 


