terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      configuration_aliases = [
        aws.us_east_1,
      ]
    }
  }
}

variable "project_name" {
  type        = string
  description = "Name used to identify resources created by this module."
}

variable "domain_name" {
  type        = string
  description = "Custom domain for the static site (must exist in Route 53)"
}

variable "site_files_path" {
  type        = string
  description = "Absolute path to the built static-site files to upload."

  validation {
    condition     = length(fileset(var.site_files_path, "**")) > 0
    error_message = "site_files_path must contain at least one file before Terraform can deploy the site."
  }
}
