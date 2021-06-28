# Generated by Tabular Terraform
# Create instances in db subnet in zone1
resource "ibm_is_instance" "dbserver-zone1" {
  name    = "${format(var.dbserver-name, count.index + 1)}-${var.zone1}"
  vpc     = var.vpc-id
  zone    = var.zone1
  profile = var.profile-dbserver
  image   = var.image
  boot_volume {
    name = "dbserver-zone1-boot"
  }
  keys = [var.sshkey-id]
  primary_network_interface {
    name            = "dbserver-zone1-primary"
    subnet          = var.dbtier-subnet-zone1-id
    security_groups = [var.dbtier-securitygroup-id, var.maintenance-securitygroup-id]
  }
  user_data      = data.template_cloudinit_config.cloudinit-dbtier.rendered
  resource_group = var.group-id
  count          = var.dbserver-count
}
# Create instances in db subnet in zone2
resource "ibm_is_instance" "dbserver-zone2" {
  name    = "${format(var.dbserver-name, count.index + 1)}-${var.zone2}"
  vpc     = var.vpc-id
  zone    = var.zone2
  profile = var.profile-dbserver
  image   = var.image
  boot_volume {
    name = "dbserver-zone2-boot"
  }
  keys = [var.sshkey-id]
  primary_network_interface {
    name            = "dbserver-zone2-primary"
    subnet          = var.dbtier-subnet-zone2-id
    security_groups = [var.dbtier-securitygroup-id, var.maintenance-securitygroup-id]
  }
  user_data      = data.template_cloudinit_config.cloudinit-dbtier.rendered
  resource_group = var.group-id
  count          = var.dbserver-count
}
