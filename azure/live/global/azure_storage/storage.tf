## Azure initialisation

provider "azurerm" {
  version = "=2.7.0"
  features {}
}

resource "azurerm_resource_group" "terraform" {
  name     = "terraform-resources"
  location = "West Europe"
}

# resource "azurerm_virtual_network" "terraform" {
#   name                = "terraform-network"
#   resource_group_name = azurerm_resource_group.terraform.name
#   location            = azurerm_resource_group.terraform.location
#   address_space       = ["10.1.0.0/16"]
# }

resource "azurerm_storage_account" "terraform-state" {
  name                     = "terraformstatem1r5h"
  resource_group_name      = azurerm_resource_group.terraform.name
  location                 = azurerm_resource_group.terraform.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "example" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.terraform-state.name
  container_access_type = "private"
}

terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-resources"
    storage_account_name = "terraformstatem1r5h"
    container_name       = "tfstate"
    key                  = "stage.terraform.tfstate"
  }
}
