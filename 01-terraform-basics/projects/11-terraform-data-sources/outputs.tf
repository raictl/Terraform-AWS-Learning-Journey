output "application_file_path" {
  description = "Path of the existing application information file"
  value       = data.local_file.application_info.filename
}

output "application_content" {
  description = "Content read from the existing application information file"
  value       = data.local_file.application_info.content
}

output "application_content_from_local" {
  description = "Application content accessed through a local value"
  value       = local.application_content
}



output "server_information" {
  description = "Information read from the existing server information file"
  value       = data.local_file.server_info.content
}
