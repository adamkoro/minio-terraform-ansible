terraform {
  required_version = ">= 0.13.0"
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.1"
    }
  }
}

provider "libvirt" {
  #uri = "qemu:///system"
  uri = "qemu+ssh://${var.ssh_user}@${var.ssh_host}:${var.ssh_port}/system?keyfile=${var.ssh_key}&sshauth=privkey&no_verify=1"
}

