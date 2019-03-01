variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}
variable "vsphere_dc_name" {}
variable "vsphere_compute_cluster" {}

# Default to the cluster's root resource pool
variable "vsphere_resource_pool" {
  default = ""
}

variable "vm_count" {
  default = 1
}

variable "vsphere_template" {}
variable "vsphere_network" {}
variable "vsphere_datastore" {}
variable "vm_folder" {}

variable "vm_guest_id" {
  default = "rhel7_64Guest"
}
