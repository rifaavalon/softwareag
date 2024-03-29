provider "aws" {
  region = "us-west-2"
}
resource "aws_s3_bucket" "buzser_remote_state" {
  bucket        = "${var.prefix}-remote-state-${var.environment}"
  acl           = "private"
  force_destroy = true
  versioning {
    enabled = true
  }

  /*lifecycle {
    prevent_destroy = true
  }*/

  tags = {
    Name        = "${var.prefix}-remote-state-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name           = "terraform-state-lock"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "DynamoDB Terraform State Lock Table"
  }
}
