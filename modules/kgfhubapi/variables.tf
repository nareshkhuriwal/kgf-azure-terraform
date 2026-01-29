variable "resource_group_name" { type = string }
variable "location" { type = string }

variable "environment_name" { type = string }
variable "container_app_name" { type = string }

variable "dockerhub_image" { type = string }
variable "container_port" { type = number }

variable "cpu" { type = number }
variable "memory" { type = string }

variable "max_replicas" { type = number }
variable "concurrent_requests" { type = number }

variable "env_vars" {
  type    = map(string)
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "container_app_environment_id" {
  type        = string
  description = "Existing Container Apps Environment ID"
}
