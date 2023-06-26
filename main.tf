provider "aws" {
  region     = "us-east-2"
  
}

resource "aws_s3_bucket" "testbucket-sam-95" {
  bucket = "sampledevenv"

  tags = {
    Name         = "S3 Bucket Created by TS"
    Environment  = "Test"
    SecurityZone = "na"
  }

}
