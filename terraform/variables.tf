variable "virtual_network_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "subnet_name" {
  type = string
}

variable "subnet_address_prefixes" {
  type = list(string)
}

variable "network_security_group_name" {
  type = string
}