output "tf_block2_rg" {
  description = "The name of the Azure resource group"
  value       = module.resource_group.name
}

output "tf_block2_vnet" {
  description = "The name of the VNet"
  value       = module.network.vnet_name
}

output "tf_block2_nsg" {
  description = "The name of the NSG"
  value       = module.network_security.nsg_name
}

output "tf_block2_subnet" {
  description = "The name of the Subnet"
  value       = module.network.subnet_name
}

output "tf_block2_nic" {
  description = "The name of the NIC"
  value       = module.linux_vm.network_interface_name
}

output "tf_block2_vm" {
  description = "The name of the Linux VM"
  value       = module.linux_vm.vm_name
}

output "tf_block2_pip" {
  description = "Public IP Address value"
  value       = module.linux_vm.public_ip_address
}