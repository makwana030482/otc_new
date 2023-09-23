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

variable "availability_zone01" {
  type        = string
  description = "AZ 01"
  default     = "eu-de-01"
}

variable "availability_zone02" {
  type        = string
  description = "AZ 02"
  default     = "eu-de-02"
}

variable "availability_zone03" {
  type        = string
  description = "AZ 03"
  default     = "eu-de-03"
}

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