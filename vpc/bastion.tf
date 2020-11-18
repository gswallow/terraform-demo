resource "aws_instance" "bastion" {
  ami             = data.aws_ami.ubuntu.id
  subnet_id       = aws_subnet.public.*.id[0]
  instance_type   = "t3.nano"
  key_name        = aws_key_pair.ssh.key_name
  security_groups = [aws_security_group.bastion.id]
}

resource "aws_security_group" "bastion" {
  name        = "bastion_sg"
  vpc_id      = aws_vpc.current.id
  description = "Allow all HTTP traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = [var.SSH_ALLOWED_CIDR]
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.ENV}-bastion-sg"
    Environment = var.ENV
  }
}
