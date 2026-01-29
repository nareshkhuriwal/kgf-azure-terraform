# Create a PostgreSQL Flexible Server
resource "azurerm_postgresql_flexible_server" "this" {
  name                = var.server_name
  resource_group_name = var.resource_group_name
  location            = var.location

  version = var.postgres_version

  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password

  sku_name     = var.sku_name
  storage_mb   = var.storage_mb
  storage_tier = var.storage_tier

  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled

  public_network_access_enabled = var.public_network_access_enabled

  tags = var.tags
}

# Allow Azure services (optional)
resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_azure" {
  count = var.allow_azure_services ? 1 : 0

  name             = "AllowAzureServices"
  server_id        = azurerm_postgresql_flexible_server.this.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

# Allow specific CIDRs (recommended for dev access)
# Converts each CIDR to a firewall rule (only supports start/end IP; we’ll enforce /32 style usage for simplicity)
# If you want true CIDR ranges, tell me and I’ll expand this with proper parsing.
resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_cidrs" {
  for_each = toset(var.allowed_cidrs)

  name      = "Allow-${replace(replace(each.value, ".", "-"), "/", "-")}"
  server_id = azurerm_postgresql_flexible_server.this.id

  # For /32, this is fine
  start_ip_address = split("/", each.value)[0]
  end_ip_address   = split("/", each.value)[0]
}


# Optional default DB
resource "azurerm_postgresql_flexible_server_database" "db" {
  name      = var.database_name
  server_id = azurerm_postgresql_flexible_server.this.id
  charset   = "UTF8"
  collation = "en_US.utf8"
}
