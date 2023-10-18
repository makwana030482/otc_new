## Creating EIP for Load balancer

resource "opentelekomcloud_vpc_eip_v1" "ingress_eip" {
  bandwidth {
    charge_mode = "traffic"
    name        = "${var.name}-ingress-bandwidth"
    share_type  = "PER"
    size        = var.bandwidth
  }
  publicip {
    type    = "5_bgp"
    port_id = opentelekomcloud_lb_loadbalancer_v2.elb.vip_port_id
  }
}

## Creating Application Load balancer

resource "opentelekomcloud_lb_loadbalancer_v2" "elb" {
  name          = "elb_${var.name}"
  description   = "ELB for project ${var.name})"
  vip_subnet_id = var.public_subnet01
}
