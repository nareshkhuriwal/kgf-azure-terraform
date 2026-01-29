terraform {
  backend "azurerm" {
    resource_group_name  = "kgf-rg-tfstate-prod-cin-01"
    storage_account_name = "kgftfstprod01"
    container_name       = "tfstate"
    key                  = "fabric/fabric.tfstate"
  }
}
