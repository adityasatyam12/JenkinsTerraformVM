variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "subnet_address_prefix" {
  description = "The address prefix for the subnet"
  type        = list(string)
}

variable "nic_name" {
  description = "The name of the network interface"
  type        = string
}

variable "location" {
  description = "The location for the resources"
  type        = string
}

variable "private_ip_address" {
  description = "The private IP address of the NIC"
  type        = string
  default     = ""
}
