variable "prefix" {
  default = "buzser"
}

variable "environment" {
  default     = "global1"
  description = "Environment Name"
}

output "s3_bucket_id" {
  value = aws_s3_bucket.buzser_remote_state.id
}
