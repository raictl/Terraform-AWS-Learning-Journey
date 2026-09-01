variable "project_name" {
  description = "Name of the Terraform project"
  type        = string

  default = "Terraform Portfolio"
}

variable "environment" {
  description = "Current deployment environment"
  type        = string

  validation {
    condition = contains(
      ["development", "staging", "production"],
      var.environment
    )

    error_message = "Environment must be development, staging, or production."
  }

  default = "development"
}

variable "environments" {
  description = "List of supported environments"
  type        = list(string)

  default = [
    "development",
    "staging",
    "production"
  ]
}

