terraform {
  backend "s3" {
    bucket = "softwareag-remote-state-global"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}

provider "aws" {
  region = "${var.aws_region}"
}

# Declare the data source
data "aws_availability_zones" "available" {}
