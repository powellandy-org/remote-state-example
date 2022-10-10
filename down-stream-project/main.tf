data "terraform_remote_state" "base" {
  backend = "s3"
  config = {
    bucket         = "aws-base-state-powand"
    key            = "terraform.tfstate"
    region         = "us-east-2"
  }
}

resource aws_security_group bastion_ssh_access {
    name_prefix = "bastion_ssh_access_zoox_wp_cluster"
    vpc_id      = data.terraform_remote_state.base.outputs.vpc.vpc_id

    ingress {
        description = "andy home office"
        from_port = 22
        to_port   = 22
        protocol  = "tcp"

        cidr_blocks = data.terraform_remote_state.base.outputs.bastion_access_cidrs
    }
egress {
        description = "allow access to update packages"
        from_port = 0
        to_port  = 1000
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "allow access to rds MySQL"
        from_port = 3306
        to_port  = 3306
        protocol  = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
}


resource "aws_network_interface" "bastion" {
    subnet_id   = data.terraform_remote_state.base.outputs.vpc.public_subnets[1]
    private_ips = ["10.0.5.5"]
    security_groups = [aws_security_group.bastion_ssh_access.id]

    tags = {
        Name = "primary_network_interface"
    }
}