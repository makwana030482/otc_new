

##vpc

resource "opentelekomcloud_vpc_v1" "vpc" {
  name   = var.name
  cidr   = var.cidr_block
  shared = false
  tags   = var.tags
}

##Subnets

##resource "opentelekomcloud_vpc_subnet_v1" "subnets" {
##  for_each   = var.subnets
##  name       = each.key
##  vpc_id     = opentelekomcloud_vpc_v1.vpc.id
##  cidr       = each.value != "" ? each.value : local.subnets_default_cidr[each.key]
##  gateway_ip = cidrhost(each.value != "" ? each.value : local.subnets_default_cidr[each.key], 1)
##  dns_list   = var.dns_config
##  tags       = var.tags
##}

## Private Subnet

resource "opentelekomcloud_vpc_subnet_v1" "private_subnet" {
  name       = "${var.name}_private_subnet"
  vpc_id     = opentelekomcloud_vpc_v1.vpc.id
  cidr       = "${cidrsubnet(opentelekomcloud_vpc_v1.vpc.cidr, 8, 0)}"
  #gateway_ip = cidrhost(var.cidr_block, 1)
  gateway_ip = cidrhost(cidrsubnet(opentelekomcloud_vpc_v1.vpc.cidr, 8, 0),1)
  
}

## Public Subnet

resource "opentelekomcloud_vpc_subnet_v1" "public_subnet" {
  name       = "${var.name}_public_subnet"
  vpc_id     = opentelekomcloud_vpc_v1.vpc.id
  cidr       = "${cidrsubnet(opentelekomcloud_vpc_v1.vpc.cidr, 8, 1)}"
  #gateway_ip = cidrhost(var.cidr_block, 1)
  gateway_ip = cidrhost(cidrsubnet(opentelekomcloud_vpc_v1.vpc.cidr, 8, 1),1)
}

## Nat gw

resource "opentelekomcloud_nat_gateway_v2" "nat_gw" {
  name                = "${var.name}_nat_gw"
  description         = "NAT GW"
  spec                = "1"
  router_id           = opentelekomcloud_vpc_v1.vpc.id
  internal_network_id = opentelekomcloud_vpc_subnet_v1.public_subnet.id

}
## EIP for SNAT

resource "opentelekomcloud_networking_floatingip_v2" "snat_public_ip" {
}


## SNAT Rules

resource "opentelekomcloud_nat_snat_rule_v2" "nc_snat_public" {
  nat_gateway_id = opentelekomcloud_nat_gateway_v2.nat_gw.id
  floating_ip_id = opentelekomcloud_networking_floatingip_v2.snat_public_ip.id
  network_id     = opentelekomcloud_vpc_subnet_v1.public_subnet.id
  source_type    = 0
}

##resource "opentelekomcloud_nat_snat_rule_v2" "nc_snat_private" {
##  nat_gateway_id = opentelekomcloud_nat_gateway_v2.nc_nat.id
##  floating_ip_id = opentelekomcloud_networking_floatingip_v2.snat_public_ip.id
##  network_id     = opentelekomcloud_vpc_subnet_v1.private.id
##  source_type    = 0
##}

