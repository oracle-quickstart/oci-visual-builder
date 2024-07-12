
resource oci_core_subnet consumer_private_subnet {
  cidr_block     = local.private_subnet_cidr
  compartment_id = var.compartment_ocid
  dhcp_options_id = oci_core_vcn.consumer_vcn.default_dhcp_options_id
  display_name    = "Consumer-private-subnet"
  dns_label       = "privatesubnet"
  ipv6cidr_blocks = [
  ]
  prohibit_internet_ingress  = "true"
  prohibit_public_ip_on_vnic = "true"
  route_table_id             = oci_core_route_table.consumer_private_route_table.id
  security_list_ids = [
    oci_core_security_list.consumer_private_security_list.id,
  ]
  vcn_id = oci_core_vcn.consumer_vcn.id
}


resource oci_core_subnet consumer_public_subnet {
  cidr_block     = local.public_subnet_cidr
  compartment_id = var.compartment_ocid
  dhcp_options_id = oci_core_vcn.consumer_vcn.default_dhcp_options_id
  display_name    = "Consumer-public-subnet"
  dns_label       = "publicsubnet"
  ipv6cidr_blocks = [
  ]
  prohibit_internet_ingress  = "false"
  prohibit_public_ip_on_vnic = "false"
  route_table_id             = oci_core_route_table.consumer_public_route_table.id
  security_list_ids = [
    oci_core_vcn.consumer_vcn.default_security_list_id,
  ]
  vcn_id = oci_core_vcn.consumer_vcn.id
}