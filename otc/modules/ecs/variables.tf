variable "name" {
  description = "Jumphost node name."
}

### Region

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

variable "private_subnet01" {
  type        = string
}
