variable "minio_count" {
  type = number
}
variable "minio_domain_name" {
  type = string
}
variable "proxy_count" {
  type = number
}
variable "proxy_domain_name" {
  type = string
}

variable "cloud_init_username" {
  type = string
}
variable "cloud_init_password" {
  type = string
}
variable "cloud_init_sshkey" {
  type = string
}
variable "cloud_init_nameserver" {
  type = string
}
variable "cloud_init_search_domain" {
  type = string
}
variable "cloud_init_netmask" {
  type = string
}
variable "cloud_init_gateway" {
  type = string
}
variable "node_ip_range" {
  type = string
}

variable "base_root_volume_path" {
  type = string
}
variable "root_volume_pool" {
  type = string
}
variable "swap_volume_pool" {
  type = string
}
variable "data_volume_pool" {
  type = string
}
variable "minio_data_path" {
  type = string
}

variable "ssh_user" {
  type      = string
  sensitive = true
}
variable "ssh_key" {
  type      = string
  sensitive = true
}
variable "ssh_host" {
  type      = string
  sensitive = true
}
variable "ssh_port" {
  type      = number
  sensitive = true
}