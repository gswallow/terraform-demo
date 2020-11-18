# Public subnet route tables
resource "aws_route_table" "public" {
  count  = min(length(data.aws_availability_zones.available.names), 3)
  vpc_id = aws_vpc.current.id

  tags = {
    Name        = "public-${element(data.aws_availability_zones.available.names, count.index)}"
    Environment = var.ENV
  }
}

resource "aws_route" "igw" {
  count                  = min(length(data.aws_availability_zones.available.names), 3)
  route_table_id         = element(aws_route_table.public.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "public" {
  count          = min(length(data.aws_availability_zones.available.names), 3)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = element(aws_route_table.public.*.id, count.index)
}

# Private subnet route tables

resource "aws_route_table" "private" {
  count  = min(length(data.aws_availability_zones.available.names), 3)
  vpc_id = aws_vpc.current.id

  tags = {
    Name        = "private-${element(data.aws_availability_zones.available.names, count.index)}"
    Environment = var.ENV
  }
}

resource "aws_route" "natgw" {
  count                  = min(length(data.aws_availability_zones.available.names), 3)
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.gw.*.id, count.index)
}

resource "aws_route_table_association" "private" {
  count          = min(length(data.aws_availability_zones.available.names), 3)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}
