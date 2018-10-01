resource "aws_autoscaling_group" "web" {
  name_prefix          = "${var.ENV}-web-"
  launch_configuration = "${aws_launch_configuration.web.name}"
  health_check_type    = "EC2"
  min_size             = 1
  desired_capacity     = 2
  max_size             = 3
  vpc_zone_identifier  = [ "${data.terraform_remote_state.vpc.private_subnet_ids}" ]

  tags = [
    {
      key = "Name"
      value = "${var.ENV}-web-asg-instance"
      propagate_at_launch = true
    },
    {
      key = "Environment"
      value = "${var.ENV}"
      propagate_at_launch = true
    }
  ]

  lifecycle {
    create_before_destroy = true
  }
}
