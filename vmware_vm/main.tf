module "vmware_vms" {
  source           = "modules/vm"
  vm_count         = "${var.vm_count}"
  vm_name          = "demo"
  template_id      = "${data.vsphere_virtual_machine.template.id}"
  guest_id         = "${var.vm_guest_id}"
  folder           = "${var.vm_folder}"
  resource_pool_id = "${var.vsphere_resource_pool == "" ? data.vsphere_compute_cluster.cluster.resource_pool_id : var.vsphere_resource_pool}"
  datastores       = ["${data.vsphere_datastore.datastore.id}"]
  network_id       = "${data.vsphere_network.network.id}"
}
