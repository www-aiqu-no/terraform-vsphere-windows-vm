module "windows_vm" {
  source  = "www-aiqu-no/windows-vm/vsphere"
  version = "0.0.2"
# ------------------------------------------------------------------------------
  hosts  = ["my-vsphere-host"]
# ------------------------------------------------------------------------------
  datacenter        = "vsphere-datacenter-name"
  resource_pool     = "VMC1/Resources"
  datastore_backend = "vsphere-datastore-name"
  network_backend   = "vsphere-network-name"
  vsphere_folder    = "vsphere-folder-name"
# ------------------------------------------------------------------------------
  name     = "vm-name-prefix"
  template = "windows-template"
# ------------------------------------------------------------------------------
  #cpu     = 2
  #ram_mb  = 4096
  #disk_gb = 60
# ------------------------------------------------------------------------------
  #ipv4_address_start = "10"
  #ipv4_network       = "10.0.250.0/24"
  #ipv4_gateway       = "10.0.250.1"
  #dns_domain         = "contoso.com"
# ------------------------------------------------------------------------------
  #join_domain = false
# ------------------------------------------------------------------------------
  #vsphere_custom_attributes = {
  #  "${data.vsphere_custom_attribute.first.id}"  = "somevalue"
  #  "${data.vsphere_custom_attribute.second.id}" = "somevalue"
  #}
# ------------------------------------------------------------------------------
}
