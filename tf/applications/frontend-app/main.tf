locals {
  route53_base_domain  = var.route53_zone_domain
}

data "aws_route53_zone" "domain_zone" {
  name         = "${local.route53_base_domain}."
}