## Consumer Public SL
resource oci_core_default_security_list consumer_public_security_list {
  compartment_id = var.compartment_ocid
  display_name = "Security list for Consumer-public-subnet"
  egress_security_rules {
    description = "Egress to private subnet for HTTPS"
    destination      = local.private_subnet_cidr
    destination_type = "CIDR_BLOCK"
    protocol  = "6"
    stateless = "false"
    tcp_options {
      max = "443"
      min = "443"
    }
  }
  ingress_security_rules {
    description = "Access to public subnet with LB for traffic to VB PE"
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "443"
      min = "443"
    }
  }
  manage_default_resource_id = oci_core_vcn.consumer_vcn.default_security_list_id
}


## Consumer Private SL
resource oci_core_security_list consumer_private_security_list {
  compartment_id = var.compartment_ocid
  display_name = "Security list for Consumer-private-subnet"
  egress_security_rules {
    description = "Egress to all ports from private subnet"
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol  = "all"
    stateless = "false"
  }
  ingress_security_rules {
    description = "Access to allow HTTPS on port 443 from public subnet"
    protocol    = "6"
    source      = local.public_subnet_cidr
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "443"
      min = "443"
    }
  }
  ## Same private subnet
  ingress_security_rules {
    description = "Access to allow HTTPS on port 443 from within private subnet"
    protocol    = "6"
    source      = local.private_subnet_cidr
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "443"
      min = "443"
    }
  }
  ingress_security_rules {
    description = "Access to allow ATP on port 1521 and 1522 from within private subnet"
    protocol    = "6"
    source      = local.private_subnet_cidr
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "1522"
      min = "1521"
    }
  }

  vcn_id                     = oci_core_vcn.consumer_vcn.id
}