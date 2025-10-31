#configure the AWS provider
provider "aws" {
  region = "us-east-1"
}

#create VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
}