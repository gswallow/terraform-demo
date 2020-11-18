resource "aws_vpc" "current" {
  cidr_block = "${var.cidr_prefix}.${lookup(var.cidr_block, data.aws_region.current.name)}.0/${var.cidr_length}"
  tags = {
    Name        = "${var.ENV}-${data.aws_region.current.name}"
    Environment = var.ENV
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.current.id

  tags = {
    Environment = var.ENV
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.current.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.ENV}-${aws_vpc.current.id}-default-sg"
    Environment = var.ENV
  }
}

resource "aws_vpc_dhcp_options" "default" {
  domain_name_servers = ["AmazonProvidedDNS"]
  ntp_servers         = ["169.254.169.123"]
  netbios_node_type   = 2
}

resource "aws_vpc_dhcp_options_association" "default" {
  vpc_id          = aws_vpc.current.id
  dhcp_options_id = aws_vpc_dhcp_options.default.id
}

locals {
  subnet_count = min(length(data.aws_availability_zones.available.names), 3)
}
