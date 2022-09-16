data "template_cloudinit_config" "cloudinit-webapptier" {
  base64_encode = false
  gzip          = false

  part {
    content = <<EOF
#cloud-config
bootcmd:
  # Install libssl version required by nginx unit missing in Ubuntu 20.04.
  # Note: Fix for error libssl1.0.0 (>= 1.0.0) is not installable.
  # Note: bootcmd executes before packages whereas runcmd executes after.
  # echo "deb http://security.ubuntu.com/ubuntu bionic-security main" | sudo tee -a /etc/apt/sources.list.d/bionic.list
  # apt update
  # apt-cache policy libssl1.0-dev
  # apt-get install libssl1.0-dev
  # Create Wordpress directory
  - mkdir /var/www
  - chown www-data:www-data /var/www
  - chmod 0775 /var/www

package_update: true
package_upgrade: true
packages:
#- mysql-client
 - mysql
 - nginx
 - php
 - php-fpm
# - php-mysqlnd
 - unit
 - unit-dev
 - unit-jsc-common
 - unit-jsc8
 - unit-php

runcmd:
 - /bin/systemctl enable nginx
 - /bin/systemctl enable php-fpm
 - /bin/firewall-cmd --add-port=80/tcp --permanant

power_state:
 mode: reboot
 message: Rebooting server now.
 timeout: 30
 condition: True
 
EOF

  }
}
