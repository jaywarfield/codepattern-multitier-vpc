# Automate deployment of Multitier Web App in IBM VPC

## Overview

Automate infrastructure deployment and configuration for [IBM VPC](https://cloud.ibm.com/docs/vpc) with [Schematics](https://cloud.ibm.com/docs/schematics?topic=schematics-getting-started):
- [Schematics Workspace](https://cloud.ibm.com/docs/schematics?topic=schematics-workspace-setup) [(Terraform)](https://www.terraform.io/)
- [Schematics Action](https://cloud.ibm.com/docs/schematics?topic=schematics-create-playbooks) [(Ansible)](https://www.redhat.com/en/technologies/management/ansible)
  
A [multitier](https://en.wikipedia.org/wiki/Multitier_architecture) architecture leverages VPC for public cloud isolation that separates the web/application and data tiers by deploying VSIs into isolated subnets across different availability zones with network isolation defined using Security Groups and ACLs. Other features include Global DDOS, Global Load Balancing, VPN-as-a-Service and Bastion to estabilish remote secure connectivity between onprem and VPC, and SysDig and LogDNA for infrastructure and application monitoring. [WordPress](https://wordpress.com), a popular web, blog and e-commerce platform, is deployed into two different available zones. [MySQL](https://www.mysql.com), a typical open source database, is deployed on multiple database servers with a source/replica data replication strategy across two availability zones and installed on a [LAMP stack](https;//en.wikipedia.org/wiki/LAMP). [Nginx](https://www.nginx.com/) and [Nginx Unit](https://www.nginx.com/products/nginx-unit/) are used as the Web Server and Application Servers respectively.

High Level Architecture

- Infrastructure
  - Public Cloud isolation using a VPC
  - RFC1918 private bring-your-own-IP addresses
  - Application and data layers deployed on isolated subnets accross different availability zones
  - Network isolation defined logically using Security Groups and ACLs
  - Global DDOS and Global Load Balancing 
  - Bastion and/or VPN-as-a-Service to establish remote secure connectivity between on-pream and the VPC
  - SysDig & LogDNA for infrastructure and application monitoring
  - HTTP only for simplicity

- Application
  - A horizontally scaleable web application deployed into a two different availability zones
  - Multiple database servers across two availability zones
  - A source/replica data replication strategy across availability zones

## Architecture

### Infrastructure Architecture
[Infrastructure](docs/images/webappvpc-infrastructure-architecture.svg)

### Application Architecture
[Application](docs/images/application-data-flow.png)

## Instructions

### Setup Instructions
[Setup](docs/setup.md)

### Usage Instructions
[Usage](docs/usage.md)
