variable "project_name" {
  description = "Name of the Terraform project"
  type        = string
  default     = "Terraform Portfolio"
}

variable "environment" {
  description = "Environment where the project is running"
  type        = string
  default     = "development"
}

variable "owner" {
  description = "Person or team responsible for the project"
  type        = string
  default     = "DevOps Student"
}

variable "team_members" {
  description = "List of team members working on the project"
  type        = list(string)

  default = [
    "Ashu",
    "Karan",
    "gaurav",
    "Ravi"
  ]
}

