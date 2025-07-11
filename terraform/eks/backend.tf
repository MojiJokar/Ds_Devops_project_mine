
terraform {
  backend "s3" {
    bucket = "dev-dev-frontend-assets"
    key    = "eks/terraform.tfstate"
    region = "eu-west-3"
    
  }
}
