terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "7a91bdee-30d4-4fc8-8bb2-2252cfd4e34a"
}

module "resource_group" {
  source = "./modules/resource-group"

  name     = var.resource_group_name
  location = var.location
}

module "network" {
  source = "./modules/network"

  name                    = var.virtual_network_name
  address_space           = var.address_space
  location                = var.location
  resource_group_name     = module.resource_group.name
  subnet_name             = var.subnet_name
  subnet_address_prefixes = var.subnet_address_prefixes
}

module "network_security" {
  source = "./modules/network-security"

  name                = var.network_security_group_name
  location            = var.location
  resource_group_name = module.resource_group.name
}

module "linux_vm" {
  source = "./modules/linux-vm"

  resource_group_name       = module.resource_group.name
  location                  = var.location
  subnet_id                 = module.network.subnet_id
  network_security_group_id = module.network_security.nsg_id

  public_ip_name         = var.public_ip_name
  network_interface_name = var.network_interface_name
  vm_name                = var.vm_name
  vm_size                = var.vm_size
  admin_username         = var.admin_username
  ssh_public_key         = file("/home/imusofer/.ssh/id_ed25519.pub")
}

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