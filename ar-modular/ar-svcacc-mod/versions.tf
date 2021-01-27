terraform {
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = ">=0.1.0"
    }
    google-beta = {
      source = "hashicorp/google-beta"
    }
  }
  required_version = ">= 0.13"
}