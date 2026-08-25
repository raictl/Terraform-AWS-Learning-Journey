variable "project_name" {
  description = "Name of the Terraform project"
  type        = string
  default     = "Terraform Portfolio"
}

variable "project_settings" {
  description = "Configuration settings for the Terraform project"
  type        = map(string)

  default = {
    environment = "development"
    owner       = "DevOps Student"
    department  = "Engineering"
    application = "Terraform Learning"
  }
}


