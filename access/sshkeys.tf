# Generated by tabular-terraform
# Define ssh key
resource "ibm_is_ssh_key" "sshkey" {
name = "wordpress-demo-key"
public_key = file(var.ssh-public-key)
resource_group = ibm_resource_group.group.id
}
