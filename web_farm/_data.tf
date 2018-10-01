data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_availability_zones" "available" {}

# Here we use the terraform_state_store data source to retrieve the current
# state of our parent object from S3.  This is an example of using AWS 
# resources to assist with automation efforts.

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config {
    bucket = "terraform-tfstate-993356857210"
    key    = "vpc.tfstate"
    region = "us-east-1"
    profile = "gregonaws"
  }
}
