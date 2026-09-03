variable "environment" {
  description = "Deployment environment"
  type        = string

  default = "development"

  validation {
    condition = contains(
      ["development", "staging", "production"],
      var.environment
    )

    error_message = "Environment must be development, staging, or production."
  }
}

