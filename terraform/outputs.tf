// Bubble up module outputs for convenience
output "bastion_public_ip" {
  value = module.ec2_basic.bastion_public_ip
}

output "redis_private_ip" {
  value = module.ec2_basic.redis_private_ip
}

output "postgres_private_ip" {
  value = module.ec2_basic.postgres_private_ip
}