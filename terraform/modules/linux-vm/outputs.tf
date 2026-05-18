output "vm_name" {
  value = azurerm_linux_virtual_machine.main.name
}

output "public_ip_name" {
  value = azurerm_public_ip.main.name
}

output "public_ip_address" {
  value = azurerm_public_ip.main.ip_address
}

output "network_interface_name" {
  value = azurerm_network_interface.main.name
}