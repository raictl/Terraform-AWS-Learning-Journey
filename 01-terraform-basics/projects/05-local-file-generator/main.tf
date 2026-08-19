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

    Project Name: Terraform Learning Journey
    Environment: Development
    Owner: Terraform Student
  EOT
}
