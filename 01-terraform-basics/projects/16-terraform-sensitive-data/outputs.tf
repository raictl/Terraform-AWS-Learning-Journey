output "application_name" {
  description = "Application name"
  value       = var.application_name
}

output "username" {
  description = "Application username"
  value       = var.username
}

output "password" {
  description = "Application password"
  value       = var.password
  sensitive   = true
}



