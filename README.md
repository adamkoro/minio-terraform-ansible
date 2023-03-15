# minio-terraform-ansible

Create Minio cluster easly with Terraform and Ansible

## Original documentation

- Minio cluster: https://min.io/docs/minio/linux/operations/install-deploy-manage/deploy-minio-multi-node-multi-drive.html
- Nginx config: https://min.io/docs/minio/linux/integrations/setup-nginx-proxy-with-minio.html


## Requirements

- Terraform
- Ansible

## How to use

- Clone this repository

### Install

#### Terraform
- Create a file called `terraform.tfvars` and fill it with your data:

``` bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
```
- Run **terraform init** to initialize terraform

```bash
terraform init
```

- Run **terraform plan** to plan the infrastructure

```bash
terraform plan
```

- Run **terraform apply** to create the infrastructure

```bash
terraform apply
```

#### Ansible

- Run **ansible-playbook** to install Minio and Nginx on the servers
- Edit the **inventory/hosts.ini** file to match your infrastructure

```bash
cd ansible
cp inventory/hosts.ini.example inventory/hosts.ini
```

- Copy the **inventory/group_vars/all.yml.example** to **inventory/group_vars/all.yml** and fill it with your data:

``` bash
cp inventory/group_vars/all.yml.example inventory/group_vars/all.yml
```
- Run **ansible-playbook** to install Minio and Nginx on the servers
``` bash
ansible-playbook -i inventory/hosts.ini install.yml
```

### Destroy

#### Terraform
- Run **terraform destroy** to destroy the infrastructure

```bash
cd terraform
terraform destroy
```

#### Ansible

- Run **ansible-playbook** to uninstall Minio from the servers. **ONLY MINIO**

``` bash
cd ansible
ansible-playbook -i inventory/hosts.ini delete.yml
```
