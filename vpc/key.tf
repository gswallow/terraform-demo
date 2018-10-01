resource "tls_private_key" "ssh" {
  algorithm = "RSA"
}
  
resource "aws_key_pair" "ssh" {
  key_name = "${var.ENV}-demo-ssh-key"
  public_key = "${tls_private_key.ssh.public_key_openssh}"
}
