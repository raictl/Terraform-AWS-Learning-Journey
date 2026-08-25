output "project_name" {
  description = "Configured project name"
  value       = var.project_name
}

output "project_settings" {
  description = "Project configuration settings"
  value       = var.project_settings
}

output "environment" {
  description = "Project environment"
  value       = var.project_settings["environment"]
}

output "owner" {
  description = "Project owner"
  value       = var.project_settings["owner"]
}

output "settings_count" {
  description = "Number of project settings"
  value       = length(var.project_settings)
}

output "setting_keys" {
  description = "Keys available in the project settings map"
  value       = keys(var.project_settings)
}

output "setting_values" {
  description = "Values available in the project settings map"
  value       = values(var.project_settings)
}
