# Automate deployment of Multitier Web App in IBM VPC

## Purpose

Automate infrastructure deployment and configuration for [IBM VPC](https://cloud.ibm.com/docs/vpc) utilizing:
- [Terraform](https://www.terraform.io/)
- [Schematics](https://cloud.ibm.com/docs/schematics?topic=schematics-getting-started)
- [Actions](https://cloud.ibm.com/docs/schematics?topic=schematics-create-playbooks) [(Ansible)](https://www.redhat.com/en/technologies/management/ansible)
  
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

## VPC Architecture
The IBM VPC architecture of the solution showing public isolation for both Application (through a Load Balancer) and Data.

### Infrastructure Architecture
![3tier Web App - Infrastructure](/docs/images/infrastructure-architecture.png)

### Application Architecture
![3tier Web App - Application](docs/images/application-data-flow.png)

## Setup Instructions

### Preliminary

1. Make sure that you have the required [IAM permissions](https://cloud.ibm.com/docs/vpc?topic=vpc-managing-user-permissions-for-vpc-resources) to create and work with VPC infrastructure and [Schematics permissions](https://cloud.ibm.com/docs/schematics?topic=schematics-access) to create the workspace and deploy resources.

2. Generate an [SSH key](https://cloud.ibm.com/docs/vpc?topic=vpc-ssh-keys). The SSH key is required to access the provisioned VPC virtual server instances via the bastion host. After you have created your SSH key, make sure to upload this SSH key to your [account](https://cloud.ibm.com/docs/vpc-on-classic-vsi?topic=vpc-on-classic-vsi-managing-ssh-keys#managing-ssh-keys-with-ibm-cloud-console) in the VPC region and resource group where you want to deploy this example.

### Workspace

1. Go to **Schematics** main page
2. Select Workspaces
3. Select **Create workspace**   
4. Enter a name for your workspace   
5. Select **Create** to create your workspace
6. Go to **Settings** page in your workspace
7. Enter the URL of this example in the Github repository
8. Select the Terraform version: terraform_v0.14
9. Select **Save template information**
10. Go to **Variables**
11. Review the **Defaults** for each variable
12. Select **Edit** and uncheck "Use default" to customize values, in particular:

| Name | Type | Default | Override value | Sensitive |
| --- | --- | --- | --- | --- |
| ssh-public-key | string | |  your-key | Yes |
| vpc-name | string | webappvpc |  your-webappvpc | Yes |
| resource-group | string | webapprg |  your-webapprg | Yes |
| domain | string | mydomain.com |  your-domain.com | Yes |
| cis-instance-name | string | mydomain.com |  your-domain.com | Yes |

### Inventory

1. Go to **Schematics** main page
2. Select **Inventories**
3. Select **Create Inventory**
4. Enter a name for your inventory
5. Select **Define manually**
6. Enter the following:

| [webapptier] | [dbtier0] | [dbtier1] |
| --- | --- | --- |
| 172.21.0.4 | 172.21.1.4 | 172.21.9.4 |
| 172.21.8.4 | | |

7. Select **Create inventory**

### Action

1. Go to **Schematics** main page
2. Select **Actions**
3. Select **Create action**   
4. Enter a name for your action   
5. Select **Create** to create your action
6. Go to **Settings** page
7. Enter URL of the Github repository
8. Select **Retrieve playbooks**
9. Go to **Define your variables**
10. Select **Add input value** and **Save** for these variables:

| Key | Value | Sensitive |
| --- | --- | --- |
| dbpassword | securepassw0rd | Yes |
| logdna_key | 143c30a06ac6dfae03b3a84259bf1b9e | Yes |
| sysdig_key | 55e7f496-af78-4e0d-89f7-fa040e259ebd | Yes |
| app_name | (website) | No |
| source_db | 172.21.1.4 | No |
| replica_db | 172.21.9.4 | No |

## Usage Instructions

### Workspace

1. Go to **Schematics** main page
2. Select Workspaces
3. Select your workspace
4. Select **Generate plan** to review plan
5. Select **View log** to review the plan execution log
6. Select **Apply plan** to provision plan
7. Select **View log** to review the apply execution log
9. Optionally review /var/log/cloud-init-output.log on each server
8. Note the **Outputs** at the end of apply execution log:

| Name | Value |
| --- | --- |
| app_name | www<area>.your-domain.com |
| bastionserver1 | bastionIP1 (public) |
| bastionserver2 | bastionIP2 (public) |
| ssh-bastionserver1 | ssh root@bastionIP1 |
| ssh-bastionserver2 | ssh root@bastionIP2 |
| replica_db | 172.21.9.4 |
| ssh-replicadb | ssh -o ProxyJump=root@bastionIP2 root@172.21.9.4 |
| source_db | 172.21.1.4 |
| ssh-sourcedb | ssh -o ProxyJump=root@bastionIP1 root@172.21.1.4 |
| webappserver1 | 172.21.0.4 |
| ssh-webappserver1 | ssh -o ProxyJump=root@bastionIP1 root@172.21.0.4 |
| webappserver2 | 172.21.8.4 |
| ssh-webappserver2 | ssh -o ProxyJump=root@bastionIP2 root@172.21.8.4 |

### Action

1. Go to **Schematics** main page
2. Select **Actions**
3. Select your action
4. Select **Settings**
5. Select **Edit inventory**
6. Update **Bastion host IP** with IP from Terraform output
7. Select **Save**
8. Select **Run action**
9. Select **View log** to review the run action log
