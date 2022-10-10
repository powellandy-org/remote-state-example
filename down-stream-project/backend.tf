terraform {
  required_version = "~> 1.2.0"

  backend "s3" {
    bucket         = "aws-downstream-state-powand"
    key            = "terraform.tfstate"
    region         = "us-east-2"
  }
}