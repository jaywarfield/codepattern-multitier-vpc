# Automate deployment of a Multitier Web App in IBM Virtual Private Cloud

## Purpose

Automate infrastructure deployment and configuration for [IBM VPC](https://cloud.ibm.com/docs/vpc) utilizing:
- [Terraform](https://www.terraform.io/)
- [Schematics](https://cloud.ibm.com/docs/schematics?topic=schematics-getting-started)
- [Actions](https://cloud.ibm.com/docs/schematics?topic=schematics-create-playbooks) [(Ansible)](https://www.redhat.com/en/technologies/management/ansible)
  
A [multitier](https://en.wikipedia.org/wiki/Multitier_architecture) architecture leverages VPC for public cloud isolation that separates the web/application and data tiers by deploying VSIs into isolated subnets across different availability zones with network isolation defined using Security Groups and ACLs. Other features include Global DDOS, Global Load Balancing, VPN-as-a-Service and Bastion to estabilish remote secure connectivity between onprem and VPC, and SysDig and LogDNA for infrastructure and application monitoring. [WordPress](https://wordpress.com), a popular web, blog and e-commerce platform, is deployed into two different available zones. [MySQL](https://www.mysql.com), a typical open source database, is deployed on multiple database servers with a source/replica data replication strategy across two availability zones and installed on a [LAMP stack](https;//en.wikipedia.org/wiki/LAMP). [Nginx](https://www.nginx.com/) and [Nginx Unit](https://www.nginx.com/products/nginx-unit/) are used as the Web Server and Application Servers respectively.

High Level Architecture

1. Infrastructure
  - Public Cloud isolation using a VPC
  - RFC1918 private bring-your-own-IP addresses
  - Application and data layers deployed on isolated subnets accross different availability zones
  - Network isolation defined logically using Security Groups and ACLs
  - Global DDOS and Global Load Balancing 
  - Bastion and/or VPN-as-a-Service to establish remote secure connectivity between on-pream and the VPC
  - SysDig & LogDNA for infrastructure and application monitoring
  - HTTP only for simplicity
  - Cloud-Init is used to install required packages and initial setup tasks
  - Ansible is used for post-configuration tasks.

2. Application
  - A horizontally scaleable web application deployed into a two different availability zones
  - Multiple database servers across two availability zones
  - A source/replica data replication strategy across availability zones
  - MySQL database server implemented on infrastructure versus as-a-service to illustrate the ability to define logical tiers between subnets as well as to show the ability to automate deployment and configuration tasks

## VPC Architecture
The IBM VPC architecture of the solution showing public isolation for both Application (through a Load Balancer) and data.

### Infrastructure Architecture
![3tier Web App - Infrastructure](/docs/images/infrastructure-architecture.png)

### Application Architecture
![3tier Web App - Application](docs/images/application-data-flow.png)

#### *Not depicted in drawings*
- VPNaaS or any VPN Connections
- Cloud Internet Services (GLB function or DNS)
- Management Flows

## VPC Functional Coverage
| Function | Demonstrated | Notes |
| -------- | ------ | ----- |
| VPC | :white_check_mark: | |
| Terraform | :white_check_mark: | |
| Ansible Workspaces | :white_check_mark: | |
| Ansible Actions | :white_check_mark: | |
| Ansible Inventories| :white_check_mark: | |
| Resource Groups | :white_check_mark: | Assigned, but assumed to be created already. |
| Access Groups | :white_check_mark: | Inherited, but assumed to already be created |
| Subnets | :white_check_mark: | |
| Private (RFC1918) IP (BYOIP) | :white_check_mark: | |
| ACLs | :white_check_mark: | |
| Security Groups | :white_check_mark: | |
| Virtual Server Instance (VSI) | :white_check_mark: | |
| Cloud-init | :white_check_mark: | Package installation and configuration beyond base OS image. |
| Secondary Storage |  | Not used in this scenario |
| Multiple Network Interfaces in VSI | :white_check_mark: | |
| Load Balancer as a Service | :white_check_mark: | Public Only |
| Floating IPv4 |  | Not required for workload. |
| Public Gateway | :white_check_mark: |  |
| VPNaaS | :white_check_mark: | |
| Cloud Internet Services (CIS) | :white_check_mark: | GLB configured for illustrative purposes with DDOS proxy |
| IBM Cloud Monitoring with Sysdig | :white_check_mark: | Public endpoint used |
| IBM Cloud Log Analysis with LogDNA | :white_check_mark: | Public endpoint Used

### System Requirements

#### Operating system

| Tier  | Operating system |
| ------------- | ------------- |
| Web Server & Application | Ubuntu 18.04  |
| Data  | Ubuntu 18.04  |

#### Hardware

| Tier | Type | Profile |
| ------------- | ------------- | ------- |
| Web Server and Application  |  VSI | cx2-2x4 |
| Data| VSI  | bx2-4x16 |

#### Runtime Services

| Service Name | Demonstrated | Notes
| ------------ | ------------ | -----
| Cloud Internet Services (CIS) GLB | :white_check_mark: | GLB configured for illustrative purposes with DDOS proxy.  Alternatively a CNAME could have been used to publish the application URL. |
| IBM Cloud Monitoring with Sysdig | :white_check_mark: | Public endpoint used |
| IBM Cloud Log Analysis with LogDNA | :white_check_mark: | Public endpoint Used |
| IBM Cloud Databases | | A VSI based instance of MySQL was chosen instead of a Database-as-a-Service capability to illustrate both the ability to create logial network constructs and security and the ability to use Terraform and Ansible to configure the environment.|

## Documented Steps

### Prerequisites

The following software needs to be installed:
1. Terraform 0.12 or greater
2. [IBM Cloud Terraform Provider version 1.10.0](https://github.com/IBM-Cloud/terraform-provider-ibm) 
2. Ansible 2.8

The following must be configured prior to running Terraform / Ansible
1. A Public SSH key as described in [SSH Keys](https://cloud.ibm.com/docs/vpc-on-classic-vsi?topic=vpc-on-classic-vsi-ssh-keys#ssh-keys).
2. A resource group exists and is referenced in configuration as described in [Managing resource groups](https://cloud.ibm.com/docs/resources?topic=resources-rgs#rgs)
3. User permissions and the required access as described in [Managing user permissions for VPC resources](https://cloud.ibm.com/docs/vpc-on-classic?topic=vpc-on-classic-managing-user-permissions-for-vpc-resources)

### Deploy VPC Infrastructure using Terraform & Ansible

1. [Deploy Infrastructure using Terraform](docs/terraform.md)
2. [Establish site-to-site VPN](docs/vpn.md)
3. [Configure Application Layer using Ansible](docs/ansible.md)


## Additional Documentation Provided

Useful links for Terraform and Ansible

[Terraform Documentation](https://www.terraform.io/docs/index.html)

[The IBM Cloud Provider for Terraform Documentation](https://ibm-cloud.github.io/tf-ibm-docs/v0.17.1/)

[Ansible Documentation](https://docs.ansible.com/ansible/latest/index.html)


Useful links for IBM Cloud VPC documentation.

[Getting started with IBM Cloud Virtual Private Cloud](https://cloud.ibm.com/docs/vpc-on-classic?topic=vpc-on-classic-getting-started)

[Assigning role-based access to VPC resources](https://cloud.ibm.com/docs/vpc-on-classic?topic=vpc-on-classic-assigning-role-based-access-to-vpc-resources)

[IBM Cloud CLI for VPC Reference](https://cloud.ibm.com/docs/vpc-on-classic?topic=vpc-infrastructure-cli-plugin-vpc-reference)

[VPC API](https://cloud.ibm.com/apidocs/vpc-on-classic)

[IBM Cloud Virtual Private Cloud API error messages](https://cloud.ibm.com/docs/vpc-on-classic?topic=vpc-on-classic-rias-error-messages)

