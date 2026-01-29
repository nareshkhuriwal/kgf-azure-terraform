terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
    azapi = {
      # Prefer the official namespace casing:
      source  = "Azure/azapi"
      version = "~> 1.12"
    }
  }
}
