terraform {
  backend "s3" {
    bucket         = "terraform-tfstate-216430079837"
    key            = "web_farm.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_locks"
  }
}
