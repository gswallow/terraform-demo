resource "aws_subnet" "public" {
  count                   = min(length(data.aws_availability_zones.available.names), 3)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  vpc_id                  = aws_vpc.current.id
  cidr_block              = "${var.cidr_prefix}.${lookup(var.cidr_block, data.aws_region.current.name) + count.index}.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name        = "public-${var.cidr_prefix}.${lookup(var.cidr_block, data.aws_region.current.name) + count.index}.0-24-${element(data.aws_availability_zones.available.names, count.index)}"
    Environment = var.ENV
  }
}

resource "aws_subnet" "private" {
  count             = min(length(data.aws_availability_zones.available.names), 3)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  vpc_id            = aws_vpc.current.id
  cidr_block        = "${var.cidr_prefix}.${lookup(var.cidr_block, data.aws_region.current.name) + 16 * (count.index + 1)}.0/20"
  tags = {
    Name        = "private-${var.cidr_prefix}.${lookup(var.cidr_block, data.aws_region.current.name) + 16 * (count.index + 1)}.0-20-${element(data.aws_availability_zones.available.names, count.index)}"
    Environment = var.ENV
  }
}
