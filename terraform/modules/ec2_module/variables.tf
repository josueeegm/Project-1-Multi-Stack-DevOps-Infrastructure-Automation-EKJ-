// Inputs that the root passes down

variable "aws_region" {
  type = string
  description = "Region to create the resources"
}

variable "vpc_cidr_block" {
  type = string
  description = "value"
}

variable "public_subnet_cidr_block" {
  type = string
  description = "CIDR block for the public subnet"
}

variable "private_subnet_cidr_block" {
  type = string
  description = "CIDR block for the private subnet"
}

variable "vpc_name" {
  type = string
  description = "Name of the VPC"
}

variable "private_subnet_name" {
  type = string
  description = "Name of the private subnet"
}

variable "public_subnet_name" {
  type = string
  description = "Name of the public subnet"
}

variable "public_insatnce_availability_zone" {
  type = string
  description = "Availability zone for public instance"
}

variable "private_insatnce_availability_zone" {
  type = string
  description = "Availability zone for private instance"
}

variable "internet_gateway_name" {
  type = string
  description = "Name of the internet gateway"
}

variable "route_table_name" {
  type = string
  description = "Name of route table"
}


variable "ami_id" {
  description = "AMI for all EC2 instances"
  type        = string
}

variable "key_name" {
  description = "EC2 Key Pair to access the bastion instance"
  type        = string
}

variable "instance_type_bastion" {
  description = "Instance type for bastion"
  type        = string
}

variable "instance_type_redis" {
  description = "Instance type for redis worker"
  type        = string
}

variable "instance_type_pg" {
  description = "Instance type for postgres"
  type        = string
}

variable "public_subnet_id" {
  description = "public Subnet ID where bastion will be placed"
  type        = string
}

variable "private_subnet_id" {
  description = "private Subnet ID where redis and postgres will be placed"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for security groups"
  type        = string
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

