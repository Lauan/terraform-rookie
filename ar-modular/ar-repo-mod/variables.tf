variable "repository" {
  type = string
}

variable "user_role_type" {
  type = map
  default = {
    "pull" = "reader"
    "push" = "writer"
  }
}

variable "gcp_project" {
  type = string
}

variable "gcp_repository_location" {
  type = string
  default = "southamerica-east1" #Or whatever you want
}

variable "pull_service_account" {}
variable "push_service_account" {}
