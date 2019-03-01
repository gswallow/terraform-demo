resource "vsphere_virtual_machine" "vm" {
  count = "${var.vm_count}"

  # up to 999 sequentially named VMs
  name             = "${var.vm_env}-${var.vm_name}${format("%03d", count.index + 1)}.${var.vm_domain}"
  resource_pool_id = "${var.resource_pool_id}"

  # Spread VMs across datastores
  datastore_id = "${element(var.datastores, count.index % length(var.datastores))}"

  num_cpus = "${var.num_cpus}"
  memory   = "${var.memory_mb}"
  guest_id = "${var.guest_id}"
  folder   = "${var.folder}"

  network_interface {
    network_id = "${var.network_id}"
  }

  disk {
    label            = "vda"
    size             = "${var.disk_size_gb}"
    thin_provisioned = "${var.disk_thin_provisioned}"
    eagerly_scrub    = "${var.disk_eagerly_scrub}"
    unit_number      = 0
  }

  clone {
    template_uuid = "${var.template_id}"

    customize {
      linux_options {
        host_name = "${var.vm_env}-${var.vm_name}${format("%03d", count.index + 1)}"
        domain   = "${var.vm_domain}"
      }

      network_interface {
        ipv4_address = "${cidrhost(var.ip_cidr, count.index + var.ip_start)}"
        ipv4_netmask = "${basename(var.ip_cidr)}"
      }

      ipv4_gateway    = "${var.ip_gateway}"
      dns_suffix_list = ["${var.vm_domain}"]
      dns_server_list = "${var.ip_dns_servers}"
    }
  }
}
