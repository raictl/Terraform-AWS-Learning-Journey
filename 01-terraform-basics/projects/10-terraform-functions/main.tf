terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

provider "local" {}

locals {
  clean_project_name = trimspace(var.project_name)

  project_name_lower = lower(local.clean_project_name)

  project_slug = replace(local.project_name_lower, " ", "-")

  environment_upper = upper(var.environment)

  environment_length = length(var.environment)

  environments_text = join(", ", var.environments)

  formatted_title = format(
    "%s - %s Environment",
    local.clean_project_name,
    local.environment_upper
  )

  has_production = contains(
    var.environments,
    "production"
  )
}

resource "local_file" "project_info" {
  filename = "${path.module}/project-info.txt"

  content = <<-EOT
    Terraform Project Information
    ==============================

    Project Name:
    ${local.clean_project_name}

    Project Slug:
    ${local.project_slug}

    Environment:
    ${var.environment}

    Environment (Uppercase):
    ${local.environment_upper}

    Environment Length:
    ${local.environment_length}

    Available Environments:
    ${local.environments_text}

    Formatted Title:
    ${local.formatted_title}

    Production Environment Available:
    ${local.has_production}
  EOT
}

