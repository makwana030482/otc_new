
output "jumphost_address" {
  value = opentelekomcloud_vpc_eip_v1.jumphost_eip.publicip[0].ip_address
}

output "jumphost_private_address" {
  value = opentelekomcloud_compute_instance_v2.jump_host.access_ip_v4
}
