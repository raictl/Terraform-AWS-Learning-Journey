terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

provider "local" {}

resource "local_file" "application" {
  filename = "${path.module}/application.txt"

  content = <<-EOT
    Application: Terraform Provisioner Demo
    Environment: ${var.environment}
    Managed By: Terraform
EOT

  provisioner "local-exec" {
    command = "echo Terraform provisioner executed successfully > ${path.module}/provisioner.log"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo Application resource destroyed > ${path.module}/destroy.log"
  }
}

