
terraform {
  backend "s3" {
    bucket = "dev-dev-frontend-assets"
    key    = "jenkins/terraform.tfstate"
    region = "eu-west-3"
    
  }
}
