

##vpc

resource "opentelekomcloud_vpc_v1" "vpc" {
  name   = var.name
  cidr   = var.cidr_block
  shared = false
  tags   = var.tags
}

## Public Subnet ##

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

resource "opentelekomcloud_nat_gateway_v2" "nat_gw_az01" {
  name                = "${var.name}_natgw_az01"
  spec                = "1"
  router_id           = opentelekomcloud_vpc_v1.vpc.id
  internal_network_id = opentelekomcloud_vpc_subnet_v1.public_subnet01.id
}