module "static_site" {
  source       = "./modules/s3-static-site"
  aws_region   = var.aws_region
  project_name = var.project_name
  domain_name  = var.domain_name
}
