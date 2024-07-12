locals {
  public_subnet_cidr = cidrsubnet(var.vcn_cidr, 1, 0) # 10.0.0.0/17
  private_subnet_cidr = cidrsubnet(var.vcn_cidr, 1, 1) # 10.0.128.0/17

  ## LBR related constants
  tcp = "TCP"
  interval_10000 = "10000"
  timeout_3000 = "3000"
  retries_3 = "3"
  vb_pe_backend_set_name = "vb-pe-backend-set"
  policy_weighted_rr = "ROUND_ROBIN"
  backend_weight_1 = "1"
  vb_pe_listener_name = "vb-pe-listener"
  port_443 = "443"
  listener_timeout_310 = "310"
  boolean_create_public_load_balancer = try(tobool(var.create_public_load_balancer), false)
}

