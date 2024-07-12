## Consumer VCN
resource oci_core_vcn consumer_vcn {
  cidr_blocks = [
    var.vcn_cidr,
  ]
  compartment_id = var.compartment_ocid
  display_name = var.vcn_display_name
  dns_label    = var.vcn_dns_label
  ipv6private_cidr_blocks = [
  ]
}

## Public Route Table
resource oci_core_route_table consumer_public_route_table {
  compartment_id = var.compartment_ocid
  display_name = "Route Table for Consumer-public-subnet"
  route_rules {
    destination = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.consumer_igw.id
    description       = "DEFAULT ROUTE TO INET"
  }
  vcn_id = oci_core_vcn.consumer_vcn.id
}

## Private Route Table
resource oci_core_route_table consumer_private_route_table {
  compartment_id = var.compartment_ocid
  display_name = "Route Table for Consumer-private-subnet"
  route_rules {
    description       = "ALL SERVICES"
    destination       = data.oci_core_services.core_services.services[0]["cidr_block"]
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = oci_core_service_gateway.consumer_sgw.id
  }
  route_rules {
    destination = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.consumer_natgw.id
    description       = "ROUTE TO NATGW"
  }
  vcn_id = oci_core_vcn.consumer_vcn.id
}