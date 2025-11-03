variable "aws-region" {
  type = string
  description = "Region to create the resources"
  default = "us-west-1"
}

variable "vpc-cidr-block" {
  type = string
  description = "value"
  default = "10.0.0.0/16"
}

variable "public-subnet-cidr-block" {
  type = string
  description = "CIDR block for the public subnet"
  default = "10.0.1.0/24"
}

variable "private-subnet-cidr-block" {
  type = string
  description = "CIDR block for the private subnet"
  default = "10.0.2.0/24"
}

variable "vpc-name" {
  type = string
  description = "Name of the VPC"
  default = "main-vpc"
}

variable "private-subnet-name" {
  type = string
  description = "Name of the private subnet"
  default = "private-subnet"
}

variable "public-subnet-name" {
  type = string
  description = "Name of the public subnet"
  default = "public-subnet"
}

variable "public-insatnce-availability-zone" {
  type = string
  description = "Availability zone for public instance"
  default = "us-west-1a"
}

variable "private-insatnce-availability-zone" {
  type = string
  description = "Availability zone for private instance"
  default = "us-west-1c"
}

variable "internet-gateway-name" {
  type = string
  description = "Name of the internet gateway"
  default = "main-igw"
}

variable "route-table-name" {
  type = string
  description = "Name of route table"
  default = "public-rt"
}