## -----------------------------------------------------------------------------
#                                                Deploy VM from vSphere Template
## -----------------------------------------------------------------------------
resource "vsphere_virtual_machine" "vm" {
  count = "${length(var.hosts)}"

  annotation = "Deployed by HashiCorp Terraform"
  wait_for_guest_net_timeout  = 0
  wait_for_guest_net_routable = false

  host_system_id   = "${data.vsphere_host.hosts.*.id[count.index]}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  guest_id  = "${data.vsphere_virtual_machine.template.guest_id}"
  firmware  = "${data.vsphere_virtual_machine.template.firmware}"
  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  name     = "${var.name}${count.index}"
  folder   = "${var.vsphere_folder}"
  memory   = "${var.ram_mb}"
  num_cpus = "${var.cpu}"

  cpu_hot_add_enabled    = true
  cpu_hot_remove_enabled = true
  memory_hot_add_enabled = true
  boot_delay             = "${var.vsphere_boot_delay}"

  disk {
    label            = "disk0"
    unit_number      = 0
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
    #-- Ensure requested size is > template size
    size = "${
      var.disk_gb == "" || var.disk_gb < data.vsphere_virtual_machine.template.disks.0.size ?
        data.vsphere_virtual_machine.template.disks.0.size :
      var.disk_gb
    }"
  }

  network_interface {
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types.0}"
    network_id   = "${data.vsphere_network.network.id}"
  }

  clone {
    linked_clone  = false
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
    timeout       = 60
    customize {
      ipv4_gateway    = "${var.ipv4_gateway}"
      network_interface {
        dns_domain      = "${var.dns_domain}"
        dns_server_list = "${var.dns_servers}"
        ipv4_address    = "${cidrhost(var.ipv4_network,var.ipv4_address_start + count.index)}"
        ipv4_netmask    = "${element(split("/",var.ipv4_network),1)}"
      }
      windows_options {
        computer_name         = "${var.name}${count.index}"
        admin_password        = "${var.local_admin_password}"
        organization_name     = "${var.windows_organization}"
        workgroup             = "${var.join_domain}" ? null : "${var.windows_workgroup}"
        join_domain           = "${var.join_domain}" ? "${var.join_domain_name}"   : null
        domain_admin_user     = "${var.join_domain}" ? "${var.join_domain_user}"   : null
        domain_admin_password = "${var.join_domain}" ? "${var.join_domain_secret}" : null
        auto_logon            = true
        auto_logon_count      = 1
      }
    }
  }
}
