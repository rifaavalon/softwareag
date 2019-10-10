resource "aws_iam_role" "softwareagec2_role" {
  name = "softwareagec2_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_instance_profile" "softwareagec2_profile" {
  name = "softwareagec2_profile"
  role = "${aws_iam_role.softwareagec2_role.name}"
}

resource "aws_iam_role_policy" "softwareagec2_policy" {
  name = "softwareagec2_policy"
  role = "${aws_iam_role.softwareagec2_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::softwareag-test/*"
    }
  ]
}
EOF
}
resource "aws_s3_bucket" "alb-log-bucket" {
  bucket        = "softwareag-alb-logs"
  force_destroy = "true"
  policy = templatefile("./policy.json.tmpl",
    {
      bucket_name = "softwareag-alb-logs",
      prefix      = "alb-logs"
    }
  )
}




resource "aws_s3_bucket" "softwareag-test" {
  bucket        = "softwareag-test"
  force_destroy = "true"

  tags = {
    Name        = "EC2"
    Environment = "test"
  }
}
