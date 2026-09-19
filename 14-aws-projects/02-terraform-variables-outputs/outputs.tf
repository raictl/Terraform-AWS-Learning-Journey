output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.devops_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.devops_server.public_ip
}

output "instance_type" {
  description = "EC2 instance type"
  value       = aws_instance.devops_server.instance_type
}

output "environment" {
  description = "Environment of the EC2 instance"
  value       = var.environment
}
