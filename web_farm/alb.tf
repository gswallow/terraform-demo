resource "aws_lb" "web" {
  name               = "web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.web.id}"]
  subnets            = ["${data.terraform_remote_state.vpc.public_subnet_ids}"]

  tags {
    Name = "${var.ENV}-web-alb"
    Environment = "${var.ENV}"
  }
}

resource "aws_lb_listener" "web" {
  load_balancer_arn = "${aws_lb.web.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.web.arn}"
  }
}

resource "aws_lb_target_group" "web" {
  name     = "${var.ENV}-web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${data.terraform_remote_state.vpc.vpc_id}"
}


resource "aws_autoscaling_attachment" "web" {
  autoscaling_group_name = "${aws_autoscaling_group.web.id}"
  alb_target_group_arn   = "${aws_lb_target_group.web.arn}"
}
