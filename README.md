# Terraform AWS Static Site Delivery

[![Terraform](https://img.shields.io/badge/Terraform-1.7%2B-623CE4?logo=terraform&logoColor=white)](https://developer.hashicorp.com/terraform)
[![AWS Provider](https://img.shields.io/badge/AWS_Provider-5.x-FF9900?logo=amazonaws&logoColor=white)](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

A Terraform reference implementation for publishing a custom-domain static
website through Amazon CloudFront. It demonstrates the infrastructure pieces a
small marketing site or documentation portal needs: HTTPS, DNS validation,
edge caching, and baseline web protection.

Part of [Abel Nutsugah’s AWS infrastructure portfolio](https://github.com/bigmanabel).

## Use case

Use this project as a starting point when a static frontend needs a global URL,
a custom domain, and an infrastructure-as-code deployment path. Place built
site assets in `build/`, then Terraform provisions and synchronizes the
delivery stack.

## Architecture

```mermaid
flowchart LR
    Visitor[Site visitor] -->|HTTPS| CF[CloudFront distribution]
    CF -->|HTTP origin| S3[S3 static website endpoint]
    CF --> WAF[AWS WAF managed rules]
    DNS[Route 53 hosted zone] --> CF
    ACM[ACM certificate] --> CF
    TF[Terraform] --> S3
```

## What Terraform creates

- S3 bucket and static-website configuration for the site assets
- CloudFront distribution with compression and AWS-managed cache policy
- ACM certificate and Route 53 DNS validation records
- Route 53 alias record for the custom domain
- AWS WAF web ACL using the AWS managed Common Rule Set
- A local sync step that uploads `build/` to the S3 bucket

## Prerequisites

- Terraform `~> 1.7`
- AWS CLI authenticated with a profile, AWS IAM Identity Center, or environment
  credentials
- A public Route 53 hosted zone for the exact `domain_name`
- Static site files in `build/`

> **Region requirement:** CloudFront certificates and CloudFront-scope WAF
> resources must be created in `us-east-1`. Run this implementation in that
> region until the provider-alias hardening work is added.

## Configure and validate

Copy the example, then replace the placeholders with your values:

```bash
cp terraform.tfvars.example terraform.tfvars
terraform fmt -check -recursive
terraform init
terraform validate
terraform plan
```

```hcl
aws_region   = "us-east-1"
project_name = "example-marketing-site"
domain_name  = "example.com"
```

Apply only after reviewing the plan:

```bash
terraform apply
```

Useful outputs include the S3 bucket name, CloudFront domain, custom website
URL, ACM certificate ARN, and WAF ARN.

## Operational notes

- CloudFront, WAF, Route 53, and S3 can incur charges. Review the plan and
  current AWS pricing before applying or leaving the stack running.
- The asset sync runs with `aws s3 sync --delete`; removing a file from
  `build/` removes its matching object from the deployment bucket on the next
  apply.
- Terraform state can contain infrastructure details. Keep state in a secured
  remote backend for team or long-lived environments, and never commit local
  state or `terraform.tfvars` files.

## Current implementation boundary

This repository intentionally documents the implementation as it exists. The
S3 website endpoint is publicly readable so CloudFront can use it as a custom
origin. For a client production deployment, the recommended follow-up is a
private S3 bucket with CloudFront Origin Access Control, an S3 REST origin, and
explicit provider aliases for the CloudFront certificate and WAF resources.

## Project layout

```text
├── build/                       # Static site assets to upload
├── main.tf                      # Root module
├── provider.tf                  # Terraform and AWS provider requirements
├── terraform.tfvars.example     # Safe configuration template
└── modules/s3-static-site/      # S3, CloudFront, ACM, Route 53, and WAF
```

## Cleanup

Run `terraform destroy` only after confirming the target AWS account and
workspace. This removes the delivery resources and the deployed site assets.
