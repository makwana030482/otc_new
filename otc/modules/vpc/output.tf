

output "vpc" {
  value = opentelekomcloud_vpc_v1.vpc
}

##output "subnets" {
##  value = opentelekomcloud_vpc_subnet_v1.subnets
##}

output "private_subnet01" {
  value = opentelekomcloud_vpc_subnet_v1.private_subnet01
}

output "private_subnet02" {
  value = opentelekomcloud_vpc_subnet_v1.private_subnet02
}

output "private_subnet03" {
  value = opentelekomcloud_vpc_subnet_v1.private_subnet03
}

output "public_subnet01" {
  value = opentelekomcloud_vpc_subnet_v1.public_subnet01
}

output "public_subnet02" {
  value = opentelekomcloud_vpc_subnet_v1.public_subnet02
}

output "public_subnet03" {
  value = opentelekomcloud_vpc_subnet_v1.public_subnet03
}