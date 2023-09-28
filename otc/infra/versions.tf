terraform {
  required_providers {
    opentelekomcloud = {
      source = "opentelekomcloud/opentelekomcloud"
      version = ">= 1.23.2"
      #version = ">=1.31.5"
    }
  }
}


provider "opentelekomcloud" {
  auth_url    = "https://iam.${var.region}.otc.t-systems.com/v3"
  tenant_name = var.region
}
