#All PHX Services in Oracle Services Network
data "oci_core_services" "core_services" {
  filter {
    name = "name"
    values = [".*Oracle.*Services.*Network"]
    regex  = true
  }
}
