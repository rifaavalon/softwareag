
resource "aws_launch_configuration" "autoscale_launch" {
  image_id             = "${lookup(var.aws_amis, var.aws_region)}"
  instance_type        = "t2.micro"
  iam_instance_profile = "${aws_iam_instance_profile.softwareagec2_profile.name}"
  security_groups      = ["${aws_security_group.sec_web.id}"]
  key_name             = "${aws_key_pair.auth.id}"
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
  vpc_zone_identifier  = "${module.vpc.private_subnets}"
  target_group_arns    = ["${aws_lb_target_group.alb_target_group.arn}"]
  min_size             = 3
  max_size             = 3
  tag {
    key                 = "Name"
    value               = "autoscale"
    propagate_at_launch = true
  }
}
