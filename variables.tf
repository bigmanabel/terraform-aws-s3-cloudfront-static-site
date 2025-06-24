variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "domain_name" {
  type        = string
  description = "The domain to associate with the static site (must be hosted in Route 53)"
}

variable "project_name" {
  type    = string
  default = "s3-static-site"
}