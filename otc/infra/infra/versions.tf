
provider "opentelekomcloud" {
  auth_url    = "https://iam.${var.region}.otc.t-systems.com/v3"
  tenant_name = var.region
  domain_name = var.credential.domain_name
  
}

terraform {
  backend "s3" {
    bucket                      = "remote-tfstate-file-dynatrace"
    #kms_key_id                  = "arn:aws:kms:eu-de:b41ee4665ee34a48b8b819d599827004:key/967c7437-b67f-479e-86b0-6c4ecb5c8ee4"
    key                         = "tfstate"
    region                      = "eu-de"
    endpoint                    = "obs.eu-de.otc.t-systems.com"
    encrypt                     = false
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}


terraform {
  required_providers {
    opentelekomcloud = {
      source = "opentelekomcloud/opentelekomcloud"
      version = ">= 1.23.2"
      #version = ">=1.31.5"
    }
 
  }
}
