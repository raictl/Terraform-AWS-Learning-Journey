output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.devops_server.id
}

output "instance_type" {
  description = "EC2 instance type"
  value       = aws_instance.devops_server.instance_type
}

output "private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.devops_server.private_ip
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.devops_server.public_ip
}
