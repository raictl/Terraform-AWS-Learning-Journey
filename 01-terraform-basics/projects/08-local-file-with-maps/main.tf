terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

provider "local" {}

resource "local_file" "project_info" {
  filename = "${path.module}/terraform-project-info.txt"

  content = <<-EOT
    Terraform Project Information
    =============================

    Project Name: ${var.project_name}

    Project Settings
    ----------------

    Environment: ${var.project_settings["environment"]}
    Owner: ${var.project_settings["owner"]}
    Department: ${var.project_settings["department"]}
    Application: ${var.project_settings["application"]}

    Total Settings: ${length(var.project_settings)}
  EOT
}
