output "id" {
  value = "${vsphere_virtual_machine.vm.*.id}"
}

output "name" {
  value = "${vsphere_virtual_machine.vm.*.name}"
}

output "ip" {
  value = "${vsphere_virtual_machine.vm.*.default_ip_address}"
}

output "vmware_tools_status" {
  value = "${vsphere_virtual_machine.vm.*.vmware_tools_status}"
}
