provider "azurerm" {
  version = "=2.7.0"
  features {}
}

resource "azurerm_resource_group" "terraform" {
  name     = "terraform-resources"
  location = "West Europe"
}

# terraform {
#   backend "azurerm" {
#     resource_group_name  = "terraform-resources"
#     storage_account_name = "terraformstatem1r5h"
#     container_name       = "tfstate"
#     key                  = "stage.compute.terraform.tfstate"
#   }
# }


resource "azurerm_virtual_network" "terraform" {
  name                = "terraform-network"
  resource_group_name = azurerm_resource_group.terraform.name
  location            = azurerm_resource_group.terraform.location
  address_space       = ["10.1.0.0/16"]
}

# resource "azurerm_subnet" "example" {
#   name                 = "internal"
#   resource_group_name  = azurerm_resource_group.example.name
#   virtual_network_name = azurerm_virtual_network.example.name
#   address_prefix       = "10.0.2.0/24"
# }