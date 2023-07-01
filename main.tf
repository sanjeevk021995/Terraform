provider "aws" {
  region     = "us-east-2"
assume_role {
    role_arn     = var.AWS_ROLE_ARN
  
  }
  
}

/*resource "aws_s3_bucket" "testbucket-sam-95" {
  bucket = "sample-dev-env-state"

  tags = {
    Name         = "S3 Bucket Created by TS"
    Environment  = "Test"
    SecurityZone = "na"
  }

}
*/
