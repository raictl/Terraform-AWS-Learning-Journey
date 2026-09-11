terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "local" {}

resource "local_file" "secret_demo" {
  filename = "secret-demo.txt"

  content = <<-EOT
    Application: ${var.application_name}
    Username: ${var.username}
    Password: ${var.password}
  EOT
}

