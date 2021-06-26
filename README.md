# Automate deployment of Multitier Web App in IBM VPC

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

2. Application
  - A horizontally scaleable web application deployed into a two different availability zones
  - Multiple database servers across two availability zones
  - A source/replica data replication strategy across availability zones

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
| Resource Groups | :white_check_mark: | |
| Access Groups | :white_check_mark: | Inherited, but assumed to already be created |
| Subnets | :white_check_mark: | |
| Private (RFC1918) IP (BYOIP) | :white_check_mark: | |
| ACLs | :white_check_mark: | |
| Security Groups | :white_check_mark: | |
| Virtual Server Instance (VSI) | :white_check_mark: | |
| Cloud-Init | :white_check_mark: | Package installation and configuration beyond base OS image |
| Ansible | :white_check_mark: | Post configuration tasks |
| Secondary Storage |  | Not used in this scenario |
| Multiple Network Interfaces in VSI | :white_check_mark: | |
| Load Balancer as a Service | :white_check_mark: | Public Only |
| Floating IPv4 |  | Not required for workload |
| Public Gateway | :white_check_mark: |  |
| VPNaaS | :white_check_mark: | |
| Cloud Internet Services (CIS) | :white_check_mark: | GLB configured for illustrative purposes with DDOS proxy |
| IBM Cloud Monitoring with Sysdig | :white_check_mark: | Public endpoint used |
| IBM Cloud Log Analysis with LogDNA | :white_check_mark: | Public endpoint Used

### System Requirements

#### Operating system

| Tier  | Operating system |
| ------------- | ------------- |
| Web Server & Application | Ubuntu 20.04  |
| Data  | Ubuntu 20.04  |

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
| IBM Cloud Databases | | A VSI based instance of MySQL was chosen instead of a Database-as-a-Service capability to illustrate the ability to create logical network constructs and security, nd the ability to use Terraform and Ansible to configure the environment. |

## Action Variables

| Key | Value | Sensitive |
| ---------- | -------- | ----------- |
| dbpassword | securepassw0rd | | Yes |
| logdna_key | 143c30a06ac6dfae03b3a84259bf1b9e | | Yes |
| sysdig_key | 55e7f496-af78-4e0d-89f7-fa040e259ebd | | Yes |
| app_name | (website) | | No |
| source_db | 172.21.1.4 | | No |
| replica_db | 172.21.9.4 | | No |

## Instructions

### Preliminary

1. Make sure that you have the required [IAM permissions](https://cloud.ibm.com/docs/vpc?topic=vpc-managing-user-permissions-for-vpc-resources) to create and work with VPC infrastructure and [Schematics permissions](https://cloud.ibm.com/docs/schematics?topic=schematics-access) to create the workspace and deploy resources.

2. Generate an [SSH key](https://cloud.ibm.com/docs/vpc?topic=vpc-ssh-keys). The SSH key is required to access the provisioned VPC virtual server instances via the bastion host. After you have created your SSH key, make sure to upload this SSH key to your [account](https://cloud.ibm.com/docs/vpc-on-classic-vsi?topic=vpc-on-classic-vsi-managing-ssh-keys#managing-ssh-keys-with-ibm-cloud-console) in the VPC region and resource group where you want to deploy this example.

### Workspace

1. On **Schematics** main page in IBM Cloud menu:

- Select Workspaces
- Select **Create workspace**   
- Enter a name for your workspace   
- Select **Create** to create your workspace

2. On **Settings** page in your workspace:

- Enter the URL of this example in the Github repository
- Select the Terraform version: Terraform 0.14
- Select **Save template information**
- In the **Input variables** section, review the default input variables and provide alternatives if desired - the only mandatory parameter is the name given to the SSH key that you uploaded to your IBM Cloud account
- Select **Save changes**

### Inventory

1. On **Schematics** main page in IBM Cloud menu:

- Select **Inventories**
- Select **Create Inventory**
- Enter a name for your inventory
- Select **Define manually**
- Enter the following:

[webapptier]
172.21.0.4
172.21.8.4
[dbtier0]
172.21.1.4
[dbtier1]
172.21.9.4

- Select **Create inventory**

### Action

1. On **Schematics** main page in IBM Cloud menu:
a. Select Actions
b. Select Create action   
c. Enter a name for your action   
d. Select Create to create your action

2. On **Settings** page in your action:
a. Enter the URL of this example in the Github repository
b. Select **Retrieve playbooks**
c. Select **Save**

- Select **Save changes**
| Key | Value | Sensitive |
| ---------- | -------- | ----------- |
| dbpassword | securepassw0rd | | Yes |
| logdna_key | 143c30a06ac6dfae03b3a84259bf1b9e | | Yes |
| sysdig_key | 55e7f496-af78-4e0d-89f7-fa040e259ebd | | Yes |
| app_name | (website) | | No |
| source_db | 172.21.1.4 | | No |
| replica_db | 172.21.9.4 | | No |

4.  From the workspace **Settings** page, click **Generate plan** 
5.  Click **View log** to review the log files of your Terraform
    execution plan.
6.  Apply your Terraform template by clicking **Apply plan**.
7.  Review the log file to ensure that no errors occurred during the
    provisioning, modification, or deletion process.

The output of the Schematics Apply Plan will list the public IP address
of the bastion host and the frontend and backend app servers. These can
be used for input to subsequent software provisioning templates using
remote-exec or Redhat Ansible.

The following must be configured prior to running Terraform / Ansible
1. A Public SSH key as described in [SSH Keys](https://cloud.ibm.com/docs/vpc-on-classic-vsi?topic=vpc-on-classic-vsi-ssh-keys#ssh-keys).
2. A resource group exists and is referenced in configuration as described in [Managing resource groups](https://cloud.ibm.com/docs/resources?topic=resources-rgs#rgs)
3. User permissions and the required access as described in [Managing user permissions for VPC resources](https://cloud.ibm.com/docs/vpc-on-classic?topic=vpc-on-classic-managing-user-permissions-for-vpc-resources)

### Deploy VPC Infrastructure using Terraform & Ansible

1. [Deploy Infrastructure using Terraform](docs/terraform.md)
2. [Establish site-to-site VPN](docs/vpn.md)
3. [Configure Application Layer using Ansible](docs/ansible.md)
