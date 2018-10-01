#!/bin/bash

PROJECT_NAME="${PWD##*/}" # use current dir name
AWS_REGION="us-east-1"
ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"

count=$(aws s3api list-buckets \
  --query 'length(Buckets[?Name == `terraform-tfstate-'${ACCOUNT_ID}'`].Name)')

if [ $count -eq 0 ]; then
  aws s3api create-bucket \
  	--region "${AWS_REGION}" \
  	--bucket "terraform-tfstate-${ACCOUNT_ID}"
fi

count=$(aws dynamodb list-tables \
  --query 'length(TableNames[?contains(@, `terraform_locks`)])')

if [ $count -eq 0 ]; then
  aws dynamodb create-table \
  	--region "${AWS_REGION}" \
  	--table-name terraform_locks \
  	--attribute-definitions AttributeName=LockID,AttributeType=S \
  	--key-schema AttributeName=LockID,KeyType=HASH \
  	--provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1   
fi

cat <<EOF > ./_backend.tf
terraform {
  backend "s3" {
    bucket         = "terraform-tfstate-${ACCOUNT_ID}"
    key            = "${PROJECT_NAME}.tfstate"
    region         = "${AWS_REGION}"
    dynamodb_table = "terraform_locks"
  }
}
EOF
