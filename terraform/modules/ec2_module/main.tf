# -----------------------
# SECURITY GROUPS (empty)
# -----------------------

resource "aws_security_group" "vote_result" {
  name        = "vote-result"
  description = "Bastion / App security group"
  vpc_id      = var.vpc_id

  # Open ports for app / SSH / HTTP(S)
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Ports 8080-8081"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Ports 8080-8081"
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "vote-result" }
}

resource "aws_security_group" "redis_worker" {
  name        = "redisWorker"
  description = "Redis worker security group"
  vpc_id      = var.vpc_id

  ingress {
    description     = "SSH from Bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.vote_result.id]
  }

  ingress {
    description     = "Redis from bastion SG"
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [aws_security_group.vote_result.id]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "jke_redisWorker_sg" }
}

resource "aws_security_group" "postgress" {
  name        = "postgress"
  description = "Postgres security group"
  vpc_id      = var.vpc_id

  ingress {
    description     = "SSH from Bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.vote_result.id]
  }

  ingress {
    description     = "Postgres from bastion SG"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.redis_worker.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "jke_postgress_sg" }
}

# -----------------------
# SECURITY GROUP RULES
# -----------------------

# Allow Bastion → Redis
resource "aws_security_group_rule" "bastion_to_redis" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.vote_result.id
  security_group_id        = aws_security_group.redis_worker.id
}

# Allow Bastion → Postgres
resource "aws_security_group_rule" "bastion_to_postgres" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.vote_result.id
  security_group_id        = aws_security_group.postgress.id
}

# Allow Redis → Postgres (if your worker needs DB access)
resource "aws_security_group_rule" "redis_to_postgres" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.redis_worker.id
  security_group_id        = aws_security_group.postgress.id
}

resource "aws_security_group_rule" "postgres_to_bastion" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.postgress.id
  security_group_id        = aws_security_group.vote_result.id
}

# -----------------------
# INSTANCES
# -----------------------

resource "aws_instance" "ugn_bastion" {
  ami                         = var.ami_id
  instance_type               = var.instance_type_bastion
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.vote_result.id]
  key_name                    = var.key_name

  tags = { Name = var.bastion_instance_name }
}

resource "aws_instance" "ugn_redisWorker" {
  ami                         = var.ami_id
  instance_type               = var.instance_type_redis
  subnet_id                   = var.private_subnet_id
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.redis_worker.id]
  key_name                    = var.key_name

  tags = { Name = var.redis_worker_instance_name }
}

resource "aws_instance" "ugn_postgress" {
  ami                         = var.ami_id
  instance_type               = var.instance_type_pg
  subnet_id                   = var.private_subnet_id
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.postgress.id]
  key_name                    = var.key_name

  tags = { Name = var.postgres_instance_name }
}