terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "local" {}

module "application" {
  source = "./modules/application"

  filename = var.application_filename
  content  = var.application_content
}

module "development" {
  source = "./modules/application"

  filename = "development.txt"
  content  = "Development environment"
}

module "production" {
  source = "./modules/application"

  filename = "production.txt"
  content  = "Production environment"
}

