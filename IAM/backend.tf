terraform{
backend "s3" {
    bucket = "sample-dev-env-state"
    key    = "ism.tfstate"
    region = "us-east-2"
  }
}
