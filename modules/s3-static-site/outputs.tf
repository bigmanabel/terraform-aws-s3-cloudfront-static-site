output "s3_bucket_name" {
  value = aws_s3_bucket.site.bucket
}

output "cloudfront_domain" {
  value = aws_cloudfront_distribution.cdn.domain_name
}

output "acm_certificate_arn" {
  value = aws_acm_certificate.cert.arn
}

output "website_url" {
  value = "https://${var.domain_name}"
}

output "waf_web_acl_arn" {
  value = aws_wafv2_web_acl.site_waf.arn
}



























