data "template_file" "user_data" {
  template = "${file("files/user_data.tpl")}"
}

resource "aws_launch_configuration" "web" {
  name_prefix     = "${var.ENV}-web-"
  image_id        = "${data.aws_ami.ubuntu.id}"
  instance_type   = "t2.micro"
  security_groups = [ "${aws_security_group.web.id}" ]
  user_data       = "${data.template_file.user_data.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}
