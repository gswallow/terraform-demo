variable "ENV" {}

variable "cidr_prefix" {
  default = "172.18"
}

variable "cidr_block" {
  type = "map"
  default = {
    "us-east-1" = 0
    "us-east-2" = 64 
    "us-west-2" = 128
    "us-west-1" = 192
  }
}

variable "cidr_length" {
  default = 18
}
