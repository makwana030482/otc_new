## keypair

#resource "opentelekomcloud_compute_keypair_v2" "ecs_vm-keypair" {
#  name       = var.key_name
#  public_key = file(var.key_file)
#}

## Security Groups

resource "opentelekomcloud_networking_secgroup_v2" "dynatrce_node_ssh_ecs_vm_sg" {
  name        = "${var.name}_node_sg"
  description = "SSH Access to the dynatrce vms"
}

resource "opentelekomcloud_networking_secgroup_rule_v2" "dynatrace_ssh_ecs_vm_sg_in_rule" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = var.ssh_port
  port_range_max    = var.ssh_port
  #remote_ip_prefix  = var.access_constraint
  remote_ip_prefix  = var.access_constraint_ecs
  security_group_id = opentelekomcloud_networking_secgroup_v2.dynatrce_node_ssh_ecs_vm_sg.id
}

#resource "opentelekomcloud_networking_secgroup_rule_v2" "dynatrace_ssh_ecs_vm_sg_out_rule" {
#  direction         = "egress"
#  ethertype         = "IPv4"
#  protocol          = "tcp"
#  port_range_min    = var.ssh_port
#  port_range_max    = var.ssh_port
#  remote_ip_prefix  = var.access_constraint
#  security_group_id = opentelekomcloud_networking_secgroup_v2.dynatrce_node_ssh_ecs_vm_sg.id
#}

## Creating 4 volumes for Dynatrace node1

resource "opentelekomcloud_blockstorage_volume_v2" "volumes" {
  count = 4
  name  = format("vol-%02d", count.index + 1)
  availability_zone = var.availability_zone
  size  = 1
}

data "opentelekomcloud_images_image_v2" "ecs_vm_image" {
  name = var.image_name
}

resource "opentelekomcloud_compute_instance_v2" "dynatrace_node1" {

  name              = "${var.name}_node_az01"
  image_id          = data.opentelekomcloud_images_image_v2.ecs_vm_image.id
  flavor_id         = var.flavor_id
  key_pair          = var.key_name
  security_groups  = [opentelekomcloud_networking_secgroup_v2.dynatrce_node_ssh_ecs_vm_sg.id]
  availability_zone = var.availability_zone
  network {
    uuid = var.private_subnet01
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "Running user-initiated script"
              sudo apt-get update
              sudo apt-get install -y ansible
              sudo adduser --disabled-password --gecos "" cao
              echo 'cao ALL=(ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers
              sudo mkdir /home/cao/.ssh
              echo '${var.key_file}' > /home/cao/.ssh/authorized_keys
              sudo chown -R prayag:cao /home/prayag/.ssh
              sudo chmod 700 /home/cao/.ssh
              sudo chmod 600 /home/cao/.ssh/authorized_keys
              EOF
}

## Attaching Volumes to Dynatrace Nodes 

resource "opentelekomcloud_compute_volume_attach_v2" "attachments" {
  count       = 4
  instance_id = opentelekomcloud_compute_instance_v2.dynatrace_node1.id
  volume_id   = opentelekomcloud_blockstorage_volume_v2.volumes[count.index].id
}
