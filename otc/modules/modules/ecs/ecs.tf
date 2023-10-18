####### Security Group ##########

## 1.for allowing SSH to Dynatrace VMs from JumpHost

resource "opentelekomcloud_networking_secgroup_v2" "dynatrce_node_ssh_ecs_vm_sg" {
  name        = "${var.name}_node_sg"
  description = "SSH Access to the dynatrce vms"
  
}

## 2.for allowing connections to Cluster Active Gate nodes from internet source 0.0.0.0

  resource "opentelekomcloud_networking_secgroup_v2" "cluster_active_gate_sg" {
    name        = "${var.name}_cluster_active_gate_sg"
    description = "allowing connections to Cluster Active Gate nodes from internet source 0.0.0.0"

  }


####### Security Group Ingress Rules##########

## Security group rules for Dynatrace Nodes - Ingress Security Group Rules for allowing Jumphost connection to Dynatrace Nodes

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

resource "opentelekomcloud_networking_secgroup_rule_v2" "dynatrace_ssh_ecs_vm_sg_in_rule1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = var.clusteractivegates_port2
  port_range_max    = var.clusteractivegates_port2
  #remote_ip_prefix  = var.access_constraint
  remote_ip_prefix  = opentelekomcloud_compute_instance_v2.clusteractivegate_node1.access_ip_v4
  security_group_id = opentelekomcloud_networking_secgroup_v2.dynatrce_node_ssh_ecs_vm_sg.id
}

## Security group rules for Cluster Active Gates - Ingress Security Group Rules for allowing ssh from internet to Cluster Active gate

resource "opentelekomcloud_networking_secgroup_rule_v2" "cluster_active_gate_sg1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = var.ssh_port
  port_range_max    = var.ssh_port
  remote_ip_prefix  = var.access_constraint
  security_group_id = opentelekomcloud_networking_secgroup_v2.cluster_active_gate_sg.id
}

## Security group rules for Cluster Active Gates - Ingress Security Group Rules for allowing traffic on port 9999 from internet to Cluster Active gate

resource "opentelekomcloud_networking_secgroup_rule_v2" "cluster_active_gate_sg2" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = var.clusteractivegates_port1
  port_range_max    = var.clusteractivegates_port1
  remote_ip_prefix  = var.access_constraint
  security_group_id = opentelekomcloud_networking_secgroup_v2.cluster_active_gate_sg.id
}


## Egress Security Group Rules

## Egress Security group rule to allow https port to Dynatrace nodes in Private subnet

#resource "opentelekomcloud_networking_secgroup_rule_v2" "cluster_active_gate_sg3" {
#  direction         = "egress"
#  ethertype         = "IPv4"
#  protocol          = "tcp"
#  port_range_min    = var.clusteractivegates_port2
#  port_range_max    = var.clusteractivegates_port2
#  remote_ip_prefix  = var.access_constraint
#  security_group_id = opentelekomcloud_networking_secgroup_v2.cluster_active_gate_sg.id
#}

## Egress Security Group Rules

#resource "opentelekomcloud_networking_secgroup_rule_v2" "dynatrace_ssh_ecs_vm_sg_out_rule" {
#  direction         = "egress"
#  ethertype         = "IPv4"
#  protocol          = "tcp"
#  port_range_min    = var.ssh_port
#  port_range_max    = var.ssh_port
#  remote_ip_prefix  = var.access_constraint
#  security_group_id = opentelekomcloud_networking_secgroup_v2.dynatrce_node_ssh_ecs_vm_sg.id
#}

## Creating 4 volumes for Dynatrace managed nodes

resource "opentelekomcloud_blockstorage_volume_v2" "Dyna_install_volume_az1" {
  count = 1
  name  = format("vol-%02d", count.index + 1)
  availability_zone = var.availability_zone1
  size  = 20
}

resource "opentelekomcloud_blockstorage_volume_v2" "trans_Logs_volume_az1" {
  count = 1
  name  = format("vol-%02d", count.index + 1)
  availability_zone = var.availability_zone1
  size  = 50
}

resource "opentelekomcloud_blockstorage_volume_v2" "long_term_volume_az1" {
  count = 1
  name  = format("vol-%02d", count.index + 1)
  availability_zone = var.availability_zone1
  size  = 100
}

resource "opentelekomcloud_blockstorage_volume_v2" "elastic_storage_volume_az1" {
  count = 1
  name  = format("vol-%02d", count.index + 1)
  availability_zone = var.availability_zone1
  size  = 50
}
#resource "opentelekomcloud_blockstorage_volume_v2" "volumes_az2" {
#  count = 4
#  name  = format("vol-%02d", count.index + 1)
#  availability_zone = var.availability_zone2
#  size  = 50
#}

resource "opentelekomcloud_blockstorage_volume_v2" "Dyna_install_volume_az2" {
  count = 1
  name  = format("vol-%02d", count.index + 1)
  availability_zone = var.availability_zone2
  size  = 20
}

resource "opentelekomcloud_blockstorage_volume_v2" "trans_Logs_volume_az2" {
  count = 1
  name  = format("vol-%02d", count.index + 1)
  availability_zone = var.availability_zone2
  size  = 50
}

resource "opentelekomcloud_blockstorage_volume_v2" "long_term_volume_az2" {
  count = 1
  name  = format("vol-%02d", count.index + 1)
  availability_zone = var.availability_zone2
  size  = 100
}

resource "opentelekomcloud_blockstorage_volume_v2" "elastic_storage_volume_az2" {
  count = 1
  name  = format("vol-%02d", count.index + 1)
  availability_zone = var.availability_zone2
  size  = 50
}

#resource "opentelekomcloud_blockstorage_volume_v2" "volumes_az3" {
#  count = 4
#  name  = format("vol-%02d", count.index + 1)
#  availability_zone = var.availability_zone3
#  size  = 50
#}

resource "opentelekomcloud_blockstorage_volume_v2" "Dyna_install_volume_az3" {
  count = 1
  name  = format("vol-%02d", count.index + 1)
  availability_zone = var.availability_zone3
  size  = 20
}

resource "opentelekomcloud_blockstorage_volume_v2" "trans_Logs_volume_az3" {
  count = 1
  name  = format("vol-%02d", count.index + 1)
  availability_zone = var.availability_zone3
  size  = 50
}

resource "opentelekomcloud_blockstorage_volume_v2" "long_term_volume_az3" {
  count = 1
  name  = format("vol-%02d", count.index + 1)
  availability_zone = var.availability_zone3
  size  = 100
}

resource "opentelekomcloud_blockstorage_volume_v2" "elastic_storage_volume_az3" {
  count = 1
  name  = format("vol-%02d", count.index + 1)
  availability_zone = var.availability_zone3
  size  = 50
}

data "opentelekomcloud_images_image_v2" "ecs_vm_image" {
  name = var.image_name
}

## Creating Cluster Active gate Dynatrace in Public Subnet

resource "opentelekomcloud_vpc_eip_v1" "clusteractivegate_node1_eip" {
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = "${var.name}_CluactNod01_eip_az01"
    size        = 1
    share_type  = "PER"
    charge_mode = "traffic"
  }
}

## Assigning EIP to Active cluster gate node 01

resource "opentelekomcloud_networking_floatingip_associate_v2" "jumphost_eip_association" {
  floating_ip = opentelekomcloud_vpc_eip_v1.clusteractivegate_node1_eip.publicip[0].ip_address
  port_id     = opentelekomcloud_compute_instance_v2.clusteractivegate_node1.network[0].port
}

resource "opentelekomcloud_compute_instance_v2" "clusteractivegate_node1" {

  name              = "${var.name}_clus_activ_gate_az01"
  image_id          = data.opentelekomcloud_images_image_v2.ecs_vm_image.id
  flavor_id         = var.flavor_id_cag
  key_pair          = var.key_name
  security_groups  = [opentelekomcloud_networking_secgroup_v2.cluster_active_gate_sg.id]
  availability_zone = var.availability_zone1
  network {
    uuid = var.public_subnet01
  }
}

## Creating Dynatrace Nodes in Private subnet

resource "opentelekomcloud_compute_instance_v2" "dynatrace_node1" {

  name              = "${var.name}_node_az01"
  image_id          = data.opentelekomcloud_images_image_v2.ecs_vm_image.id
  flavor_id         = var.flavor_id_node
  key_pair          = var.key_name
  security_groups  = [opentelekomcloud_networking_secgroup_v2.dynatrce_node_ssh_ecs_vm_sg.id]
  availability_zone = var.availability_zone1
  network {
    uuid = var.private_subnet01
  }

  user_data = <<-EOF
             #!/bin/bash
              sudo mkfs.ext4 /dev/vdb
              sudo mkfs.ext4 /dev/vdc
              sudo mkfs.ext4 /dev/vdd
              sudo mkfs.ext4 /dev/vde
              sudo mkdir /dynatrace_installation
              sudo mkdir /transaction_storage
              sudo mkdir /long_term_storage
              sudo mkdir /elastic_storage
              sudo mount /dev/vdb /dynatrace_installation
              sudo mount /dev/vdc /transaction_storage
              sudo mount /dev/vdd /long_term_storage
              sudo mount /dev/vde /elastic_storage
              sudo echo '/dev/vdb /dynatrace_installation ext4 defaults 1 2' >> /etc/fstab
              sudo echo '/dev/vdc /transaction_storage ext4 defaults 1 2' >> /etc/fstab
              sudo echo '/dev/vdd /long_term_storage ext4 defaults 1 2' >> /etc/fstab
              sudo echo '/dev/vde /elastic_storage ext4 defaults 1 2' >> /etc/fstab
              EOF
}

resource "opentelekomcloud_compute_instance_v2" "dynatrace_node2" {

  name              = "${var.name}_node_az02"
  image_id          = data.opentelekomcloud_images_image_v2.ecs_vm_image.id
  flavor_id         = var.flavor_id_node
  key_pair          = var.key_name
  security_groups  = [opentelekomcloud_networking_secgroup_v2.dynatrce_node_ssh_ecs_vm_sg.id]
  availability_zone = var.availability_zone2  ## Need to modify to place in different AZ
  network {
    uuid = var.private_subnet02 
  }

  user_data = <<-EOF
             #!/bin/bash
              sudo mkfs.ext4 /dev/vdb
              sudo mkfs.ext4 /dev/vdc
              sudo mkfs.ext4 /dev/vdd
              sudo mkfs.ext4 /dev/vde
              sudo mkdir /dynatrace_installation
              sudo mkdir /transaction_storage
              sudo mkdir /long_term_storage
              sudo mkdir /elastic_storage
              sudo mount /dev/vdb /dynatrace_installation
              sudo mount /dev/vdc /transaction_storage
              sudo mount /dev/vdd /long_term_storage
              sudo mount /dev/vde /elastic_storage
              sudo echo '/dev/vdb /dynatrace_installation ext4 defaults 1 2' >> /etc/fstab
              sudo echo '/dev/vdc /transaction_storage ext4 defaults 1 2' >> /etc/fstab
              sudo echo '/dev/vdd /long_term_storage ext4 defaults 1 2' >> /etc/fstab
              sudo echo '/dev/vde /elastic_storage ext4 defaults 1 2' >> /etc/fstab
              EOF
}

resource "opentelekomcloud_compute_instance_v2" "dynatrace_node3" {

  name              = "${var.name}_node_az03"
  image_id          = data.opentelekomcloud_images_image_v2.ecs_vm_image.id
  flavor_id         = var.flavor_id_node
  key_pair          = var.key_name
  security_groups  = [opentelekomcloud_networking_secgroup_v2.dynatrce_node_ssh_ecs_vm_sg.id]
  availability_zone = var.availability_zone3  ## Need to modify to place in different AZ
  network {
    uuid = var.private_subnet03 
  }

  user_data = <<-EOF
             #!/bin/bash
              sudo mkfs.ext4 /dev/vdb
              sudo mkfs.ext4 /dev/vdc
              sudo mkfs.ext4 /dev/vdd
              sudo mkfs.ext4 /dev/vde
              sudo mkdir /dynatrace_installation
              sudo mkdir /transaction_storage
              sudo mkdir /long_term_storage
              sudo mkdir /elastic_storage
              sudo mount /dev/vdb /dynatrace_installation
              sudo mount /dev/vdc /transaction_storage
              sudo mount /dev/vdd /long_term_storage
              sudo mount /dev/vde /elastic_storage
              sudo echo '/dev/vdb /dynatrace_installation ext4 defaults 1 2' >> /etc/fstab
              sudo echo '/dev/vdc /transaction_storage ext4 defaults 1 2' >> /etc/fstab
              sudo echo '/dev/vdd /long_term_storage ext4 defaults 1 2' >> /etc/fstab
              sudo echo '/dev/vde /elastic_storage ext4 defaults 1 2' >> /etc/fstab
              EOF
}


## Attaching Volumes to Dynatrace Nodes 

resource "opentelekomcloud_compute_volume_attach_v2" "attachment1_az1" {
  count       = 1
  instance_id = opentelekomcloud_compute_instance_v2.dynatrace_node1.id
  volume_id   = opentelekomcloud_blockstorage_volume_v2.Dyna_install_volume_az1[count.index].id
}

resource "opentelekomcloud_compute_volume_attach_v2" "attachment2_az1" {
  count       = 1
  instance_id = opentelekomcloud_compute_instance_v2.dynatrace_node1.id
  volume_id   = opentelekomcloud_blockstorage_volume_v2.trans_Logs_volume_az1[count.index].id
}

resource "opentelekomcloud_compute_volume_attach_v2" "attachment3_az1" {
  count       = 1
  instance_id = opentelekomcloud_compute_instance_v2.dynatrace_node1.id
  volume_id   = opentelekomcloud_blockstorage_volume_v2.long_term_volume_az1[count.index].id
}

resource "opentelekomcloud_compute_volume_attach_v2" "attachment4_az1" {
  count       = 1
  instance_id = opentelekomcloud_compute_instance_v2.dynatrace_node1.id
  volume_id   = opentelekomcloud_blockstorage_volume_v2.elastic_storage_volume_az1[count.index].id
}

resource "opentelekomcloud_compute_volume_attach_v2" "attachment1_az2" {
  count       = 1
  instance_id = opentelekomcloud_compute_instance_v2.dynatrace_node2.id
  volume_id   = opentelekomcloud_blockstorage_volume_v2.Dyna_install_volume_az2[count.index].id
}

resource "opentelekomcloud_compute_volume_attach_v2" "attachment2_az2" {
  count       = 1
  instance_id = opentelekomcloud_compute_instance_v2.dynatrace_node2.id
  volume_id   = opentelekomcloud_blockstorage_volume_v2.trans_Logs_volume_az2[count.index].id
}

resource "opentelekomcloud_compute_volume_attach_v2" "attachment3_az2" {
  count       = 1
  instance_id = opentelekomcloud_compute_instance_v2.dynatrace_node2.id
  volume_id   = opentelekomcloud_blockstorage_volume_v2.long_term_volume_az2[count.index].id
}

resource "opentelekomcloud_compute_volume_attach_v2" "attachment4_az2" {
  count       = 1
  instance_id = opentelekomcloud_compute_instance_v2.dynatrace_node2.id
  volume_id   = opentelekomcloud_blockstorage_volume_v2.elastic_storage_volume_az2[count.index].id
}

resource "opentelekomcloud_compute_volume_attach_v2" "attachment1_az3" {
  count       = 1
  instance_id = opentelekomcloud_compute_instance_v2.dynatrace_node3.id
  volume_id   = opentelekomcloud_blockstorage_volume_v2.Dyna_install_volume_az3[count.index].id
}

resource "opentelekomcloud_compute_volume_attach_v2" "attachment2_az3" {
  count       = 1
  instance_id = opentelekomcloud_compute_instance_v2.dynatrace_node3.id
  volume_id   = opentelekomcloud_blockstorage_volume_v2.trans_Logs_volume_az3[count.index].id
}

resource "opentelekomcloud_compute_volume_attach_v2" "attachment3_az3" {
  count       = 1
  instance_id = opentelekomcloud_compute_instance_v2.dynatrace_node3.id
  volume_id   = opentelekomcloud_blockstorage_volume_v2.long_term_volume_az3[count.index].id
}

resource "opentelekomcloud_compute_volume_attach_v2" "attachment4_az3" {
  count       = 1
  instance_id = opentelekomcloud_compute_instance_v2.dynatrace_node3.id
  volume_id   = opentelekomcloud_blockstorage_volume_v2.elastic_storage_volume_az3[count.index].id
}