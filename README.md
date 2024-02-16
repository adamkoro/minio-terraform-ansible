# minio-terraform-ansible

Create Minio cluster easly with Terraform and Ansible

## Original documentation

- Minio cluster: https://min.io/docs/minio/linux/operations/install-deploy-manage/deploy-minio-multi-node-multi-drive.html
- Nginx config: https://min.io/docs/minio/linux/integrations/setup-nginx-proxy-with-minio.html

## Requirements

- Terraform
- Ansible

## How to use

- Clone this repository.

### Install

#### Terraform

- Create a file called `terraform.tfvars` and fill it with your data:

``` bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
```

- Run **terraform init** to initialize terraform.

```bash
terraform init
```

- Run **terraform plan** to plan the infrastructure.

```bash
terraform plan
```

- Run **terraform apply** to create the infrastructure.

```bash
terraform apply
```

#### Ansible

- Run **ansible-playbook** to install Minio, Keepalived and Haproxy or Nginx on the servers.

##### Cluster playbook

```bash
cd ansible/cluster
cp inventory-example.yaml inventory.yaml
```

**Edit that yaml** file with your data

- Run **ansible-playbook** to install Minio and Nginx on the servers.

``` bash
ansible-playbook -i inventory.yaml playbooks/install.yml
```

### Destroy

#### Terraform

- Run **terraform destroy** to destroy the infrastructure.

```bash
cd terraform
terraform destroy
```

#### Ansible

- Run **ansible-playbook** to uninstall installed apps and configs from the servers.

``` bash
cd ansible/cluster
ansible-playbook -i inventory.yaml playbooks/reset.yml
```
