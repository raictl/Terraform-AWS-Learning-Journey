output "environment" {
  description = "Current deployment environment"
  value       = var.environment
}

output "environment_level" {
  description = "Calculated environment level"
  value       = local.environment_level
}

output "backup_required" {
  description = "Whether backups are required"
  value       = local.backup_required
}

output "monitoring_level" {
  description = "Calculated monitoring level"
  value       = local.monitoring_level
}

output "is_production" {
  description = "Whether the current environment is production"
  value       = var.environment == "production"
}



