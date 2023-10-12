
output "dynatrace_node1_private_address" {
  value = opentelekomcloud_compute_instance_v2.dynatrace_node1.access_ip_v4
}

output "dynatrace_node2_private_address" {
  value = opentelekomcloud_compute_instance_v2.dynatrace_node2.access_ip_v4
}

output "dynatrace_node3_private_address" {
  value = opentelekomcloud_compute_instance_v2.dynatrace_node3.access_ip_v4
}

output "cluster_active_gate" {
  value = opentelekomcloud_compute_instance_v2.clusteractivegate_node1.access_ip_v4
}