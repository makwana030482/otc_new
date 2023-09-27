

output "vpc" {
  value = opentelekomcloud_vpc_v1.vpc
}

output "private_subnet01" {
  value = opentelekomcloud_vpc_subnet_v1.private_subnet01.id
}

output "private_subnet02" {
  value = opentelekomcloud_vpc_subnet_v1.private_subnet02.id
}

output "private_subnet03" {
  value = opentelekomcloud_vpc_subnet_v1.private_subnet03.id
}

output "public_subnet01" {
  value = opentelekomcloud_vpc_subnet_v1.public_subnet01.id
}

output "public_subnet02" {
  value = opentelekomcloud_vpc_subnet_v1.public_subnet02.id
}

output "public_subnet03" {
  value = opentelekomcloud_vpc_subnet_v1.public_subnet03.id
}