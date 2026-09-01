output "clean_project_name" {
  description = "Project name after removing extra spaces"
  value       = local.clean_project_name
}

output "project_slug" {
  description = "URL-friendly project name"
  value       = local.project_slug
}

output "environment_upper" {
  description = "Environment in uppercase"
  value       = local.environment_upper
}

output "environment_length" {
  description = "Number of characters in the environment name"
  value       = local.environment_length
}

output "environments_text" {
  description = "Environments joined into a single string"
  value       = local.environments_text
}

output "formatted_title" {
  description = "Formatted project title"
  value       = local.formatted_title
}

output "has_production" {
  description = "Whether production is available"
  value       = local.has_production
}


