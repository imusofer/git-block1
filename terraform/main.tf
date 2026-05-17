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

variable "location" {
  description = "Azure region for the resource group"
  type        = string
}

variable "resource_group_name" {
  description = "Azure resource group name"
  type        = string
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

resource "azurerm_network_security_group" "main" {
  name                = "block19-nsg"
  location            = var.location
  resource_group_name = module.resource_group.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_public_ip" "main" {
  name                = "block19-pip"
  resource_group_name = module.resource_group.name
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "main" {
  name                = "block19-nic"
  location            = var.location
  resource_group_name = module.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.network.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

resource "azurerm_network_interface_security_group_association" "main" {
  network_security_group_id = azurerm_network_security_group.main.id
  network_interface_id      = azurerm_network_interface.main.id
}

resource "azurerm_linux_virtual_machine" "main" {
  name                = "block19-vm"
  resource_group_name = module.resource_group.name
  location            = var.location
  size                = "Standard_B2als_v2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.main.id
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("/home/imusofer/.ssh/id_ed25519.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Debian"
    offer     = "debian-11"
    sku       = "11-backports-gen2"
    version   = "latest"
  }
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
  value       = azurerm_network_security_group.main.name
}

output "tf_block2_subnet" {
  description = "The name of the Subnet"
  value       = module.network.subnet_name
}

output "tf_block2_nic" {
  description = "The name of the NIC"
  value       = azurerm_network_interface.main.name
}

output "tf_block2_vm" {
  description = "The name of the Linux VM"
  value       = azurerm_linux_virtual_machine.main.name
}

output "tf_block2_pip" {
  description = "Public IP Address value"
  value       = azurerm_public_ip.main.ip_address
}