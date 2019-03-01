data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_availability_zones" "available" {}

# Here we use the terraform_state_store data source to retrieve the current
# state of our parent object (the VPC).  This is an example of using terraform's data  
# sources to assist with automation efforts.

data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "${path.cwd}/../vpc/terraform.tfstate"
  }
}
