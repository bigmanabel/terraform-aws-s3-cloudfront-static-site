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
