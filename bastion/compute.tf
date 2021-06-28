# Generated by Tabular Terraform
# Create bastion instance in zone1
resource "ibm_is_instance" "bastionserver-zone1" {
  name    = "${var.bastionserver-name}-${var.zone1}"
  vpc     = var.vpc-id
  zone    = var.zone1
  profile = var.profile-bastionserver
  image   = var.image
  boot_volume {
    name = "bastionserver-zone1-boot"
  }
  keys = [var.sshkey-id]
  primary_network_interface {
    name            = "bastionserver-zone1-primary"
    subnet          = var.bastion-subnet-zone1-id
    security_groups = [var.bastion-securitygroup-id]
  }
  resource_group = var.group-id
}
# Create bastion instance in zone2
resource "ibm_is_instance" "bastionserver-zone2" {
  name    = "${var.bastionserver-name}-${var.zone2}"
  vpc     = var.vpc-id
  zone    = var.zone2
  profile = var.profile-bastionserver
  image   = var.image
  boot_volume {
    name = "bastionserver-zone2-boot"
  }
  keys = [var.sshkey-id]
  primary_network_interface {
    name            = "bastionserver-zone2-primary"
    subnet          = var.bastion-subnet-zone2-id
    security_groups = [var.bastion-securitygroup-id]
  }
  resource_group = var.group-id
}
