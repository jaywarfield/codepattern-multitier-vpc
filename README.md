# Automate deployment of Multitier Web App in IBM VPC

## Overview

Automate infrastructure deployment and configuration for [IBM VPC](https://cloud.ibm.com/docs/vpc) with [IBM Schematics](https://cloud.ibm.com/docs/schematics?topic=schematics-getting-started):
- [Schematics Workspace](https://cloud.ibm.com/docs/schematics?topic=schematics-workspace-setup) [(Terraform)](https://www.terraform.io/)
- [Schematics Action](https://cloud.ibm.com/docs/schematics?topic=schematics-create-playbooks) [(Ansible)](https://www.redhat.com/en/technologies/management/ansible)
  
A [multitier](https://www.ibm.com/cloud/learn/three-tier-architecture) architecture leverages VPC for public cloud isolation that separates the web/application and data tiers by deploying VSIs into isolated subnets across different availability zones with network isolation defined using Security Groups and ACLs. 

Infrastructure features:

- VPC public cloud isolation.
- Logical network isolation using Security Groups and ACLs.
- Layers on isolated subnets across zones.
- RFC1918 private bring-your-own-IP addresses.
- Global DDOS and Global Load Balancing.
- Bastion and VPN for secure connectivity between on-premise and VPC.
- SysDig and LogDNA for infrastructure and application monitoring. 

Application features:

- [LAMP stack](https://www.ibm.com/cloud/learn/lamp-stack-explained) with Linux, MySQL, and PHP.
- [NGINX](https://www.nginx.com/) is used as the Web Server.
- [NGINX Unit](https://www.nginx.com/products/nginx-unit/) is used as the Application Server.
- [WordPress](https://wordpress.com) (popular web, blog and e-commerce platform) demonstrates horizontal scalability across zones.
- [MySQL](https://www.mysql.com) (typical open source database) demonstrates multiple database servers and replication strategy across zones.

## Architecture

![Architecture](docs/images/webappvpc-architecture.svg)

## Instructions

![Setup](docs/setup.md)

![Usage](docs/usage.md)
