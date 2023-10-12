

##vpc

resource "opentelekomcloud_vpc_v1" "vpc" {
  name   = var.name
  cidr   = var.cidr_block
  shared = false
  tags   = var.tags
}

## Private Subnet ##

resource "opentelekomcloud_vpc_subnet_v1" "private_subnet01" {
  name       = "${var.name}_private_subnet_az01"
  vpc_id     = opentelekomcloud_vpc_v1.vpc.id
  cidr       = "${cidrsubnet(opentelekomcloud_vpc_v1.vpc.cidr, 8, 0)}"
  gateway_ip = cidrhost(cidrsubnet(opentelekomcloud_vpc_v1.vpc.cidr, 8, 0),1)
  availability_zone = var.availability_zone01
}

resource "opentelekomcloud_vpc_subnet_v1" "private_subnet02" {
  name       = "${var.name}_private_subnet_az02"
  vpc_id     = opentelekomcloud_vpc_v1.vpc.id
  cidr       = "${cidrsubnet(opentelekomcloud_vpc_v1.vpc.cidr, 8, 1)}"
  gateway_ip = cidrhost(cidrsubnet(opentelekomcloud_vpc_v1.vpc.cidr, 8, 1),1)
  availability_zone = var.availability_zone02
}

resource "opentelekomcloud_vpc_subnet_v1" "private_subnet03" {
  name       = "${var.name}_private_subnet_az03"
  vpc_id     = opentelekomcloud_vpc_v1.vpc.id
  cidr       = "${cidrsubnet(opentelekomcloud_vpc_v1.vpc.cidr, 8, 2)}"
  gateway_ip = cidrhost(cidrsubnet(opentelekomcloud_vpc_v1.vpc.cidr, 8, 2),1)
  availability_zone = var.availability_zone03
}


## Public Subnet ##

resource "opentelekomcloud_vpc_subnet_v1" "public_subnet01" {
  name       = "${var.name}_public_subnet_az01"
  vpc_id     = opentelekomcloud_vpc_v1.vpc.id
  cidr       = "${cidrsubnet(opentelekomcloud_vpc_v1.vpc.cidr, 8, 3)}"
  gateway_ip = cidrhost(cidrsubnet(opentelekomcloud_vpc_v1.vpc.cidr, 8, 3),1)
  availability_zone = var.availability_zone01
}

resource "opentelekomcloud_vpc_subnet_v1" "public_subnet02" {
  name       = "${var.name}_public_subnet_az02"
  vpc_id     = opentelekomcloud_vpc_v1.vpc.id
  cidr       = "${cidrsubnet(opentelekomcloud_vpc_v1.vpc.cidr, 8, 4)}"
  gateway_ip = cidrhost(cidrsubnet(opentelekomcloud_vpc_v1.vpc.cidr, 8, 4),1)
  availability_zone = var.availability_zone02
}

resource "opentelekomcloud_vpc_subnet_v1" "public_subnet03" {
  name       = "${var.name}_public_subnet_az03"
  vpc_id     = opentelekomcloud_vpc_v1.vpc.id
  cidr       = "${cidrsubnet(opentelekomcloud_vpc_v1.vpc.cidr, 8, 5)}"
  gateway_ip = cidrhost(cidrsubnet(opentelekomcloud_vpc_v1.vpc.cidr, 8, 5),1)
  availability_zone = var.availability_zone03
}

## NAT Gateway

resource "opentelekomcloud_vpc_eip_v1" "nat_ip_az01" {
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name       = "${var.name}-snat-bandwidth_az01"
    size       = 1
    share_type = "PER"
  }
  tags = var.tags
}

resource "opentelekomcloud_nat_gateway_v2" "nat_gw_az01" {
  name                = "${var.name}_natgw_az01"
  spec                = "1"
  router_id           = opentelekomcloud_vpc_v1.vpc.id
  #internal_network_id = opentelekomcloud_vpc_subnet_v1.public_subnet01.id
  internal_network_id = opentelekomcloud_vpc_subnet_v1.private_subnet01.id
}

resource "opentelekomcloud_nat_snat_rule_v2" "snat_rule_az01" {
  nat_gateway_id     = opentelekomcloud_nat_gateway_v2.nat_gw_az01.id
  floating_ip_id  = opentelekomcloud_vpc_eip_v1.nat_ip_az01.id
  cidr  = opentelekomcloud_vpc_subnet_v1.private_subnet01.cidr
  
}

resource "opentelekomcloud_vpc_eip_v1" "nat_ip_az02" {
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name       = "${var.name}-snat-bandwidth_az02"
    size       = 1
    share_type = "PER"
  }
  tags = var.tags
}

resource "opentelekomcloud_nat_gateway_v2" "nat_gw_az02" {
  name                = "${var.name}_natgw_az02"
  spec                = "1"
  router_id           = opentelekomcloud_vpc_v1.vpc.id
  #internal_network_id = opentelekomcloud_vpc_subnet_v1.public_subnet01.id
  internal_network_id = opentelekomcloud_vpc_subnet_v1.private_subnet02.id
}

resource "opentelekomcloud_nat_snat_rule_v2" "snat_rule_az02" {
  nat_gateway_id     = opentelekomcloud_nat_gateway_v2.nat_gw_az02.id
  floating_ip_id  = opentelekomcloud_vpc_eip_v1.nat_ip_az02.id
  cidr  = opentelekomcloud_vpc_subnet_v1.private_subnet02.cidr
  
}

resource "opentelekomcloud_vpc_eip_v1" "nat_ip_az03" {
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name       = "${var.name}-snat-bandwidth_az03"
    size       = 1
    share_type = "PER"
  }
  tags = var.tags
}

resource "opentelekomcloud_nat_gateway_v2" "nat_gw_az03" {
  name                = "${var.name}_natgw_az03"
  spec                = "1"
  router_id           = opentelekomcloud_vpc_v1.vpc.id
  #internal_network_id = opentelekomcloud_vpc_subnet_v1.public_subnet01.id
  internal_network_id = opentelekomcloud_vpc_subnet_v1.private_subnet03.id
}

resource "opentelekomcloud_nat_snat_rule_v2" "snat_rule" {
  nat_gateway_id     = opentelekomcloud_nat_gateway_v2.nat_gw_az03.id
  floating_ip_id  = opentelekomcloud_vpc_eip_v1.nat_ip_az03.id
  cidr  = opentelekomcloud_vpc_subnet_v1.private_subnet03.cidr
  
}