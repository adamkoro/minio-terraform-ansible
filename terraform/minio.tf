resource "proxmox_vm_qemu" "minio" {
    count       = var.minio_vm_count
    target_node = var.proxmox_target_node
    name        = "${var.proxmox_minio_vm_name}-${count.index + 1}"
    vmid        = "200${count.index + 4}"
    cores       = 4
    sockets     = 1
    cpu         = "host"
    memory      = 6144
    agent       = 1
    onboot      = true
    scsihw      = "virtio-scsi-single"
    full_clone  = var.proxmox_vm_full_clone
    startup     = "order=0"
    bootdisk    = "scsi0"
    clone       = var.proxmox_template_name
disks {
        sata {
            sata0 {
                cdrom {
                    iso = proxmox_cloud_init_disk.minio_ci[count.index].id
                }
            }
        }
        scsi {
            # Root
            scsi0 {
                disk {
                    storage = var.proxmox_root_pool
                    size = var.proxmox_root_pool_size
                    iothread = true
                    emulatessd = true
                    asyncio = "native"
                }
            }
        }
        virtio {
            # swap
            virtio0 {
                disk {
                    storage = var.proxmox_swap_pool
                    size = var.proxmox_swap_pool_size
                    iothread = true
                    asyncio = "native"
                }
            }
            # minio1
            virtio1 {
                disk {
                    storage = "wd-1"
                    size = var.proxmox_minio_pool_size
                    iothread = true
                    asyncio = "native"
                }
            }
            # minio2
            virtio2 {
                disk {
                    storage = "wd-2"
                    size = var.proxmox_minio_pool_size
                    iothread = true
                    asyncio = "native"
                }
            }
            # minio3
            virtio3 {
                disk {
                    storage = "toshiba-1"
                    size = var.proxmox_minio_pool_size
                    iothread = true
                    asyncio = "native"
                }
            }
            # minio4
            virtio4 {
                disk {
                    storage = "wd-1"
                    size = var.proxmox_minio_pool_size
                    iothread = true
                    asyncio = "native"
                }
            }
            # minio5
            virtio5 {
                disk {
                    storage = "wd-2"
                    size = var.proxmox_minio_pool_size
                    iothread = true
                    asyncio = "native"
                }
            }
            # minio6
            virtio6 {
                disk {
                    storage = "toshiba-1"
                    size = var.proxmox_minio_pool_size
                    iothread = true
                    asyncio = "native"
                }
            }
        }
        
    }
    network {
        bridge = "vmbr0"
        model  = "virtio"
    }
    network {
        bridge = "vmbr1"
        model  = "virtio"
    }
    provisioner "local-exec" {
        command = "while ! nc -q0 ${var.cloud_init_ip_pool0}${count.index + var.cloud_init_minio_ip_increase} 22 < /dev/null > /dev/null 2>&1; do sleep 10;done"
    }
    provisioner "local-exec" {
        command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook minio-setup.yaml -i '${var.cloud_init_ip_pool0}${count.index + var.cloud_init_minio_ip_increase},' --private-key ${var.ansbile_private_key} -e ansible_user=${var.cloud_init_username}"
    }
}