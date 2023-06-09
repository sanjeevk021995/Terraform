provider "aws" {
  region     = "us-east-2"
assume_role {
    role_arn     = var.AWS_ROLE_ARN
  
  }
  
}

variable "AWS_ROLE_ARN" {
  description = "aws arn"
  type        = string
  sensitive   = true
}


resource "aws_s3_bucket" "testbucket-sam-test-roles" {
  bucket = "sample-dev-rolebucket"
  tags = {
    Name         = "S3 Bucket Created by TS"
    Environment  = "test-role"
    SecurityZone = "na"
  }
}

