terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7"
    }
  }
}

provider "random" {}

resource "random_password" "password" {
  length           = 16
  special          = true
  upper            = true
  numeric          = true
  override_special = "!@#$%"
}




