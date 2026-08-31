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
  #environment_level = var.environment == "production" ? "HIGH" : "LOW"
  environment_level = var.environment == "production" ? "HIGH" : var.environment == "staging" ? "MEDIUM" : "LOW"

  backup_required = var.environment == "production" ? "YES" : "NO"

  monitoring_level = var.environment == "production" ? "24x7" : "BUSINESS_HOURS"
}

resource "local_file" "environment_report" {
  filename = "${path.module}/environment-report.txt"

  content = <<-EOT
    Terraform Environment Report
    =============================

    Project Name: ${var.project_name}
    Environment: ${var.environment}

    Environment Level: ${local.environment_level}
    Backup Required: ${local.backup_required}
    Monitoring Level: ${local.monitoring_level}
  EOT
}





