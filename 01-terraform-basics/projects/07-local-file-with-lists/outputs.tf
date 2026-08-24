output "project_name" {
  description = "Configured project name"
  value       = var.project_name
}

output "environment" {
  description = "Configured environment"
  value       = var.environment
}

output "team_members" {
  description = "List of project team members"
  value       = var.team_members
}

output "team_member_count" {
  description = "Number of project team members"
  value       = length(var.team_members)
}

