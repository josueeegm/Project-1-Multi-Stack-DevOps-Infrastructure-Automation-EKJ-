variable "aws_region" {
  type = string
  description = "Region to create the resources"
  default = "us-west-1"
}

variable "cidr_block" {
  type = string
  description = "value"
  default = "10.0.0.1/16"
}

variable "vpc_name" {
  type = string
  description = "Name of the VPC"
  default = "main-vpc"
}