terraform {
  backend "s3" {
    bucket         = "dev-dev-frontend-assets"
    key            = "eks/terraform.tfstate"
    region         = "eu-west-3"
    encrypt        = true
    #  dynamodb_table = "terraform_locks"  # Make sure this DynamoDB table exists
  }
}
