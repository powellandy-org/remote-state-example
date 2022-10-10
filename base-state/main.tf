################################################################################
# Supporting resources
################################################################################

data "aws_availability_zones" "available" {
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

locals {
  name   = "main-app-${random_string.suffix.result}"
  region = "us-east-2"
  bastion_access = [
    "24.27.9.159/32" # andy austin
  ]
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name                 = local.name
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] //pull these out into the "vars" module
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
}
