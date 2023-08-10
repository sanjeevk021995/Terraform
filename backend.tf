terraform {
  backend "s3" {
    bucket = "sample-dev-env-state"
    key    = "s3-bucket-test.tfstate"
    region = "us-east-2"
  }
}
