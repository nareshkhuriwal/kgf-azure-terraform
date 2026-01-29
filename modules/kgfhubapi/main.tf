resource "azurerm_container_app" "app" {
  name                         = var.container_app_name
  resource_group_name          = var.resource_group_name
  container_app_environment_id = var.container_app_environment_id
  revision_mode                = "Single"

  ingress {
    external_enabled           = true
    target_port                = var.container_port
    transport                  = "auto"
    allow_insecure_connections = false

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  template {
    # ✅ scale-to-zero
    min_replicas = 0
    max_replicas = var.max_replicas

    container {
      name   = "api"
      image  = var.dockerhub_image
      cpu    = var.cpu
      memory = var.memory

      dynamic "env" {
        for_each = var.env_vars
        content {
          name  = env.key
          value = env.value
        }
      }
    }
  }

  tags = var.tags
}
