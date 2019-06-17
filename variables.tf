## -----------------------------------------------------------------------------
#                                                              vSphere variables
## -----------------------------------------------------------------------------
variable "datacenter" {
  type        = "string"
  description = "vSphere datacenter"
}

variable "resource_pool" {
  type        = "string"
  description = "vSphere resource pool"
}

variable "datastore_backend" {
  type        = "string"
  description = "vSphere storage"
}

variable "network_backend" {
  type        = "string"
  description = "vSphere network"
}

## -----------------------------------------------------------------------------
#                                                          VM Required variables
## -----------------------------------------------------------------------------
variable "name" {
  type        = "string"
  description = "Name of the VM"
}

variable "template" {
  type        = "string"
  description = "vSphere VM template"
}

## -----------------------------------------------------------------------------
#                                                          VM Optional variables
## -----------------------------------------------------------------------------
variable "hosts" {
  type        = "list"
  description = "vSphere hosts to create vm(s) on"
  default     = []
}

variable "cpu" {
  type        = "string"
  description = "Number of CPUs to assign"
  default     = 2
}

variable "ram_mb" {
  type        = "string"
  description = "Amount of memory to assign (MB)"
  default     = "4096"
}

variable "disk_gb" {
  type        = "string"
  description = "Amount of storage (GB)"
  default     = "80"
}

variable "ipv4_network" {
  type        = "string"
  description = "Primary ipv4 network"
  default     = "10.0.250.0/24"
}

variable "ipv4_address_start" {
  type        = "string"
  description = "Primary ipv4 address"
  default     = "10"
}

variable "ipv4_gateway" {
  type        = "string"
  description = "Primary ipv4 network gateway"
  default     = "10.0.250.1"
}

variable "dns_servers" {
  type        = "list"
  description = "DNS resolver(s)"
  default     = ["8.8.8.8", "8.8.4.4"]
}

variable "dns_domain" {
  type        = "string"
  description = "Primary search-domain"
  default     = "localdomain"
}

variable "local_admin_password" {
  type        = "string"
  description = "Default Windows administrator password"
  default     = "GoGoGadget!"
}

variable "join_domain" {
  type        = "string"
  description = "Join to domain"
  default     = false
}

variable "join_domain_name" {
  type        = "string"
  description = "Name of domain to join"
  default     = "Contoso"
}

variable "join_domain_user" {
  type        = "string"
  description = "Domain account for joining"
  default     = "BillGates"
}

variable "join_domain_secret" {
  type        = "string"
  description = "Password for joining domain"
  default     = "GoGoGadget!"
}

variable "windows_organization" {
  type        = "string"
  description = "Organization to join"
  default     = "Contoso Inc."
}

variable "windows_workgroup" {
  type        = "string"
  description = "Workgroup to join"
  default     = "WORKGROUP"
}

variable "vsphere_boot_delay" {
  type = "string"
  description = "VM boot delay"
  default = 5000
}

variable "vsphere_folder" {
  type = "string"
  description = "vSphere folder to place VM"
  default = ""
}

variable "vsphere_info" {
  type = "string"
  description = "vSphere vm description"
  default = "Deployed with Terraform"
}
