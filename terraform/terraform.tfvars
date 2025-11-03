# >>> VALUES YOU MUST SET <<<
region    = "ap-south-1"                 # <-- same region as bootstrap
ami_id    = "ami-02b8269d5e85954ef"   # <-- put a valid Linux AMI ID for your region
key_name  = "jkey"        # <-- put an existing EC2 key pair

# Optional: override instance types if you want
instance_type_bastion = "t3.micro"
instance_type_redis   = "t3.micro"
instance_type_pg      = "t3.micro"