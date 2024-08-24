module "hackathon_ec2_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "hackathon-2024"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = aws_vpc.hackathon_2024_vpc.id

  ingress_cidr_blocks = [aws_vpc.hackathon_2024_vpc.cidr_block]
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 6444
      to_port     = 6444
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 6443
      to_port     = 6443
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  egress_with_cidr_blocks = [
    {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

module "key-pair" {
  source   = "./modules/key-pair"
  key_name = "hackathon-ec2-key-pair"
}


module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "hackathon-instance"


  ami                    = "ami-0a0b7b240264a48d7"
  cpu_core_count         = 1
  cpu_threads_per_core   = 2
  instance_type          = "t3a.small"
  key_name               = "hackathon-ec2-key-pair"
  monitoring             = true
  vpc_security_group_ids = [module.hackathon_ec2_service_sg.security_group_id]
  subnet_id              = aws_subnet.public_1a.id
}
