# 🌐 Terraform AWS S3 + CloudFront Static Website

A secure, scalable, and globally distributed **static website hosting solution** built on AWS using Terraform.

This project provisions:

- An S3 bucket configured for static website hosting
- A CloudFront distribution for global content delivery
- An ACM certificate for HTTPS
- DNS validation and Route 53 configuration
- AWS WAF (Web ACL) for basic protection
- Automated upload of site files (`index.html`) to S3

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
├── static-site/                  # Your static website content
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
git clone https://github.com/your-username/terraform-aws-s3-cloudfront-static-site.git
cd terraform-aws-s3-cloudfront-static-site
```

### 3. Update Variables

Edit `terraform.tfvars`:

```hcl
region      = "us-east-1"
project     = "s3-static-site"
domain_name = "yourdomain.com"
```

> Your domain must already be registered in Route 53 for DNS validation to succeed.

### 4. Configure AWS Environment Variables (Optional)

You can source your AWS credentials from an environment file instead of using `aws configure`.

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
- Create the S3 bucket
- Provision CloudFront + WAF + ACM
- Setup Route 53 alias + cert validation
- Automatically upload `static-site/index.html` to S3

---

## 📤 Outputs

| Output              | Description                             |
|---------------------|-----------------------------------------|
| `s3_bucket_name`    | Name of the S3 bucket                   |
| `cloudfront_domain` | CloudFront domain URL                   |
| `website_url`       | Full domain (e.g. https://yourdomain.com) |
| `waf_web_acl_arn`   | ARN of the WAF Web ACL                  |

---

## 📌 Notes

- ACM must be in `us-east-1` for CloudFront to use it.
- The WAF includes a basic AWS managed ruleset.
- You can replace the content in `static-site/` with your actual website files.

---

## 🧠 Inspiration

This project follows AWS best practices and is part of a portfolio series demonstrating real-world infrastructure automation using Terraform.
