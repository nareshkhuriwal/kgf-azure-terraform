# -------------------------
# Core
# -------------------------
variable "location" {
  type        = string
  description = "Azure region"
  default     = "Central India"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group for all resources"
  default     = "rg-fabric-prod"
}

variable "tags" {
  type        = map(string)
  description = "Common tags applied to resources"
  default = {
    env     = "dev"
    project = "aca-fastapi"
  }
}

# -------------------------
# Fabric
# -------------------------
variable "fabric_capacity_name" {
  type        = string
  description = "Microsoft Fabric capacity resource name"
  default     = "kgffabcapprodcin01"
}

variable "fabric_sku" {
  type        = string
  description = "Fabric capacity SKU (e.g., F2, F4, F8, F16, etc.)"
  default     = "F16"

  validation {
    condition     = can(regex("^F[0-9]+$", var.fabric_sku))
    error_message = "fabric_sku must look like F16, F8, F64 etc."
  }
}

variable "capacity_admin_object_id" {
  type        = string
  description = "Azure AD Object ID of Fabric Capacity Administrator"
}

variable "fabric_admin_members" {
  type        = list(string)
  description = "Admins for the Fabric capacity (UPN emails)."
  default     = []
}

# -------------------------
# PostgreSQL Flexible Server
# -------------------------
variable "pg_server_name" {
  type        = string
  description = "PostgreSQL flexible server name (lowercase letters/numbers/hyphen, start with letter)"
  default     = "kgfpgdevcin01"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,62}$", var.pg_server_name))
    error_message = "pg_server_name must be 3-63 chars, start with a letter, and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "pg_database_name" {
  type        = string
  description = "Default database name to create"
  default     = "appdb"
}

variable "pg_admin_user" {
  type        = string
  description = "PostgreSQL admin username"
  default     = "pgadmin"
}

variable "pg_admin_password" {
  type        = string
  description = "PostgreSQL admin password"
  sensitive   = true
}

variable "pg_allowed_cidrs" {
  type        = list(string)
  description = "Allowed client IPs in CIDR format (recommend /32 for a single IP)"
  default     = []
}

# -------------------------
# Container Apps (kgfhubapi)
# -------------------------
variable "aca_environment_name" {
  type        = string
  description = "Azure Container Apps environment name"
  default     = "aca-env-dev"
}

variable "aca_container_app_name" {
  type        = string
  description = "Container App name"
  default     = "kgfhubapi-dev"
}

variable "aca_dockerhub_image" {
  type        = string
  description = "Docker Hub image like docker.io/<user>/<repo>:<tag> (or <user>/<repo>:<tag>)"

  validation {
    condition     = length(trimspace(var.aca_dockerhub_image)) > 0
    error_message = "aca_dockerhub_image is required (example: docker.io/myuser/myapi:latest)."
  }
}


variable "aca_container_port" {
  type        = number
  description = "Port your FastAPI container listens on"
  default     = 8000
}

variable "aca_cpu" {
  type        = number
  description = "vCPU for Container App container"
  default     = 0.25
}

variable "aca_memory" {
  type        = string
  description = "Memory for Container App container (e.g. 0.5Gi, 1.0Gi)"
  default     = "0.5Gi"
}

variable "aca_max_replicas" {
  type        = number
  description = "Maximum number of replicas"
  default     = 1
}

variable "aca_concurrent_requests" {
  type        = number
  description = "KEDA HTTP scaling threshold - concurrent requests"
  default     = 20
}

variable "aca_env_vars" {
  type        = map(string)
  description = "Environment variables for the container"
  default     = {}
}
