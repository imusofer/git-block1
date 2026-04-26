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

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = "block19-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "main" {
  name                 = "block19-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "main" {
  name                = "block19-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

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
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "main" {
  name                = "block19-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
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
  resource_group_name = azurerm_resource_group.main.name
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
  value       = azurerm_resource_group.main.name
}

output "tf_block2_vnet" {
  description = "The name of the VNet"
  value       = azurerm_virtual_network.main.name
}

output "tf_block2_nsg" {
  description = "The name of the NSG"
  value       = azurerm_network_security_group.main.name
}

output "tf_block2_subnet" {
  description = "The name of the Subnet"
  value       = azurerm_subnet.main.name
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