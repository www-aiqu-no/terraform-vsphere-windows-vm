module "windows_vm" {
  source = "github.com/www-aiqu-no/terraform-vsphere-windows-vm.git"
  hosts  = ["my-vsphere-host"]
  #hosts  = []
# ------------------------------------------------------------------------------
  datacenter         = "vsphere-datacenter-name"
  resource_pool      = "VMC1/Resources"
  datastore_backend  = "vsphere-datastore-name"
  network_backend    = "vsphere-network-name"
  vsphere_folder     = "vsphere-folder-name"
# ------------------------------------------------------------------------------
  name     = "vm-name-prefix"
  template = "windows-template"
# ------------------------------------------------------------------------------
  #cpu     = 2
  #ram_mb  = 2048
  #disk_gb = 20
# ------------------------------------------------------------------------------
  #ipv4_address_start = "10"
  #ipv4_network       = "10.0.250.0/24"
  #ipv4_gateway       = "10.0.250.1"
  #dns_domain         = "contoso.com"
# ------------------------------------------------------------------------------
  #join_domain = false
}
