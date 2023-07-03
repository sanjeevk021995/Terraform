provider "aws" {
  region     = "us-east-2"
assume_role {
    role_arn     = var.AWS_ROLE_ARN
  
  }
  
}

terraform {
  backend "s3" {
    bucket = "sample-dev-env-state"
    key    = "terraform.tfstate"
    region = "us-east-2"
 //   role_arn     = var.AWS_ROLE_ARN
  }
}

resource "aws_s3_bucket" "testbucket-sam-test" {
  bucket = "sample-dev-env-sam95"

  tags = {
    Name         = "S3 Bucket Created by TS"
    Environment  = "Test"
    SecurityZone = "na"
  }
}

