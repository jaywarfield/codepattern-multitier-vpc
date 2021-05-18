# Generated by Tabular Terraform
resource "local_file" "addhosts" {
filename = "/tmp/.schematics/addhosts.sh"
content = <<EOT
ssh-add ~/.ssh/id_rsa
ssh-keyscan -H ${module.backend.dbserver-zone1-ip} >> ~/.ssh/known_hosts
ssh-keyscan -H ${module.backend.dbserver-zone2-ip} >> ~/.ssh/known_hosts
ssh-keyscan -H ${module.frontend.webappserver-zone1-ip} >> ~/.ssh/known_hosts
ssh-keyscan -H ${module.frontend.webappserver-zone2-ip} >> ~/.ssh/known_hosts
ssh-keyscan -H ${module.bastion.bastionserver-zone1-fip} >> ~/.ssh/known_hosts
ssh-keyscan -H ${module.bastion.bastionserver-zone2-fip} >> ~/.ssh/known_hosts
EOT
}
