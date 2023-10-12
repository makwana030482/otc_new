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

variable "availability_zone" {
  type        = string
  description = "choose from eu-de-01, eu-de-02, eu-de-03 default: eu-de-01)"
  default     = "eu-de-01"
}

variable "node_storage_type" {
  type        = string
  description = "choose from SSD, SAS, SATA  default: SAS"
  default     = "SAS"
}

variable "flavor_id_cag" {
  type        = string
  description = "Jumphost node specifications in otc flavor format. (default: s3.medium.2 (3rd generation 1 Core 2GB RAM))"
  default     = "s3.large.2"
}

variable "flavor_id_node" {
  type        = string
  description = "Jumphost node specifications in otc flavor format. (default: s3.medium.2 (3rd generation 1 Core 2GB RAM))"
  default     = "s3.xlarge.8"
}

variable "flavor_id" {
  type        = string
  description = "Jumphost node specifications in otc flavor format. (default: s3.medium.2 (3rd generation 1 Core 2GB RAM))"
  default     = "s3.medium.1"
}


variable "key_name" {
  type        = string
  description = "Path to the public SSH key file"
  default     = "my-key"
}

variable "key_file" {
  type        = string
  description = "Path to the public SSH key file"
  default     = "~/.ssh/id_rsa.pub"
}

variable "image_name" {
  type        = string
  description = "Name of the image for the ECS VM"
  default     = "Standard_Ubuntu_20.04_latest"
}

variable "ssh_port" {
  description = "SSH port for security group rule"
  type        = number
  default     = "22"
}

variable "access_constraint" {
  description = "CIDR block for security group rule"
  type        = string
  default     = "0.0.0.0/0" 
}