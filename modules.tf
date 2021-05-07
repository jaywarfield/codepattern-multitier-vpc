# Generated by tabular-terraform
module "access" {
source = "./access"
vpc-name = var.vpc-name
resource-group = var.resource-group
ssh-public-key = var.ssh-public-key
webapptier-subnet-zone1 = var.webapptier-subnet-zone1
webapptier-subnet-zone2 = var.webapptier-subnet-zone2
dbtier-subnet-zone1 = var.dbtier-subnet-zone1
dbtier-subnet-zone2 = var.dbtier-subnet-zone2
address-prefix-vpc = var.address-prefix-vpc
onprem-cidr = var.onprem-cidr
vpc-id = module.vpc.vpc-id
}
module "vpc" {
source = "./vpc"
vpc-name = var.vpc-name
resource-group = var.resource-group
region = var.region
zone1 = var.zone1
zone2 = var.zone2
address-prefix-vpc = var.address-prefix-vpc
address-prefix1 = var.address-prefix1
address-prefix2 = var.address-prefix2
webapptier-subnet-zone1 = var.webapptier-subnet-zone1
webapptier-subnet-zone2 = var.webapptier-subnet-zone2
dbtier-subnet-zone1 = var.dbtier-subnet-zone1
dbtier-subnet-zone2 = var.dbtier-subnet-zone2
onprem-cidr = var.onprem-cidr
group-id = module.access.group-id
webapptier-acl-id = module.access.webapptier-acl-id
dbtier-acl-id = module.access.dbtier-acl-id
}
module "frontend" {
source = "./frontend"
vpc-name = var.vpc-name
resource-group = var.resource-group
region = var.region
zone1 = var.zone1
zone2 = var.zone2
webapptier-subnet-zone1 = var.webapptier-subnet-zone1
webapptier-subnet-zone2 = var.webapptier-subnet-zone2
webappserver-name = var.webappserver-name
webappserver-count = var.webappserver-count
profile-webappserver = var.profile-webappserver
image = var.image
domain = var.domain
cis-instance-name = var.cis-instance-name
dns-name = var.dns-name
webapptier-lb-connections = var.webapptier-lb-connections
webapptier-lb-algorithm = var.webapptier-lb-algorithm
onprem-cidr = var.onprem-cidr
group-id = module.access.group-id
sshkey-id = module.access.sshkey-id
vpc-id = module.vpc.vpc-id
webapptier-subnet-zone1-id = module.vpc.webapptier-subnet-zone1-id
webapptier-subnet-zone2-id = module.vpc.webapptier-subnet-zone2-id
webapptier-securitygroup-id = module.access.webapptier-securitygroup-id
maintenance-securitygroup-id = module.access.maintenance-securitygroup-id
}
module "backend" {
source = "./backend"
vpc-name = var.vpc-name
resource-group = var.resource-group
region = var.region
zone1 = var.zone1
zone2 = var.zone2
dbtier-subnet-zone1 = var.dbtier-subnet-zone1
dbtier-subnet-zone2 = var.dbtier-subnet-zone2
dbserver-name = var.dbserver-name
dbserver-count = var.dbserver-count
profile-dbserver = var.profile-dbserver
image = var.image
group-id = module.access.group-id
sshkey-id = module.access.sshkey-id
vpc-id = module.vpc.vpc-id
dbtier-subnet-zone1-id = module.vpc.dbtier-subnet-zone1-id
dbtier-subnet-zone2-id = module.vpc.dbtier-subnet-zone2-id
dbtier-securitygroup-id = module.access.dbtier-securitygroup-id
maintenance-securitygroup-id = module.access.maintenance-securitygroup-id
}
module "bastion" {
source = "./bastion"
vpc-name = var.vpc-name
resource-group = var.resource-group
region = var.region
zone1 = var.zone1
zone2 = var.zone2
bastionserver-name = var.bastionserver-name
profile-bastionserver = var.profile-bastionserver
image = var.image
group-id = module.access.group-id
sshkey-id = module.access.sshkey-id
vpc-id = module.vpc.vpc-id
bastion-subnet-zone1-id = module.vpc.bastion-subnet-zone1-id
bastion-subnet-zone2-id = module.vpc.bastion-subnet-zone2-id
bastion-securitygroup-id = module.access.bastion-securitygroup-id
maintenance-securitygroup-id = module.access.maintenance-securitygroup-id
}
module "ansible" {
source = "./ansible"
vpc-name = var.vpc-name
resource-group = var.resource-group
region = var.region
zone1 = var.zone1
zone2 = var.zone2
bastionserver-name = var.bastionserver-name
profile-bastionserver = var.profile-bastionserver
image = var.image
group-id = module.access.group-id
sshkey-id = module.access.sshkey-id
vpc-id = module.vpc.vpc-id
bastion-subnet-zone1-id = module.vpc.bastion-subnet-zone1-id
bastion-subnet-zone2-id = module.vpc.bastion-subnet-zone2-id
bastionserver-zone1-fip = module.bastion.bastionserver-zone1-fip
bastionserver-zone2-fip = module.bastion.bastionserver-zone2-fip
bastion-securitygroup-id = module.access.bastion-securitygroup-id
maintenance-securitygroup-id = module.access.maintenance-securitygroup-id
}
