module "alb" {
  source = "terraform-aws-modules/alb/aws"

  name    = "hackathon-2024-alb"
  vpc_id  = aws_vpc.hackathon_2024_vpc.id
  subnets = [aws_subnet.public_1a.id, aws_subnet.public_1c.id]

  # Security Group
  security_group_ingress_rules = {
    all_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "HTTP web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
    all_https = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      description = "HTTPS web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

#   access_logs = {
#     bucket = "my-alb-logs"
#   }

  listeners = {
    ex-http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
    ex-https = {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = module.acm.acm_certificate_arn

      forward = {
        target_group_key = "ec2-instance"
      }
    }
  }

  target_groups = {
    ec2-instance = {
      name_prefix      = "h1"
      protocol         = "HTTP"
      port             = 8080
      target_type      = "instance"
      target_id        = module.ec2_instance.id
    }
  }
}
