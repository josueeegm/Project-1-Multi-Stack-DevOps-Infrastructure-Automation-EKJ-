############################################
# AWS Provider Configuration
############################################
provider "aws" {
  region = var.region    # AWS region to deploy backend resources
}


############################################
# S3 Bucket for Terraform State
############################################
resource "aws_s3_bucket" "tfstate" {
  bucket = "jke-bucket"  # S3 bucket name for Terraform state

  tags = {
    Name        = "terraform-state-bucket"
    Environment = "bootstrap"
  }
}

# Enable versioning to maintain history of Terraform state files
resource "aws_s3_bucket_versioning" "tfstate_versioning" {
  bucket = aws_s3_bucket.tfstate.id

  versioning_configuration {
    status = "Enabled"   # Ensures state file versions are saved
  }
}

# (Optional but recommended) Block all public access to bucket
resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket                  = aws_s3_bucket.tfstate.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


############################################
# DynamoDB Table for Terraform Locking
############################################
resource "aws_dynamodb_table" "lock" {
  name         = "jke"                 # Lock table name (referenced in backend config)
  billing_mode = "PAY_PER_REQUEST"     # On-demand billing mode
  hash_key     = "LockID"              # Primary key for lock record

  attribute {
    name = "LockID"
    type = "S"                         # String type for key
  }

  tags = {
    Name        = "terraform-lock-table"
    Environment = "bootstrap"
  }
}