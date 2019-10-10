resource "aws_lb" "alb" {
  name            = "alb"
  subnets         = "${module.vpc.public_subnets}"
  security_groups = ["${aws_security_group.sec_lb.id}"]
  internal        = false
  idle_timeout    = 60

  access_logs {
    bucket  = "${aws_s3_bucket.alb-log-bucket.bucket}"
    prefix  = "alb-logs"
    enabled = true
  }

  tags = {
    Name = "alb"
  }
}

resource "aws_lb_target_group" "alb_target_group" {
  name     = "alb-target-group"
  port     = "8080"
  protocol = "HTTP"
  vpc_id   = "${module.vpc.vpc_id}"
  tags = {
    name = "alb_target_group"
  }
  stickiness {
    type            = "lb_cookie"
    cookie_duration = 1800
    enabled         = true
  }
  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 10
    path                = "/"
    port                = 8080
  }
}

resource "aws_autoscaling_attachment" "alb_autoscale" {
  alb_target_group_arn   = "${aws_lb_target_group.alb_target_group.arn}"
  autoscaling_group_name = "${aws_autoscaling_group.autoscale_group.id}"
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "8080"
      protocol    = "HTTP"
      status_code = "HTTP_301"
    }
  }
}
