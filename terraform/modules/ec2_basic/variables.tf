// Inputs that the root passes down

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

variable "subnet_id" {
  description = "Subnet ID where instances will be placed (default VPC for now)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for security groups"
  type        = string
}