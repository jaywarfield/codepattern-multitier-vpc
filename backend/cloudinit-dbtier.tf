data "template_cloudinit_config" "cloudinit-dbtier" {
  base64_encode = false
  gzip          = false

  part {
    content = <<EOF
#cloud-config
apt:
  primary:
    - arches: [default]
      uri:  http://mirrors.adn.networklayer.com/ubuntu
package_update: true
package_upgrade: true
packages:
 - locales
 - build-essential
 - acl
 - ntp
 - htop
 - git
 - pip
 - supervisor
 - mysql-client
 - mysql-server

power_state:
 mode: reboot
 message: Rebooting server now.
 timeout: 30
 condition: True

 
EOF

  }
}

