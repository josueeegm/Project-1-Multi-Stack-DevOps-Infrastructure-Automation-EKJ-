#configure the AWS provider
provider "aws" {
  region = var.aws-region
}

#create VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc-cidr-block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc-name
  }
}

#create public subnet for the public instances
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.public-subnet-cidr-block
  availability_zone = var.public-insatnce-availability-zone
  map_public_ip_on_launch = true

  tags = {
    Name = var.public-subnet-name
  }
}

#create private subnet for the private instances
resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.private-subnet-cidr-block
  availability_zone = var.private-insatnce-availability-zone

  tags = {
    Name = var.private-subnet-cidr-block
  }
}

#create internet gateway for public subnet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.internet-gateway-name
  }
}

# Create a route table for the public subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = var.route-table-name
  }
}

# Associate the route table with the public subnet
resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}
