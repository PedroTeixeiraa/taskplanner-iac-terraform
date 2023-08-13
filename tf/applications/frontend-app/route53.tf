resource "aws_route53_record" "domain_record" {
  name    = var.cdn_domain
  type    = "A"
  zone_id = data.aws_route53_zone.domain_zone.zone_id

  alias {
    name                   = aws_cloudfront_distribution.cloudfront.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront.hosted_zone_id
    evaluate_target_health = false
  }

  depends_on = [
    aws_cloudfront_distribution.cloudfront
  ]
}