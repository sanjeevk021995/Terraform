terraform {
  backend "s3" {
    bucket = "sample-dev-env-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
 //   role_arn     = var.AWS_ROLE_ARN
  }
}
