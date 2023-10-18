variable "name" {
  type        = string
  description = "Utilized to expose dynatrce UI."
}

variable "bandwidth" {
  type        = number
  default     = 300
  description = "The bandwidth size. The value ranges from 1 to 1000 Mbit/s."
}

variable "public_subnet01" {
  type        = string
}

variable "region" {
  type        = string
  description = "(default: eu-de)"
  default     = "eu-de"
}
