provider "aws" { }

terraform {
  backend "s3" {
    bucket = "gregonaws-tf-state-store"
#    dynamodb_table = "gregonaws-tf-state-locks"
    key    = "vpc"
    region = "us-east-1"
  }
}

