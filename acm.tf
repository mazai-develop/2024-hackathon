module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name  = "technonebulas.net"
  zone_id      = "Z051287322M233ZOEPSXY"

  validation_method = "DNS"

  subject_alternative_names = [
    "*.technonebulas.net",
  ]

  wait_for_validation = true
}
