terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "local" {}

locals {
  environment_message = {
    default    = "This is the default environment."
    dev        = "This is the development environment."
    staging    = "This is the staging environment."
    production = "This is the production environment."
  }
}

resource "local_file" "workspace_demo" {
  filename = "workspace-${terraform.workspace}.txt"

  content = <<-EOT
    Terraform Workspace: ${terraform.workspace}

    ${local.environment_message[terraform.workspace]}
  EOT
}

