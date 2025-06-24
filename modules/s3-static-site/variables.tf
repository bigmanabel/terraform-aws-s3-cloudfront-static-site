variable "aws_region" {
  type = string
}

variable "project_name" {
  type = string
}

variable "domain_name" {
  type        = string
  description = "Custom domain for the static site (must exist in Route 53)"
}