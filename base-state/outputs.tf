output "vpc" {
    value = module.vpc
}

output bastion_access_cidrs {
    value = local.bastion_access
}

output base_region {
    value = local.region
}
