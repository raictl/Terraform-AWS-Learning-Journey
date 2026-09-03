output "application_file" {
  description = "Path of the application file"
  value       = local_file.application.filename
}

output "provisioner_log" {
  description = "Path of the provisioner log"
  value       = "${path.module}/provisioner.log"
}


