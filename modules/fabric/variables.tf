variable "rg_name" { type = string }
variable "location" { type = string }
variable "capacity_name" { type = string }
variable "sku" { type = string }
variable "capacity_admin_object_id" {}
variable "admin_members" {
  type        = list(string)
  description = "Fabric capacity admins (usually AAD UPN emails). Must not be empty."
}
