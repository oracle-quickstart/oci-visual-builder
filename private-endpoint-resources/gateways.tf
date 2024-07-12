## Consumer IGW
resource oci_core_internet_gateway consumer_igw {
  vcn_id = oci_core_vcn.consumer_vcn.id
  compartment_id = var.compartment_ocid
  display_name = "IGW"
}

## Consumer NATGW
resource oci_core_nat_gateway consumer_natgw {
  vcn_id = oci_core_vcn.consumer_vcn.id
  compartment_id = var.compartment_ocid
  display_name = "NATGW"
}


## Consumer SERVICEGW
resource oci_core_service_gateway consumer_sgw {
  vcn_id = oci_core_vcn.consumer_vcn.id
  compartment_id = var.compartment_ocid
  services {
    service_id = data.oci_core_services.core_services.services.0.id
  }
  display_name = "SGW"
}