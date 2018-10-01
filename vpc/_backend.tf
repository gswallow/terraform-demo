terraform {
  backend "s3" {
    bucket         = "terraform-tfstate-993356857210"
    key            = "vpc.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_locks"
  }
}
