provider "aws" {
  region = local.region
}

terraform {
  required_providers {
    aws = {
      version = ">= 3.56.0"
    }
  }
}
