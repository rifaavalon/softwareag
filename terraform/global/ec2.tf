terraform {
  backend "s3" {
    bucket = "softwareag-remote-state-global"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}

# resource "tls_private_key" "auth" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_launch_configuration" "autoscale_launch" {
  image_id        = "${lookup(var.aws_amis, var.aws_region)}"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.sec_web.id}"]
  key_name        = "${aws_key_pair.auth.id}"
  #  associate_public_ip_address = true
  user_data = <<-EOF
              #!/bin/bash
              sudo yum -y update
              sudo yum -y install nginx
              EOF
  lifecycle {
    create_before_destroy = true
  }

  ebs_block_device {
    device_name           = "/dev/sdh"
    volume_type           = "gp2"
    volume_size           = "30"
    delete_on_termination = "true"
  }
}

resource "aws_autoscaling_group" "autoscale_group" {
  launch_configuration = "${aws_launch_configuration.autoscale_launch.id}"
  vpc_zone_identifier  = ["${aws_subnet.PrivateSubnetA.id}", "${aws_subnet.PrivateSubnetB.id}", "${aws_subnet.PrivateSubnetC.id}"]
  load_balancers       = ["${aws_lb.alb.name}"]
  min_size             = 3
  max_size             = 3
  tag {
    key                 = "Name"
    value               = "autoscale"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "sec_web" {
  name        = "sec_web"
  description = "Used for autoscale group"
  vpc_id      = "${aws_vpc.default.id}"

  # HTTP access from anywhere
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "sec_lb" {
  name   = "sec_elb"
  vpc_id = "${aws_vpc.default.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "alb" {
  name            = "alb"
  subnets         = ["${aws_subnet.PublicSubnetA.id}", "${aws_subnet.PublicSubnetB.id}", "${aws_subnet.PublicSubnetC.id}"]
  security_groups = ["${aws_security_group.sec_lb.id}"]
  internal        = false
  idle_timeout    = 60
  tags = {
    Name = "alb"
  }
}

resource "aws_lb_target_group" "alb_target_group" {
  name     = "alb-target-group"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.default.id}"
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
    port                = 80
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
    target_group_arn = "${aws_lb_target_group.alb_target_group.arn}"
    type             = "forward"
  }
}

resource "aws_s3_bucket" "softwareag-test-bucket" {
  bucket = "softwareag-test-bucket"
}

resource "aws_s3_bucket_policy" "softwareag-test-bucket" {
  bucket = "${aws_s3_bucket.softwareag-test-bucket.id}"

  policy = <<POLICY
  {
      "Version": "2012-10-17",
   "Statement": [
       {
           "Sid": "ListObjectsInBucket",
           "Effect": "Allow",
           "Action": ["s3:ListBucket"],
           "Resource": ["arn:aws:s3:::softwareag-test-bucket"]
       },
       {
           "Sid": "AllObjectActions",
           "Effect": "Allow",
           "Action": "s3:*Object",
           "Resource": ["arn:aws:s3:::softwareag-test-bucket/*"]
       }
   ]
    }
    POLICY
}
