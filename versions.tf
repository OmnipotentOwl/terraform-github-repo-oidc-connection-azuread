terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.31.0"
    }
    github = {
      source  = "integrations/github"
      version = ">= 5.13.0"
    }
  }
  required_version = ">= 1.3.0"
}
