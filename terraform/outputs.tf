// Bubble up module outputs for convenience
output "bastion_public_ip" {
  value = module.ec2_module.bastion_public_ip
}

output "redis_private_ip" {
  value = module.ec2_module.redis_private_ip
}

output "postgres_private_ip" {
  value = module.ec2_module.postgres_private_ip
}

output "vpc_id" {
  value = module.vpc_module.vpc_id
}

output "public_subnet_id" {
  value = module.vpc_module.public_subnet_id
}

output "private_subnet_id" {
  value = module.vpc_module.private_subnet_id
}