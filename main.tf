provider "aws" {
  region     = "us-east-2"
  
}




resource "aws_s3_bucket" "testbucket-sam-test" {
  bucket = "sample-dev-env-sam95"

  tags = {
    Name         = "S3 Bucket Created by TS"
    Environment  = "PREPROD"
    SecurityZone = "na"
    
  }
}

