### mandatories

variable "name" {
  type        = string
  description = "Name of the VPC."
}

variable "tags" {
  type        = map(string)
  description = "Common tag set for project resources"
  default     = {}
}

variable "cidr_block" {
  type        = string
  description = "IP range of the VPC"
  default     = "10.0.0.0/16"
}

#variable "subnets" {
#  type        = map(string)
#  description = "Subnet names and their cidr ranges."
#  default = {
#    "private-subnet1" = ""
#    "private-subnet2" = ""
#    "public-subnet"   = ""
#   }
#}

#locals {
#  subnets_default_cidr = {                                 // divide network range to 8 parcels
#    "private-subnet1" = cidrsubnet(var.cidr_block, 2, 0) // first and second parcel
#    "private-subnet2" = cidrsubnet(var.cidr_block, 3, 2) // third parcel
#    "public-subnet"   = cidrsubnet(var.cidr_block, 3, 3) // fourth parcel
#  }                                                        // half of network range is left available for future expansion
#}

variable "dns_config" {
  type        = list(string)
  description = "Common Domain Name Server list for all subnets"
  default = [
    "100.125.4.25",
    "100.125.129.199",
  ]
}

variable "enable_shared_snat" {
  type        = bool
  description = "Enable the shared SNAT capability on VPCs in eu-de region. (default: true)"
  default     = true
}

variable "region" {
  type        = string
  description = "(default: eu-de)"
  default     = "eu-de"
}

