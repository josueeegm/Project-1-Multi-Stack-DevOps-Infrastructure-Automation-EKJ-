// Basic provider config
provider "aws" {
  region = var.aws_region
}

// Configure backend to store state in the S3 bucket created in 00-bootstrap
terraform {
  backend "s3" {
    bucket         = "jke-bucket-test"
    key            = "tfstate/infra.tfstate" // path/key inside the bucket
    region         = "ap-south-1"            // <-- must match your region
    dynamodb_table = "jke-test"              // <-- must match the table created in bootstrap
    encrypt        = true
  }
}

module "vpc_module" {
  source = "./modules/vpc_module"

  aws_region                         = var.aws_region
  vpc_cidr_block                     = var.vpc_cidr_block
  public_subnet_cidr_block           = var.public_subnet_cidr_block
  private_subnet_cidr_block          = var.private_subnet_cidr_block
  vpc_name                           = var.vpc_name
  private_subnet_name                = var.private_subnet_name
  public_subnet_name                 = var.public_subnet_name
  public_insatnce_availability_zone  = var.public_insatnce_availability_zone
  private_insatnce_availability_zone = var.private_insatnce_availability_zone
  internet_gateway_name              = var.internet_gateway_name
  route_table_name                   = var.route_table_name
}

module "ec2_module" {
  source                             = "./modules/ec2_module"
  aws_region                         = var.aws_region
  ami_id                             = var.ami_id
  key_name                           = var.key_name
  instance_type_bastion              = var.instance_type_bastion
  instance_type_redis                = var.instance_type_redis
  instance_type_pg                   = var.instance_type_pg
  vpc_id                             = module.vpc_module.vpc_id
  public_subnet_id                   = module.vpc_module.public_subnet_id
  private_subnet_id                  = module.vpc_module.private_subnet_id
  public_insatnce_availability_zone  = var.public_insatnce_availability_zone
  private_insatnce_availability_zone = var.private_insatnce_availability_zone
  public_subnet_name                 = var.public_subnet_name
  private_subnet_name                = var.private_subnet_name
  internet_gateway_name              = var.internet_gateway_name
  route_table_name                   = var.route_table_name
  private_subnet_cidr_block          = var.private_subnet_cidr_block
  vpc_cidr_block                     = var.vpc_cidr_block
  public_subnet_cidr_block           = var.public_subnet_cidr_block
  vpc_name                           = var.vpc_name
  bastion_instance_name              = var.bastion_instance_name
  redis_worker_instance_name         = var.redis_worker_instance_name
  postgres_instance_name             = var.postgres_instance_name
}