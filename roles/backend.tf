terraform {

  provider "aws" {
  region     = "us-east-2"
  assume_role {
  role_arn     = var.AWS_ROLE_ARN
  
  }
  
}
  backend "s3" {
    bucket = "sample-dev-env-state"
    key    = "roles.tfstate"
    region = "us-east-2"
  }
}