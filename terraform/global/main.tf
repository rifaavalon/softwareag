provider "aws" {
  region = "${var.aws_region}"
}

# Declare the data source
data "aws_availability_zones" "available" {}
