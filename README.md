<!-- Put badges at the very top -->
<!-- Change the repo -->
[![Build Status](https://travis-ci.org/IBM/watson-banking-chatbot.svg?branch=master)](https://travis-ci.org/IBM/watson-banking-chatbot)

# Automate deployment of Multitier Web App in IBM VPC

In this code pattern, we will demonstrate using [Terraform](https://www.terraform.io/) and [Ansible](https://www.redhat.com/en/technologies/management/ansible) to automate infrastucture deployment and configuration using [Schematics](https://cloud.ibm.com/docs/schematics?topic=schematics-getting-started) for a [multitier](https://www.ibm.com/cloud/learn/three-tier-architecture) web application in [IBM VPC](https://cloud.ibm.com/docs/vpc).  A multitier architecture leverages VPC for public cloud isolation that separates the web/application and data tiers by deploying VSIs into isolated subnets across different availability zones with network isolation defined using Security Groups and ACLs. 

Infrastructure features include:

- VPC public cloud isolation.
- Logical network isolation using Security Groups and ACLs.
- Layers on isolated subnets across zones.
- RFC1918 private bring-your-own-IP addresses.
- Global DDOS and Global Load Balancing.
- Bastion and VPN for secure connectivity between on-premise and VPC.
- SysDig and LogDNA for infrastructure and application monitoring. 

Application features include:

- [LAMP stack](https://www.ibm.com/cloud/learn/lamp-stack-explained) with Linux, MySQL, and PHP.
- [NGINX](https://www.nginx.com/) is used as the Web Server.
- [NGINX Unit](https://www.nginx.com/products/nginx-unit/) is used as the Application Server.
- [WordPress](https://wordpress.com) (popular web, blog and e-commerce platform) demonstrates horizontal scalability across zones.
- [MySQL](https://www.mysql.com) (typical open source database) demonstrates multiple database servers and replication strategy across zones.

When you have completed this code pattern, you will understand how to:
* How to create Terraform to provision infrastructure.
* How to create Ansible to configure infrastructure.
* How to use [Schematics Workspaces](https://cloud.ibm.com/docs/schematics?topic=schematics-workspace-setup) with Terraform.
* How to use [Schematics Actions](https://cloud.ibm.com/docs/schematics?topic=schematics-create-playbooks) with Ansible.
  
<!--add an image in this path-->
![architecture](doc/source/images/webappvpc-architecture.svg)

<!--Optionally, add flow steps based on the architecture diagram-->
## Flow

1. Step 1.
2. Step 2.
3. Step 3.
4. Step 4.
5. Step 5.

<!--Optionally, update this section when the video is created-->
# Watch the Video

[![video](http://img.youtube.com/vi/Jxi7U7VOMYg/0.jpg)](https://www.youtube.com/watch?v=Jxi7U7VOMYg)

# Steps

<!--
Use the **Deploy to IBM Cloud** button **OR** create the services and run locally.

<!-- Optionally, add a deploy to ibm cloud button-->

## Deploy to IBM Cloud

[![Deploy to IBM Cloud](https://cloud.ibm.com/deploy/button.png)](https://cloud.ibm.com/deploy?repository=https://github.com/IBM/watson-banking-chatbot.git)

1. Press **Deploy to IBM Cloud**, and then click **Deploy**.

<!--optional step-->
2. In Toolchains, click **Delivery Pipeline** to watch while the app is deployed. After it's deployed, the app can be viewed by clicking **View app**.
![toolchain pipeline](doc/source/images/toolchain-pipeline.png)

<!--update with service names from manifest.yml-->

3. To see the app and services created and configured for this code pattern, use the IBM Cloud dashboard. The app is named `watson-banking-chatbot` with a unique suffix. The following services are created and easily identified by the `wbc-` prefix:
    * `wbc-conversation-service`
    * `wbc-discovery-service`
    * `wbc-natural-language-understanding-service`
    * `wbc-tone-analyzer-service`

## Run locally

> NOTE: These steps are only needed when running locally instead of using the **Deploy to IBM Cloud** button.

-->
<!-- there are MANY updates necessary here, just screenshots where appropriate -->

1. [Clone repo](#1-clone-the-repo).
2. [Configure credentials](#2-configure-credentials).
3. [Create Schematics Workspace](#3-create-schematics-workspace).
4. [Create Schematics Action](#4-create-schematics-action).
5. [Apply Schematics Workspace](#5-apply-schematics-workspace).
6. [Run Schematics Action](#6-run-schematics-action).
7. [Configure Internet Services](#7-run-the-application).

### 1. Clone repo

Clone the `codepattern-multitier-vpc` repo locally. In a terminal, run:

```bash
git clone https://github.com/codpattern-multitier-vpc
```

<!--
We’ll be using the file [`data/assistant/workspaces/banking.json`](data/assistant/workspaces/banking.json) and the folder
[`data/assistant/workspaces/`](data/assistant/workspaces/)
-->

### 2. Configure credentials

* Make sure that you have the required [IAM permissions](https://cloud.ibm.com/docs/vpc?topic=vpc-managing-user-permissions-for-vpc-resources) to create and work with VPC infrastructure and [Schematics permissions](https://cloud.ibm.com/docs/schematics?topic=schematics-access) to create the workspace and deploy resources.

* Generate an [SSH key](https://cloud.ibm.com/docs/vpc?topic=vpc-ssh-keys). The SSH key is required to access the provisioned VPC virtual server instances via the bastion host. After you have created your SSH key, make sure to upload this SSH key to your [account](https://cloud.ibm.com/docs/vpc-on-classic-vsi?topic=vpc-on-classic-vsi-managing-ssh-keys#managing-ssh-keys-with-ibm-cloud-console) in the VPC region and resource group where you want to deploy this example.

### 3. Create Schematics Workspace

* Go to **Schematics** in cloud portal
* Select Workspaces
* Select **Create workspace**   
* Enter a name  
* Select **Location**
* Select **Create** 
* Go to **Settings**
* Enter the GitHub URL 
* Select a **Terraform version** (tested with terraform_v0.14)
* Select **Save template information**
* Go to **Variables**
* Review the **Defaults** for each variable
* Select **Edit** and uncheck "Use default" to customize values and select **Save**, in particular:

| Name | Type | Default | Override value | Sensitive |
| --- | --- | --- | --- | --- |
| ssh-public-key | string | |  your-key | Yes |
| vpc-name | string | webappvpc |  your-webappvpc | No |
| resource-group | string | webapprg |  your-webapprg | No|
| domain | string | mydomain.com |  your-domain.com | No |
| cis-instance-name | string | mydomain.com |  your-domain.com | No |

### 4. Create Schematics Action

* Go to **Schematics** in cloud portal
* Select **Actions**
* Select **Create action**   
* Enter a name for your action   
* Select **Create** to create your action
* Go to **Settings** page
* Enter URL of the Github repository
* Select **Retrieve playbooks**
* Select playbooks/site.yaml
* Select **Advanced options**
* Select **Define your variables**
* Select **Add input value** with the following:

| Key | Value | Sensitive |
| --- | --- | --- |
| dbpassword | securepassw0rd | Yes |
| logdna_key | 143c30a06ac6dfae03b3a84259bf1b9e | Yes |
| sysdig_key | 55e7f496-af78-4e0d-89f7-fa040e259ebd | Yes |
| app_name | www<area>.yourdomain.com | No |
| source_db | 172.21.1.4 | No |
| replica_db | 172.21.9.4 | No |

* Select **Save**
* Select **Edit inventory**
* Enter **Bastion host IP** from Terraform output
* Select **Create Inventory**
* Enter a name for your inventory
* Select **Define manual** with the following:

| Inventory |
| --- |
| [webapptier] |
| 172.21.0.4 |
| 172.21.8.4 |
| [dbtier0] |
| 172.21.1.4 |
| [dbtier1] |
| 172.21.9.4 |

* Select **Create inventory**
* Enter **private SSH key** (ensure newline at end of key is included)
* Check **Use same key**
* Select **Save**

### 5. Apply Schematics Workspace

* Go to **Schematics** in cloud portal
* Select Workspaces
* Select your workspace
* Select **Generate plan** to review plan
* Select **View log** to review the plan execution log
* Select **Apply plan** to provision plan
* Select **View log** to review the apply execution log
* Optionally review /var/log/cloud-init-output.log on each server
* Note the **Outputs** at the end of apply execution log:

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

### 6. Run Schematics Action

* Go to **Schematics** in cloud portal
* Select **Actions**
* Select your action
* Select **Run action**
* Select **View log** to review the run action log

### 7. Configure Internet Services

* Go to **Internet Services** in cloud portal
* Select **pricing plan**
* Enter a name for your service
* Select **Create**
* Select **Add domain**
* Enter the name for your domain specified in Schematics
* Select **Next**
* Refer to the **New NS records** where your domain name is registered

<!--
# Sample output

![sample_output](doc/source/images/sample_output.png)

<!--Optionally, include any troubleshooting tips (driver issues, etc)-->

# Troubleshooting

* Error: Environment {GUID} is still not active, retry once status is active

  > This is common during the first run. The app tries to start before the Watson Discovery
environment is fully created. Allow a minute or two to pass. The environment should
be usable on restart. If you used **Deploy to IBM Cloud** the restart should be automatic.

* Error: Only one free environment is allowed per organization

  > To work with a free trial, a small free Watson Discovery environment is created. If you already have
a Watson Discovery environment, this will fail. If you are not using Watson Discovery, check for an old
service thay you might want to delete. Otherwise, use the `.env DISCOVERY_ENVIRONMENT_ID` to tell
the app which environment you want it to use. A collection will be created in this environment
using the default configuration.
-->

<!-- keep this -->
## License

This code pattern is licensed under the Apache License, Version 2. Separate third-party code objects invoked within this code pattern are licensed by their respective providers pursuant to their own separate licenses. Contributions are subject to the [Developer Certificate of Origin, Version 1.1](https://developercertificate.org/) and the [Apache License, Version 2](https://www.apache.org/licenses/LICENSE-2.0.txt).

[Apache License FAQ](https://www.apache.org/foundation/license-faq.html#WhatDoesItMEAN)

