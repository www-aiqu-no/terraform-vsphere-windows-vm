output "name_to_id" {
  description = "IDs of deployed nodes"
  sensitive   = false
  value       = zipmap(flatten(list(vsphere_virtual_machine.vm[*].name)), flatten(list(vsphere_virtual_machine.vm[*].id, )), )
}

output "name_to_ip" {
  description = "IP addresses of deployed nodes"
  sensitive   = false
  value       = zipmap(flatten(list(vsphere_virtual_machine.vm[*].name)), flatten(list(vsphere_virtual_machine.vm[*].default_ip_address, )), )
}

# --

output "name" {
  description = "Names of deployed nodes"
  sensitive   = false
  value       = vsphere_virtual_machine.vm[*].name
}

output "id" {
  description = "ID of deployed nodes"
  sensitive   = false
  value       = vsphere_virtual_machine.vm[*].id
}

output "ip" {
  description = "IP addresses of deployed nodes"
  sensitive   = false
  value       = vsphere_virtual_machine.vm[*].default_ip_address
}
