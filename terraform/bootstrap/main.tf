// Very basic AWS provider for bootstrap
provider "aws" {
  region = var.region
}

// Create S3 bucket to store Terraform state
resource "aws_s3_bucket" "tfstate" {
  bucket = "jke-bucket-test"
}

resource "aws_s3_bucket_versioning" "tfstate_versioning" {
  bucket = aws_s3_bucket.tfstate.id

  versioning_configuration {
    status = "Enabled"
  }
}

// DynamoDB table for state locking (prevents two applies at same time)
resource "aws_dynamodb_table" "lock" {
  name         = "jke-test" // lock table name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "jke-lock-table-test"
  }
}