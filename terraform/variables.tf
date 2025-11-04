// Beginner-friendly variables: you fill these in terraform.tfvars

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "ami_id" {
  description = "AMI to use for EC2 instances"
  type        = string
}

variable "key_name" {
  description = "Existing EC2 Key Pair name to SSH the bastion"
  type        = string
}

variable "instance_type_bastion" {
  description = "Instance type for bastion"
  type        = string
  default     = "t2.micro"
}

variable "instance_type_redis" {
  description = "Instance type for redis worker"
  type        = string
  default     = "t2.micro"
}

variable "instance_type_pg" {
  description = "Instance type for postgres"
  type        = string
  default     = "t2.micro"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR for VPC"
}

variable "public_subnet_cidr_block" {
  type        = string
  description = "CIDR for public subnet"
}

variable "private_subnet_cidr_block" {
  type        = string
  description = "CIDR for private subnet"
}

variable "vpc_name" {
  type        = string
  description = "VPC name"
}

variable "private_subnet_name" {
  type = string
}

variable "public_subnet_name" {
  type = string
}

variable "public_insatnce_availability_zone" {
  type = string
}

variable "private_insatnce_availability_zone" {
  type = string
}

variable "internet_gateway_name" {
  type = string
}

variable "route_table_name" {
  type = string
}

variable "bastion_instance_name" {
  description = "Name of bastion host instance"
  type = string
}

variable "postgres_instance_name" {
  description = "Name of postgres instance"
  type = string
}

variable "redis_worker_instance_name" {
  description = "Name of worker and redis instance"
  type = string
}
