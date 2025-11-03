// Beginner-friendly variables: you fill these in terraform.tfvars

variable "region" {
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