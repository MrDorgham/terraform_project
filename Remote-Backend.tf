resource "aws_s3_bucket" "test-remote-state" {
  bucket = "test-remote-state"
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.test-remote-state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "test-locks" {
  name         = "test-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
  backend "s3" {
    bucket = "test-remote-state"
    key = "Dev/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "test-locks"
    encrypt = true
  }
}