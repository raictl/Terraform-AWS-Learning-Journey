variable "project_name" {
  description = "Name of the Terraform project"
  type        = string
  default     = "Terraform Learning Journey"
}

variable "environment" {
  description = "Environment where the project is running"
  type        = string
  default     = "development"
}

variable "owner" {
  description = "Person or team responsible for the project"
  type        = string
  default     = "Terraform Student"
}

