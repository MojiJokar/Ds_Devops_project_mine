provider "aws" {
  region                   = var.aws_region
  shared_credentials_files = ["/mnt/c/Users/mmb20/.aws/credentials"]
  default_tags {
    tags = var.default_tags
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
