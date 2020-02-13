# Define values here for easier maintenance & readability

locals {

  # Do not provide values here in production
  secrets = {
    vsphere_password       = "vSphereSecretPassword"
    windows_admin_password = "WindowsSecretPassword"
  }

  vsphere = {
    username     = "username-to-authenticate-with"
    address      = "address.of.vcenter"
    datacenter   = "name-of-datacenter"
    datastore    = "name-of-datastore"
    resourcepool = "VMC1/Resources" # Default for vSphere w/o DRS
    network      = "name-of-network"
    template     = "name-of-vm-template"
  }

  vm = {
    name      = "tfw"
    instances = 2
    network   = "10.0.0.0/24"
    gateway   = "10.0.0.1"
    ip_start  = 50
    # --
    cpus = 1
    ram  = 2048
    # --
    workgroup      = "WORKGROUP"
    admininstrator = "Administrator"
  }
}
# ==============================================================================
#   Deploy VM(s) with module
# ==============================================================================

module "vms" {
  source  = "www-aiqu-no/windows-vm/vsphere"
  version = "0.2.0"
  #source = "../."
  # --
  datacenter   = local.vsphere.datacenter
  datastore    = local.vsphere.datastore
  resourcepool = local.vsphere.resourcepool
  network      = local.vsphere.network
  template     = local.vsphere.template
  # --
  windows_workgroup      = local.vm.workgroup
  windows_full_name      = local.vm.admininstrator
  windows_admin_password = local.secrets.windows_admin_password
  # --
  prefix            = local.vm.name
  instances         = local.vm.instances
  ipv4_network      = local.vm.network
  ipv4_gateway      = local.vm.gateway
  ipv4_address_from = local.vm.ip_start
  # --
  cpu_count = local.vm.cpus
  memory_mb = local.vm.ram
}

# Need to re-define any outputs you want from underlying modules
output "name_to_ip" {
  description = "Names & addresses of deployed nodes"
  sensitive   = false
  value       = module.vms.name_to_ip
}

# ==============================================================================
#   Example provisioning with ansible
# ==============================================================================

resource "null_resource" "provision_vms" {
  count = length(module.vms.id) # Creates a provisioner-resource for each vm

  # Only runs when this string changes (or resource is tainted)
  triggers = {
    id = join(",", module.vms.id)
  }

  # Connect to instance via ssh
  connection {
    type     = "winrm"
    user     = local.vm.admininstrator
    password = local.secrets.windows_admin_password
    host     = element(module.vms.ip, count.index)
  }

  # Copy local files to deployed instance
  provisioner "file" {
    source      = "./powershell"
    destination = "/temp/"
  }

  # Execute powershell script
  provisioner "remote-exec" {
    inline = [
      "cd C:\\temp",
      "provision.ps1"
    ]
  }
}

# ==============================================================================
#   Providers
# ==============================================================================

terraform {}

provider "vsphere" {
  version = "~> 1.16"
  # --
  vsphere_server       = local.vsphere.address
  user                 = local.vsphere.username
  password             = local.secrets.vsphere_password
  allow_unverified_ssl = true
}
