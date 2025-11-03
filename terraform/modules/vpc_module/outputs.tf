output "vpc-id" {
  description = "ID of the VPC"
  value = aws_vpc.main.id
}

output "public-subnet-id" {
  description = "ID of the public subnet"
  value = aws_subnet.public.id
}

output "private-subnet-id" {
  description = "ID of the private subnet"
  value = aws_subnet.private.id
}
