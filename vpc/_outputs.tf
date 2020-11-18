output "vpc_id" {
  value = aws_vpc.current.id
}

output "public_subnet_ids" {
  value = aws_subnet.public.*.id
}

output "private_subnet_ids" {
  value = aws_subnet.private.*.id
}

output "ssh_key_pem" {
  value = format("\n\n%s\n\n", tls_private_key.ssh.private_key_pem)
}

output "key_pair_name" {
  value = aws_key_pair.ssh.key_name
}

output "default_security_group_id" {
  value = aws_default_security_group.default.id
}

output "bastion_security_group_id" {
  value = aws_security_group.bastion.id
}

output "bastion_ip_address" {
  value = aws_instance.bastion.public_ip
}
