variable "aws_region" {
  description = "AWS region where resources will be provisioned."
}

variable "bucket_name" {
  description = "AWS Bucket Name"
}

variable "certificate_arn" {
  description = "AWS Certificate ARN"
}

variable "route53_zone_domain" {
  default     = ""
  type        = string
  description = "Route53 zone domain (base domain)"
}

variable "cdn_domain" {
  default     = ""
  type        = string
  description = "Domain name (Where you want to deploy the CloudFront distribution. Leave empty to deploy inside base domain)"
}
