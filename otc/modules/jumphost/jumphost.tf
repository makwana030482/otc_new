##  Creating a Fixed EIP for Jumphost 


resource "opentelekomcloud_vpc_eip_v1" "jumphost_eip" {
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = "${var.name}_jh_eip_az01"
    size        = 1
    share_type  = "PER"
    charge_mode = "traffic"
  }
}

## keypair

resource "opentelekomcloud_compute_keypair_v2" "ecs_vm-keypair" {
  name       = var.key_name
  public_key = file(var.key_file)
}


## Security Groups 

resource "opentelekomcloud_networking_secgroup_v2" "jh_ssh_ecs_vm_sg" {
  name        = "${var.name}_jump_host_sg"
  description = "SSH Access to the ecs_vm"
}

resource "opentelekomcloud_networking_secgroup_rule_v2" "jh_ssh_ecs_vm_sg_in_rule" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = var.ssh_port
  port_range_max    = var.ssh_port
  remote_ip_prefix  = var.access_constraint
  security_group_id = opentelekomcloud_networking_secgroup_v2.jh_ssh_ecs_vm_sg.id
}

resource "opentelekomcloud_networking_secgroup_rule_v2" "jh_ssh_ecs_vm_sg_out_rule" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = var.ssh_port
  port_range_max    = var.ssh_port
  remote_ip_prefix  = var.access_constraint
  security_group_id = opentelekomcloud_networking_secgroup_v2.jh_ssh_ecs_vm_sg.id
}

## Creating VMs


data "opentelekomcloud_images_image_v2" "ecs_vm_image" {
  name = var.image_name
}

resource "opentelekomcloud_compute_instance_v2" "jump_host" {

  name              = "${var.name}_jump_host_az01"
  image_id          = data.opentelekomcloud_images_image_v2.ecs_vm_image.id
  flavor_id         = var.flavor_id
  key_pair          = var.key_name
  security_groups  = [opentelekomcloud_networking_secgroup_v2.jh_ssh_ecs_vm_sg.id]
  availability_zone = var.availability_zone1
  network {
    uuid = var.public_subnet01
  }
}

## Assigning eip to jumphost

resource "opentelekomcloud_networking_floatingip_associate_v2" "jumphost_eip_association" {
  floating_ip = opentelekomcloud_vpc_eip_v1.jumphost_eip.publicip[0].ip_address
  port_id     = opentelekomcloud_compute_instance_v2.jump_host.network[0].port
}