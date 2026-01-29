data "azurerm_client_config" "current" {}

resource "azapi_resource" "fabric_capacity" {
  type      = "Microsoft.Fabric/capacities@2023-11-01"
  name      = var.capacity_name
  location  = var.location
  parent_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.rg_name}"

  # keep this if schema validation complains about SKU format
  schema_validation_enabled = false

  body = jsonencode({
    sku = {
      name = var.sku
      tier = "Fabric"
    }

    properties = {
      administration = {
        members = var.admin_members
      }
    }
  })
}
