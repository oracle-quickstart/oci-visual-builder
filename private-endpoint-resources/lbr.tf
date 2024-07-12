resource "oci_load_balancer_load_balancer" "public_load_balancer" {
  count = local.boolean_create_public_load_balancer ? 1 : 0
  compartment_id = var.compartment_ocid
  display_name = "Customer-public-load-balancer"
  shape = "flexible"
  shape_details {
    maximum_bandwidth_in_mbps = 10
    minimum_bandwidth_in_mbps = 10
  }
  subnet_ids = [oci_core_subnet.consumer_public_subnet.id]
  is_private = "false"
}

#backend set
resource "oci_load_balancer_backend_set" "public_lb_pe_backend_set" {
  count = local.boolean_create_public_load_balancer ? 1 : 0
  health_checker {
    protocol = local.tcp
    interval_ms = local.interval_10000
    port = local.port_443
    retries = local.retries_3
    timeout_in_millis = local.timeout_3000
  }
  load_balancer_id = oci_load_balancer_load_balancer.public_load_balancer[0].id
  name = local.vb_pe_backend_set_name
  policy = local.policy_weighted_rr
}

# backend
resource "oci_load_balancer_backend" "private_endpoint_backend" {
  count = local.boolean_create_public_load_balancer && var.private_endpoint_ip != null ? 1 : 0
  backendset_name = oci_load_balancer_backend_set.public_lb_pe_backend_set[0].name
  ip_address = var.private_endpoint_ip
  load_balancer_id = oci_load_balancer_load_balancer.public_load_balancer[0].id
  port = local.port_443
  weight = local.backend_weight_1
}

# listener
resource "oci_load_balancer_listener" "private_endpoint_listener" {
  count = local.boolean_create_public_load_balancer ? 1 : 0
  default_backend_set_name = oci_load_balancer_backend_set.public_lb_pe_backend_set[0].name
  load_balancer_id = oci_load_balancer_load_balancer.public_load_balancer[0].id
  name = local.vb_pe_listener_name
  port = local.port_443
  protocol = local.tcp
  rule_set_names = [
    oci_load_balancer_rule_set.rule_set_response_header[0].name,
    oci_load_balancer_rule_set.rule_set_http_header[0].name
  ]
  #Optional
  connection_configuration {
    #Required
    idle_timeout_in_seconds = local.listener_timeout_310
  }
}

resource "oci_load_balancer_rule_set" "rule_set_response_header" {
  count = local.boolean_create_public_load_balancer ? 1 : 0
  load_balancer_id = oci_load_balancer_load_balancer.public_load_balancer[0].id
  name             = "vbpe_pub_access_HSTS"
  items {
    action = "ADD_HTTP_RESPONSE_HEADER"
    header = "Strict-Transport-Security"
    value = "max-age=63072000; includeSubDomains; preload"
  }
}

resource "oci_load_balancer_rule_set" "rule_set_http_header" {
  count = local.boolean_create_public_load_balancer ? 1 : 0
  load_balancer_id = oci_load_balancer_load_balancer.public_load_balancer[0].id
  name             = "vbpe_pub_access_HTTP_HEADER_SIZE"
  items {
    action= "HTTP_HEADER"
    are_invalid_characters_allowed = false
    http_large_header_size_in_kb = 64
  }
}
