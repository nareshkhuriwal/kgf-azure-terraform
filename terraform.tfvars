# -------------------------
# Core
# -------------------------
location            = "Central India"
resource_group_name = "rg-fabric-prod"

# -------------------------
# Fabric
# -------------------------
fabric_capacity_name     = "kgffabcapprodcin01"
fabric_sku               = "F16"
capacity_admin_object_id = "43698186-9d6a-4cbf-8a7b-443379b2f24c"
fabric_admin_members     = ["naresh@khuriwalgroup.com"]

# -------------------------
# PostgreSQL Flexible Server
# -------------------------
pg_server_name    = "kgfpgdevcin01"
pg_database_name  = "appdb"
pg_admin_user     = "pgadmin"
pg_admin_password = "Khurwal@12345!"
pg_allowed_cidrs  = ["27.58.11.134/32"]

# -------------------------
# Container Apps (kgfhubapi)
# -------------------------
# REQUIRED: set your Docker Hub image
aca_dockerhub_image = "docker.io/6234488/kgf-ecart-api:amd64"

# Optional overrides (keep defaults if you don't want to set these)
aca_environment_name    = "aca-env-dev"
aca_container_app_name  = "kgfhubapi-dev"
aca_container_port      = 8000
aca_cpu                 = 0.25
aca_memory              = "0.5Gi"
aca_max_replicas        = 1
aca_concurrent_requests = 20

aca_env_vars = {
  ENV = "dev"
}
