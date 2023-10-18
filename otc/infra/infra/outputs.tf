#output "public_subnet01" {
#  value = opentelekomcloud_vpc_subnet_v1.public_subnet01
#}

output "vpc" {
  value = module.vpc.public_subnet01
}