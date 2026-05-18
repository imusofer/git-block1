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