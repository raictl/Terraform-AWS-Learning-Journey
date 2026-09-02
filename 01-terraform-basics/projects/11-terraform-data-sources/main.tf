terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

provider "local" {}

data "local_file" "application_info" {
  filename = "${path.module}/${var.application_file}"
}

data "local_file" "server_info" {
  filename = "${path.module}/data/application-info.txt"
}



locals {
  application_content = data.local_file.application_info.content
}


