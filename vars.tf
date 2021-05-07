# Generated by tabular-terraform
variable "vpc-name" {
description = "Define vpc"
default = "webappvpc"
}
variable "resource-group" {
description = "Define general resource group"
default = "webapprg"
}
variable "domain" {
description = "Define domain name"
default = "mydomain.com"
}
variable "cis-instance-name" {
description = "Define CIS instance name"
default = "mydomain.com"
}
variable "dns-name" {
description = "Define dns name"
default = "www."
}
variable "region" {
description = "Define region"
default = "us-south"
}
variable "zone1" {
description = "Define zone1"
default = "us-south-1"
}
variable "zone2" {
description = "Define zone2"
default = "us-south-2"
}
variable "address-prefix-vpc" {
description = "Define cidr block for vpc"
default = "172.21.0.0/20"
}
variable "address-prefix1" {
description = "Define cidr block for vpc prefix1"
default = "172.21.0.0/21"
}
variable "address-prefix2" {
description = "Define cidr block for vpc prefix2"
default = "172.21.8.0/21"
}
variable "webapptier-subnet-zone1" {
description = "Define webapptier subnet cidr for zone1"
default = "172.21.0.0/24"
}
variable "webapptier-subnet-zone2" {
description = "Define webapptier subnet cidr for zone2"
default = "172.21.8.0/24"
}
variable "dbtier-subnet-zone1" {
description = "Define dbtier subnet cidr for zone1"
default = "172.21.1.0/24"
}
variable "dbtier-subnet-zone2" {
description = "Define dbtier subnet cidr for zone2"
default = "172.21.9.0/24"
}
variable "ssh-public-key" {
description = "Define ssh key for compute instances"
}
variable "image" {
description = "Define OS image for compute instances"
default = "r006-ed3f775f-ad7e-4e37-ae62-7199b4988b00"
}
variable "webappserver-name" {
description = "Define webapp instance name"
default = "webapp%02d"
}
variable "webappserver-count" {
description = "Define webapp instance count"
default = 1
}
variable "profile-webappserver" {
description = "Define webapp instance profile"
default = "cx2-2x4"
}
variable "dbserver-name" {
description = "Define db instance name"
default = "mysql%02d"
}
variable "dbserver-count" {
description = "Define db instance count"
default = "1"
}
variable "profile-dbserver" {
description = "Define db instance profile"
default = "bx2-4x16"
}
variable "bastionserver-name" {
description = "Define bastion instance name"
default = "bastion"
}
variable "profile-bastionserver" {
description = "Define bastion instance profile"
default = "cx2-2x4"
}
variable "webapptier-lb-connections" {
description = "Define number of LB connections in webapptier"
default = "2000"
}
variable "webapptier-lb-algorithm" {
description = "Define  algorithm used for LB in webapptier"
default = "round_robin"
}
variable "onprem-cidr" {
description = "Define vpn onprem cidr"
default = "192.168.248.0/24"
}