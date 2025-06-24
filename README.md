# 🌐 Terraform AWS S3 + CloudFront Static Website

A secure, scalable, and globally distributed **static website hosting solution**
built on AWS using Terraform.

This project provisions:

- An S3 bucket configured for static website hosting with modern security
  controls
- A CloudFront distribution for global content delivery with optimized caching
- An ACM certificate for HTTPS with automatic DNS validation
- Route 53 DNS configuration for custom domain
- AWS WAF (Web ACL) for basic security protection
- Automated upload of site files from `build/` directory to S3
- Modern Terraform configuration following AWS provider v5 best practices

---

<!-- ## 🗺️ Architecture Diagram -->
<!--  -->
<!-- **Title:** *Static Website Hosting on AWS with S3, CloudFront, WAF, and Route 53* -->
<!--  -->
<!-- ![Architecture Diagram](./diagrams/static-site-architecture.png) -->
<!--  -->
<!-- > The diagram includes S3 for hosting, CloudFront for global access and TLS, ACM for HTTPS, WAF for protection, and Route 53 for DNS. -->
<!--  -->
<!-- --- -->

## 🧱 Project Structure

```bash
terraform-aws-s3-cloudfront-static-site/
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── build/                        # Your static website content
│   └── index.html
└── modules/
    └── s3-static-site/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

---

## 🛠 Setup Instructions

### 1. Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- AWS credentials configured (`aws configure`)

### 2. Clone the Repository

```bash
git clone https://github.com/bigmanabel/terraform-aws-s3-cloudfront-static-site.git
cd terraform-aws-s3-cloudfront-static-site
```

### 3. Update Variables

Edit `terraform.tfvars`:

```hcl
aws_region   = "us-east-1"
project_name = "your-project-name"
domain_name  = "yourdomain.com"
```

> Your domain must already be registered in Route 53 for DNS validation to
> succeed.

### 4. Configure AWS Environment Variables (Optional)

You can source your AWS credentials from an environment file instead of using
`aws configure`.

Create a `.env` file:

```bash
touch .env
```

Add your credentials:

```env
export AWS_ACCESS_KEY_ID=your-access-key-id
export AWS_SECRET_ACCESS_KEY=your-secret-access-key
export AWS_DEFAULT_REGION=us-east-1
```

Then source the file in your shell:

```bash
source .env
```

This method is useful for scripting, automation, or managing multiple profiles.

---

## 🚀 Deploy the Stack

```bash
terraform init
terraform plan
terraform apply
```

Terraform will:

- Create the S3 bucket with modern security configurations
- Provision CloudFront distribution with AWS managed cache policies
- Setup ACM certificate with automatic DNS validation
- Configure WAF with AWS managed rules for basic protection
- Create Route 53 alias records for your domain
- Automatically upload files from `build/` directory to S3

---

## 📤 Outputs

| Output                | Description                                 |
| --------------------- | ------------------------------------------- |
| `s3_bucket_name`      | Name of the S3 bucket                       |
| `cloudfront_domain`   | CloudFront domain URL                       |
| `website_url`         | Full domain (e.g. `https://yourdomain.com`) |
| `waf_web_acl_arn`     | ARN of the WAF Web ACL                      |
| `acm_certificate_arn` | ARN of the ACM certificate                  |

---

## 📌 Notes

- ACM certificate must be provisioned in `us-east-1` region for CloudFront
  compatibility
- The WAF includes AWS managed Common Rule Set for basic protection
- Website files should be placed in the `build/` directory for automatic
  deployment
- The configuration follows modern AWS provider v5 practices with separate
  resources for S3 bucket configurations
- CloudFront uses AWS managed cache policies for optimal performance

---

## 🧠 Inspiration

This project follows AWS best practices and is part of a portfolio series
demonstrating real-world infrastructure automation using Terraform.
