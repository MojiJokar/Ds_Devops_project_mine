terraform {
  backend "s3" {
    bucket = "dev-dev-frontend-assets"
    key    = "eks/terraform.tfstate"
    region = "eu-west-3"
    # Optionally add:
    # encrypt = true
    # dynamodb_table = "terraform_locks"
  }
}
