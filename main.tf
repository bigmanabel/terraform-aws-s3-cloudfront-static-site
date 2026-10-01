module "static_site" {
  source          = "./modules/s3-static-site"
  project_name    = var.project_name
  domain_name     = var.domain_name
  site_files_path = "${path.root}/build"

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }
}
