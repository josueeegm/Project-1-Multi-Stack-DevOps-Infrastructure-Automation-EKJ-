// Configure backend to store state in the S3 bucket created in 00-bootstrap
terraform {
  backend "s3" {
    bucket         = "jke-bucket"    // <-- must match the bucket created in bootstrap
    key            = "tfstate/infra.tfstate" // path/key inside the bucket
    region         = "ap-south-1"     // <-- must match your region
    dynamodb_table = "jke"           // <-- must match the table created in bootstrap
    encrypt        = true
  }
}

// Basic provider config
provider "aws" {
  region = var.region
}

// Use default VPC and its subnets for now (beginner approach)
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default_vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

// Pick one subnet (first) for simplicity
locals {
  chosen_subnet_id = element(data.aws_subnets.default_vpc_subnets.ids, 0)
}

// Call our very simple EC2 module
module "ec2_basic" {
  source = "./modules/ec2_basic"

  ami_id                = var.ami_id
  key_name              = var.key_name
  instance_type_bastion = var.instance_type_bastion
  instance_type_redis   = var.instance_type_redis
  instance_type_pg      = var.instance_type_pg

  subnet_id = local.chosen_subnet_id
  vpc_id    = data.aws_vpc.default.id
}