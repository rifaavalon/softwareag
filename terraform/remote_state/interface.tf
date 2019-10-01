variable "prefix" {
  default = "softwareag"
}

variable "environment" {
  default     = "dev"
  description = "Environment Name"
}

output "s3_bucket_id" {
  value = aws_s3_bucket.remote_state.id
}

