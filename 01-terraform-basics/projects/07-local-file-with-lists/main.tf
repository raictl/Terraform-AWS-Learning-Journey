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
    Environment: ${var.environment}
    Owner: ${var.owner}

    Team Members
    ------------

    First Team Member: ${var.team_members[0]}
    Second Team Member: ${var.team_members[1]}
    Third Team Member: ${var.team_members[2]}
    Fourth Team Member: ${var.team_members[3]}

    Total Team Members: ${length(var.team_members)}
  EOT
}

