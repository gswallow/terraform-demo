data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  name_regex = ".*ubuntu-bionic-18.04-.*-server-.*"
  owners     = ["099720109477"] # Canonical (Ubuntu)
}
