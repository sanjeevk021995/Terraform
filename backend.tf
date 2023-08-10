terraform {
  backend "s3" {
    bucket = "state-file-terraform-dev"
    key    = "s3-bucket-test.tfstate"
    region = "us-east-2"
  }
}
