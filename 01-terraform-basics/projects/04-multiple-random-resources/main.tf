terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7"
    }
  }
}

provider "random" {}

resource "random_pet" "application" {
  length    = 2
  separator = "-"
}

resource "random_pet" "environment" {
  length    = 2
  separator = "-"
}

resource "random_pet" "team" {
  length    = 2
  separator = "-"
}

resource "random_pet" "project" {
  length    = 2
  separator = "-"
}
