output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = module.static_site.s3_bucket_name
}

output "cloudfront_domain" {
  description = "CloudFront domain URL"
  value       = module.static_site.cloudfront_domain
}

output "website_url" {
  description = "Full domain URL"
  value       = module.static_site.website_url
}

output "waf_web_acl_arn" {
  description = "ARN of the WAF Web ACL"
  value       = module.static_site.waf_web_acl_arn
}

output "acm_certificate_arn" {
  description = "ARN of the ACM certificate"
  value       = module.static_site.acm_certificate_arn
}
