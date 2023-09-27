module "vpc" {
    source       = "../modules/vpc"
    name        = var.name
}

module "jump_host" {
    source      = "../modules/jumphost"
    name        = var.name
    key_name    = var.key_name
    key_file    = var.key_file
    ssh_port    = var.ssh_port
    access_constraint = var.access_constraint
    flavor_id   = var.flavor_id
    image_name  = var.image_name
    public_subnet01 = module.vpc.public_subnet01
    #public_subnet01 = values(module.vpc.public_subnet01)[0].id
   
}
