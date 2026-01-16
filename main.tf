terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "rg" {
  name     = "terrasatyam"
  location = "Central US"
}

module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.rg.name
  vnet_name           = "satyam-vnet"
  vnet_address_space  = ["10.0.0.0/16"]
  subnet_name        = "satyam-subnet"
  subnet_address_prefix = ["10.0.1.0/24"]
  nic_name            = "satyam-nic"
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "vmsatyam"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = "central us"  # Ensure the region supports Zone 3
  size                  = "Standard_D2s_v3"  # Use the available VM size in Zone 3
  admin_username        = "Administrator1"
  admin_password        = "Networklabs@1234"  # Replace with a secure password

  disable_password_authentication = false  # Allow password authentication
  network_interface_ids = [module.network.nic_id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }


}
