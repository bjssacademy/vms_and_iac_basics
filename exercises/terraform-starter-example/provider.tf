# Leave this as it is

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
  }
}
provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}
