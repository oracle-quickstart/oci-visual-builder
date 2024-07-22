## Consumer Subnet
variable "compartment_ocid" {
  type = string
}

variable "vcn_display_name" {
  default = "Consumer-vcn-1"
  type = string
}

variable "vcn_dns_label" {
  default = "consumervcn1"
  type = string
}

variable "vcn_cidr" {
  default = "10.0.0.0/16"
}

variable "create_public_load_balancer" {
  default = false
  type = bool
  description = "Create a Public Load Balancer to access the private Visual Builder instance from public subnet"
}

variable "private_endpoint_ip" {
  default = null
  type = string
  description = "The private endpoint ip used during creation of Visual Builder instance, this is used to configure the backend of the load balancer"
}

variable "load_balancer_name" {
  type = string
  default = "Customer-public-load-balancer-1"
}