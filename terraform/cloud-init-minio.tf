data "template_file" "cloud_init_minio_template" {
  count    = var.minio_vm_count
  template = file("${path.module}/cloud-init_template.tftpl")
  vars = {
    ssh_key  = var.cloud_init_pub_ssh_key
    username = var.cloud_init_username
    password = var.cloud_init_password
    hostname = "${var.proxmox_minio_vm_name}-${count.index + 1}"
    domain   = var.cloud_init_domain
  }
}

resource "local_file" "cloud_init_minio_local" {
  count    = var.minio_vm_count
  content  = element(data.template_file.cloud_init_minio_template.*.rendered, count.index)
  filename = "${path.module}/files/cloud_init_${var.proxmox_minio_vm_name}_${count.index + 1}.cfg"
}

resource "null_resource" "cloud_init_minio" {
  count = var.minio_vm_count
  connection {
    type        = "ssh"
    user        = var.proxmox_user
    private_key = file(var.proxmox_private_key)
    host        = var.proxmox_host
  }

  provisioner "file" {
    source      = element(local_file.cloud_init_minio_local.*.filename, count.index)
    destination = "${var.cloudinit_host_pool_path}/snippets/cloud_init_${var.proxmox_minio_vm_name}-${count.index + 1}.yml"
  }
}