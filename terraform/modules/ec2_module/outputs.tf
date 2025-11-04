// Simple outputs for quick checks

output "bastion_public_ip" {
  value = aws_instance.jke_bastion.public_ip
}

output "redis_private_ip" {
  value = aws_instance.jke_redisWorker.private_ip
}

output "postgres_private_ip" {
  value = aws_instance.jke_postgress.private_ip
}

/* output "sg_ids" {
  value = {
    vote_result = aws_security_group.vote_result.id
    redisWorker = aws_security_group.redis_worker.id
    postgress   = aws_security_group.postgress.id
  }
} */
