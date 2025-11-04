variable "aws_region" {
  type = string
  description = "Region to create the resources"
  default = "us-west-1"
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

variable "nat_elastic_ip" {
  type = string
  description = "Name of the NAT Elastic IP"
}

variable "aws_nat_gateway" {
  type = string
  description = "Name of the NAT Gateway"
}

variable "private_route_table_name" {
  type = string
  description = "Name of the private route table"
}