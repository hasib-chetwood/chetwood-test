#!/bin/bash

set -e

target_role=$(aws sts assume-role \
     --role-arn $CROSS_ACCOUNT_ROLE \
     --role-session-name $(date '+%Y%m%d%H%M%S%3N') \
     --duration-seconds 3600)

export AWS_ACCESS_KEY_ID=$(echo $target_role | jq -r .Credentials.AccessKeyId)
export AWS_SECRET_ACCESS_KEY=$(echo $target_role | jq -r .Credentials.SecretAccessKey)
export AWS_SESSION_TOKEN=$(echo $target_role | jq -r .Credentials.SessionToken)

aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID --profile $STAGE
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY --profile $STAGE
aws configure set aws_session_token $AWS_SESSION_TOKEN --profile $STAGE

echo $(aws sts get-caller-identity)

echo "Getting UsagePlan Id..."

export USAGE_PLAN_ID=$(aws apigateway --profile $STAGE get-usage-plans --query 'items[?name==`'$USAGE_PLAN_NAME'`]' \
| jq -r '.[0].id')

if [ -z ${USAGE_PLAN_ID+x} ]
then
  echo "Usage Plan Id not found."
  exit 1
else
  echo "$USAGE_PLAN_Name Usage Plan ID:" ${USAGE_PLAN_ID}
fi

echo "Retrieving ApiKey Value..."

export VALUE=$(aws apigateway --profile $STAGE get-usage-plan-keys --usage-plan-id $USAGE_PLAN_ID --max-items 1 \
--query 'items[].value' | jq -r '.[0]')

if [ -z ${VALUE+x} ]
then
  echo "Api Key Value not found."
  exit 1
else
  echo "Api Key Id Value Captured."
fi

echo "Updating Var file..."

jq --arg value "$VALUE" '(.values[] | select(.key=="APIKEY") | .value) = $value' $STAGE.json > $STAGE.json.tmp \
&& cp $STAGE.json.tmp $STAGE.json \
&& rm $STAGE.json.tmp

echo "Var file $STAGE.json updated for testing"

exit 0