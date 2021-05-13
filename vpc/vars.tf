# Generated by Tabular Terraform
variable "vpc-name" {
description = "Define vpc"
}
variable "resource-group" {
description = "Define resource group"
}
variable "region" {
description = "Define region"
}
variable "zone1" {
description = "Define zone1"
}
variable "zone2" {
description = "Define zone2"
}
variable "webapptier-subnet-zone1" {
description = "Define webapptier subnet cidr for zone1"
}
variable "webapptier-subnet-zone2" {
description = "Define webapptier subnet cidr for zone2"
}
variable "dbtier-subnet-zone1" {
description = "Define dbtier subnet cidr for zone1"
}
variable "dbtier-subnet-zone2" {
description = "Define dbtier subnet cidr for zone2"
}
variable "address-prefix-vpc" {
description = "Define cidr block for vpc"
}
variable "address-prefix1" {
description = "Define cidr block for vpc prefix1"
}
variable "address-prefix2" {
description = "Define cidr block for vpc prefix2"
}
variable "onprem-cidr" {
description = "Define vpn onprem cidr"
}
variable "group-id" {
description = "Get resource group id"
}
variable "webapptier-acl-id" {
description = "Get webapptier acl id"
}
variable "dbtier-acl-id" {
description = "Get dbtier acl id"
}
