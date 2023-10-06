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
    dynatrace_node1_private_address = module.dynatrace_node1.dynatrace_node1_private_address
    #server_address = module.ecs.dynatrace_node1_private_address
    #public_subnet01 = values(module.vpc.public_subnet01)[0].id
   
}


#module "loadbalancer" {
#    source      = "../modules/loadbalancer"
#    name        = var.name
#    public_subnet01 = module.vpc.public_subnet01
   
#}

module "dynatrace_node1" {
    source      = "../modules/ecs"
    name        = var.name
    key_name    = var.key_name
    key_file    = var.key_file
    ssh_port    = var.ssh_port
    access_constraint_ecs = module.jump_host.jumphost_private_address
    #access_constraint_ecs = module.jump_host.jumphost_address
    flavor_id   = var.flavor_id
    image_name  = var.image_name
    private_subnet01 = module.vpc.private_subnet01
    
}

