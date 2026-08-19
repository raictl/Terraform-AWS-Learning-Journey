output "generated_password" {
  description = "Randomly generated password"
  value       = random_password.password.result
  sensitive   = true
}

