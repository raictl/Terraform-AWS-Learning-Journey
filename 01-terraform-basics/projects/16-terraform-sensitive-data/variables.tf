variable "application_name" {
  description = "Name of the application"
  type        = string
}

variable "username" {
  description = "Application username"
  type        = string
}

variable "password" {
  description = "Application password"
  type        = string
  sensitive   = true
}

