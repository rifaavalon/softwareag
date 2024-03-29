variable "public_key_path" {
  default = "/Users/chris/.ssh/id_rsa.pub"
}
variable "key_name" {
  description = "Desired name of AWS key pair"
  default     = "terraform"
}
variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-west-2"
}
# Ubuntu Precise 16.04 LTS (x64)
variable "aws_amis" {
  default = {
    us-west-2 = "ami-01ed306a12b7d1c96"
  }
}

variable "s3_bucket" {
  default = "alb_logs"
}
