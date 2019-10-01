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
    us-west-2 = "ami-0c3a124c16e13f1e2"
  }
}
variable "dnszonename" {
  default     = "aws.hostgate.net"
  description = "my internal dns name"
}
variable "vpc_cidr" {
  default     = "10.0.0.0/20"
  description = "the vpc cdir range"
}
variable "public_subnet_a" {
  default     = "10.0.0.0/24"
  description = "Public subnet AZ A"
}
variable "public_subnet_b" {
  default     = "10.0.4.0/24"
  description = "Public subnet AZ B"
}
variable "public_subnet_c" {
  default     = "10.0.8.0/24"
  description = "Public subnet AZ C"
}
variable "private_subnet_a" {
  default     = "10.0.1.0/24"
  description = "Private subnet AZ A"
}
variable "private_subnet_b" {
  default     = "10.0.5.0/24"
  description = "Private subnet AZ B"
}
variable "private_subnet_c" {
  default     = "10.0.9.0/24"
  description = "Private subnet AZ C"
}
variable "s3_bucket" {
  default = "alb_logs"
}
