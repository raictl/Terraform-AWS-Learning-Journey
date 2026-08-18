terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7"
    }
  }
}

provider "random" {}

resource "random_pet" "name" {
  length    = 4
  separator = "__"
}
