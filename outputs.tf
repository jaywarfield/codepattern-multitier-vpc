# Generated by tabular-terraform
output "app_name" {
  value = "${var.dns-name}${var.domain}"
}
output "source_db" {
  value = module.backend.dbserver-zone1-ip
}
output "replica_db" {
  value = module.backend.dbserver-zone2-ip
}
output "webappserver1" {
  value = module.frontend.webappserver-zone1-ip
}
output "webappserver2" {
  value = module.frontend.webappserver-zone2-ip
}
output "bastionserver1" {
  value = module.bastion.bastionserver-zone1-fip
}
output "bastionserver2" {
  value = module.bastion.bastionserver-zone2-fip
}
output "ssh-bastionserver1" {
  value = "ssh root@${module.bastion.bastionserver-zone1-fip}"
}
output "ssh-webappserver1" {
  value = "ssh -o ProxyJump=root@${module.bastion.bastionserver-zone1-fip} root@${module.frontend.webappserver-zone1-ip}"
}
output "ssh-sourcedb" {
  value = "ssh -o ProxyJump=root@${module.bastion.bastionserver-zone1-fip} root@${module.backend.dbserver-zone1-ip}"
}
output "ssh-bastionserver2" {
  value = "ssh root@${module.bastion.bastionserver-zone2-fip}"
}
output "ssh-webappserver2" {
  value = "ssh -o ProxyJump=root@${module.bastion.bastionserver-zone2-fip} root@${module.frontend.webappserver-zone2-ip}"
}
output "ssh-replicadb" {
  value = "ssh -o ProxyJump=root@${module.bastion.bastionserver-zone2-fip} root@${module.backend.dbserver-zone2-ip}"
}
