# Generated by tabular-terraform
output "dbserver-zone1-id" {
value = ibm_is_instance.dbserver-zone1[0].id
}
output "dbserver-zone2-id" {
value = ibm_is_instance.dbserver-zone2[0].id
}
output "dbserver-zone1-ip" {
value = ibm_is_instance.dbserver-zone1[0].primary_network_interface[0].primary_ipv4_address
}
output "dbserver-zone2-ip" {
value = ibm_is_instance.dbserver-zone2[0].primary_network_interface[0].primary_ipv4_address
}