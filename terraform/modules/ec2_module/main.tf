/*module "vpc_module" {
  source = "../vpc_module"
  aws_region = var.aws_region
  vpc_cidr_block = var.vpc_cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
  private_subnet_cidr_block = var.private_subnet_cidr_block
  vpc_name = var.vpc_name
  private_subnet_name = var.private_subnet_name
  public_subnet_name = var.public_subnet_name
  public_insatnce_availability_zone = var.public_insatnce_availability_zone
  private_insatnce_availability_zone = var.private_insatnce_availability_zone
  internet_gateway_name = var.internet_gateway_name
  route_table_name = var.route_table_name
}*/


// SECURITY GROUPS
// Bastion SG (named "vote-result" as requested)
resource "aws_security_group" "vote_result" {
  name        = "vote-result"
  description = "Bastion security group (SSH from anywhere - simple demo)"
  vpc_id      = var.vpc_id

  // Allow SSH from anywhere (beginner demo - not for production)
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // very open, for demo only
  }

  //Allow HTTP from anywhere (for voting app demo)
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  //Allow HTTPs from anywhere (for voting app demo)
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vote-result"
  }
}

// Redis SG (only allow 6379 from Bastion SG)
resource "aws_security_group" "redis_worker" {
  name        = "redisWorker"
  description = "Redis worker security group"
  vpc_id      = var.vpc_id

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

  tags = {
    Name = "redisWorker_sg_jke"
  }
}

// Postgres SG (only allow 5432 from Bastion SG)
// NOTE: you asked "postgress" - we keep the name "postgress" to match your request
resource "aws_security_group" "postgress" {
  name        = "postgress"
  description = "Postgres security group"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Postgres from bastion SG"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.vote_result.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "postgress_sg_jke"
  }
}

// INSTANCES

// Bastion instance - public access enabled (simple demo)
resource "aws_instance" "jke_bastion" {
  ami                         = var.ami_id
  instance_type               = var.instance_type_bastion
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.vote_result.id]
  key_name                    = var.key_name

  tags = {
    Name = var.bastion_instance_name
  }
}

// Redis worker instance - no public IP (still in default VPC subnet for now)
resource "aws_instance" "jke_redisWorker" {
  ami                         = var.ami_id
  instance_type               = var.instance_type_redis
  subnet_id                   = var.private_subnet_id
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.redis_worker.id]

  tags = {
    Name = var.redis_worker_instance_name
  }
}

// Postgres instance - no public IP (still in default VPC subnet for now)
// NOTE: name kept as "postgress" to match your request
resource "aws_instance" "jke_postgress" {
  ami                         = var.ami_id
  instance_type               = var.instance_type_pg
  subnet_id                   = var.private_subnet_id
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.postgress.id]

  tags = {
    Name = var.postgres_instance_name
  }
}