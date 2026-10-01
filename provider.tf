terraform {
  required_version = ">= 1.7, < 2.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0, < 7.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# CloudFront-scope ACM certificates and WAF web ACLs must be managed in
# us-east-1, regardless of the region used for the S3 bucket.
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}
