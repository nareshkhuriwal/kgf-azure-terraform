# Root RG (already exists)
resource "azurerm_resource_group" "fabric" {
  name     = var.resource_group_name
  location = var.location
}

# Fabric module (already exists)
module "fabric" {
  source                   = "./modules/fabric"
  rg_name                  = azurerm_resource_group.fabric.name
  location                 = var.location
  capacity_name            = var.fabric_capacity_name
  sku                      = var.fabric_sku
  capacity_admin_object_id = var.capacity_admin_object_id
  admin_members            = var.fabric_admin_members

  providers = {
    azapi   = azapi
    azurerm = azurerm
  }
}

# Postgres module (already exists)
module "postgres" {
  source              = "./modules/postgres_flex"
  resource_group_name = azurerm_resource_group.fabric.name
  location            = var.location

  server_name            = var.pg_server_name
  administrator_login    = var.pg_admin_user
  administrator_password = var.pg_admin_password

  sku_name     = "B_Standard_B1ms"
  storage_mb   = 32768
  storage_tier = "P4"

  backup_retention_days        = 7
  geo_redundant_backup_enabled = false

  public_network_access_enabled = true
  allow_azure_services          = true
  allowed_cidrs                 = var.pg_allowed_cidrs

  database_name = var.pg_database_name
  tags          = var.tags
}


# ✅ Create Container Apps Environment in ROOT (one per env)
resource "azurerm_container_app_environment" "kgf_env" {
  name                = var.aca_environment_name
  location            = var.location
  resource_group_name = azurerm_resource_group.fabric.name
  tags                = var.tags
}

# ✅ KGF Hub API module call (uses existing env)
module "kgfhubapi" {
  source = "./modules/kgfhubapi"

  resource_group_name          = azurerm_resource_group.fabric.name
  location                     = var.location
  container_app_environment_id = azurerm_container_app_environment.kgf_env.id
  container_app_name           = var.aca_container_app_name
  environment_name             = var.aca_environment_name

  dockerhub_image     = var.aca_dockerhub_image
  container_port      = var.aca_container_port
  cpu                 = var.aca_cpu
  memory              = var.aca_memory
  max_replicas        = var.aca_max_replicas
  concurrent_requests = var.aca_concurrent_requests

  env_vars = merge(
    var.aca_env_vars,
    {
      POSTGRES_HOST    = module.postgres.fqdn
      POSTGRES_DB      = module.postgres.database_name
      POSTGRES_USER    = module.postgres.admin_user
      POSTGRES_PORT    = "5432"
      POSTGRES_SSLMODE = "require"
    }
  )

  tags = var.tags

  providers = {
    azurerm = azurerm
  }

  depends_on = [module.postgres]
}
