output "vpc_id" {
  value = "${aws_vpc.current.id}"
}

output "public_subnet_ids" {
  value = "${aws_subnet.public.*.id}"
}

output "private_subnet_ids" {
  value = "${aws_subnet.private.*.id}"
}

output "default_security_group_id" {
  value = "${aws_default_security_group.default.id}"
}
