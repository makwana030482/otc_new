

output "vpc" {
  value = opentelekomcloud_vpc_v1.vpc
}

##output "subnets" {
##  value = opentelekomcloud_vpc_subnet_v1.subnets
##}

output "private_subnet" {
  value = opentelekomcloud_vpc_subnet_v1.private_subnet
}

output "public_subnet" {
  value = opentelekomcloud_vpc_subnet_v1.public_subnet
}
