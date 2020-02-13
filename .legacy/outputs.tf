output "virtual_machine_names" {
  description = "Name of deployed nodes"
  value       = [flatten(list(vsphere_virtual_machine.vm.*.name))]
}

output "virtual_machine_ids" {
  description = "ID of deployed nodes"
  value       = zipmap(flatten(list(vsphere_virtual_machine.vm.*.name)),flatten(list(vsphere_virtual_machine.vm.*.id,)),)
}

output "virtual_machine_default_ips" {
  description = "IP address of deployed nodes"
  value       = zipmap(flatten(list(vsphere_virtual_machine.vm.*.name)),flatten(list(vsphere_virtual_machine.vm.*.default_ip_address,)),)
}
