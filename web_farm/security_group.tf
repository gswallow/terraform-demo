resource "aws_security_group" "web" {
  name = "web_sg"
  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"
  description = "Allow all HTTP traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "TCP"
    security_groups = [ "${data.terraform_remote_state.vpc.bastion_security_group_id}" ]
  }

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.ENV}-web-sg"
    Environment = "${var.ENV}"
  }
}
