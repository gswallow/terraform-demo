# Variables can be integers
variable "vm_count" {
  default = 1
}

# Variables can be strings
variable "vm_env" {
  default = "d"
}

variable "vm_name" {
  default = "testvm"
}

variable "vm_domain" {
  default = "demo.org"
}

# Variables with no default value are required
variable "template_id" {}

variable "folder" {}

variable "resource_pool_id" {}

# Some variables can be lists or maps
variable "datastores" {
  type = "list"
}

variable "num_cpus" {
  default = 1
}

variable "memory_mb" {
  default = 1024
}

variable "disk_size_gb" {
  default = 12
}

# Variables can be booleans but be careful
variable "disk_thin_provisioned" {
  default = false
}

variable "disk_eagerly_scrub" {
  default = false
}

variable "guest_id" {}

variable "network_id" {}

variable "ip_cidr" {
  default = "192.168.1.0/24"
}

variable "ip_start" {
  default = 11
}

variable "ip_gateway" {
  default = "192.168.1.1"
}

variable "ip_dns_servers" {
  default = ["208.67.220.220", "208.67.222.222"]
}
