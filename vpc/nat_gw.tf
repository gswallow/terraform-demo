resource "aws_eip" "nat" {
  count = "${min(length(data.aws_availability_zones.available.names), 3)}"
  vpc = true
}

resource "aws_nat_gateway" "gw" {
  count = "${min(length(data.aws_availability_zones.available.names), 3)}"
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"

  tags {
    Name = "nat-${element(aws_subnet.public.*.id, count.index)}"
    Environment = "${var.ENV}"
  }
}
