output "application_name" {
  description = "Generated application name"
  value       = random_pet.application.id
}

output "environment_name" {
  description = "Generated environment name"
  value       = random_pet.environment.id
}

output "team_name" {
  description = "Generated team name"
  value       = random_pet.team.id
}

output "project_name" {
  description = "Generated project name"
  value       = random_pet.project.id
}
