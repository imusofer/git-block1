terraform {
  required_providers{
    azurerm = {
        source = "hashicorp/azurerm"
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
  type = string
}

variable "resource_group_name" {
  description = "Azure resource group name"
  type = string
}

resource "azurerm_resource_group" "main" {
  name = var.resource_group_name
  location = var.location
}

output "tf_block1" {
  description = "The name of the Azure resource group"
  value = azurerm_resource_group.main.name
}
