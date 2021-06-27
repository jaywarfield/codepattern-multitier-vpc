## Setup Instructions

### Access

1. Make sure that you have the required [IAM permissions](https://cloud.ibm.com/docs/vpc?topic=vpc-managing-user-permissions-for-vpc-resources) to create and work with VPC infrastructure and [Schematics permissions](https://cloud.ibm.com/docs/schematics?topic=schematics-access) to create the workspace and deploy resources.

2. Generate an [SSH key](https://cloud.ibm.com/docs/vpc?topic=vpc-ssh-keys). The SSH key is required to access the provisioned VPC virtual server instances via the bastion host. After you have created your SSH key, make sure to upload this SSH key to your [account](https://cloud.ibm.com/docs/vpc-on-classic-vsi?topic=vpc-on-classic-vsi-managing-ssh-keys#managing-ssh-keys-with-ibm-cloud-console) in the VPC region and resource group where you want to deploy this example.

### Schematics Workspace

1. Go to **Schematics**
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
| vpc-name | string | webappvpc |  your-webappvpc | No |
| resource-group | string | webapprg |  your-webapprg | No|
| domain | string | mydomain.com |  your-domain.com | No |
| cis-instance-name | string | mydomain.com |  your-domain.com | No |

### Schematics Action

1. Go to **Schematics**
2. Select **Actions**
3. Select **Create action**   
4. Enter a name for your action   
5. Select **Create** to create your action
6. Go to **Settings** page
7. Enter URL of the Github repository
8. Select **Retrieve playbooks**
9. Select playbooks/site.yaml
10. Select **Advanced options**
11. Select **Define your variables**
12. Select **Add input value** with the following:

| Key | Value | Sensitive |
| --- | --- | --- |
| dbpassword | securepassw0rd | Yes |
| logdna_key | 143c30a06ac6dfae03b3a84259bf1b9e | Yes |
| sysdig_key | 55e7f496-af78-4e0d-89f7-fa040e259ebd | Yes |
| app_name | www<area>.yourdomain.com | No |
| source_db | 172.21.1.4 | No |
| replica_db | 172.21.9.4 | No |

13. Select **Save**
14. Select **Edit inventory**
15. Enter **Bastion host IP** from Terraform output
16. Select **Create Inventory**
17. Enter a name for your inventory
18. Select **Define manual** with the following:

| Inventory |
| --- |
| [webapptier] |
| 172.21.0.4 |
| 172.21.8.4 |
| [dbtier0] |
| 172.21.1.4 |
| [dbtier1] |
| 172.21.9.4 |

19. Select **Create inventory**
20. Enter **private SSH key** (ensure newline at end of key is included)
21. Check **Use same key**
16. Select **Save**
