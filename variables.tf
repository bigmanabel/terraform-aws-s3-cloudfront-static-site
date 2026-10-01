variable "aws_region" {
  type        = string
  description = "AWS region for the S3 bucket. Global CloudFront resources use us-east-1 through a provider alias."
  default     = "us-east-1"
}

variable "domain_name" {
  type        = string
  description = "Fully qualified domain name for the site. A matching public Route 53 hosted zone must exist."

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9.-]*[a-z0-9]$", var.domain_name))
    error_message = "domain_name must be a lowercase, fully qualified domain name."
  }
}

variable "project_name" {
  type        = string
  description = "Name used to identify resources created by this stack."
  default     = "s3-static-site"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,30}$", var.project_name))
    error_message = "project_name must start with a lowercase letter and contain only lowercase letters, numbers, and hyphens."
  }
}
