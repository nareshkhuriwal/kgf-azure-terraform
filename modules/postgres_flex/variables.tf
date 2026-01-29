variable "resource_group_name" { type = string }
variable "location" { type = string }

variable "server_name" {
  type        = string
  description = "PostgreSQL flexible server name (lowercase, letters/numbers/hyphen, start with letter)."
}

variable "administrator_login" {
  type        = string
  description = "Admin username (lowercase)."
  default     = "pgadmin"
}

variable "administrator_password" {
  type        = string
  sensitive   = true
  description = "Admin password for PostgreSQL."
}

variable "postgres_version" {
  type    = string
  default = "16"
}

# Matches screenshot: Burstable B1ms (1 vCore, 2GiB)
variable "sku_name" {
  type    = string
  default = "B_Standard_B1ms"
}

# Matches screenshot: 32 GiB
variable "storage_mb" {
  type    = number
  default = 32768
}

# Keep cheap dev defaults
variable "backup_retention_days" {
  type    = number
  default = 7
}

variable "geo_redundant_backup_enabled" {
  type    = bool
  default = false
}

# Storage performance tier for IOPS (keep low/cheap)
# Terraform supports tiers like P4/P6/P10... for flexible server storage_tier
variable "storage_tier" {
  type    = string
  default = "P4"
}

# Public access for dev (simplest)
variable "public_network_access_enabled" {
  type    = bool
  default = true
}

# Firewall
# Set allow_azure_services=true to allow connections from Azure services (0.0.0.0 rule).
variable "allow_azure_services" {
  type    = bool
  default = true
}

# Example: ["1.2.3.4/32"] to allow your home/office IP
variable "allowed_cidrs" {
  type    = list(string)
  default = []
}

# Optional: create a default database
variable "database_name" {
  type    = string
  default = "appdb"
}

variable "tags" {
  type    = map(string)
  default = {}
}
