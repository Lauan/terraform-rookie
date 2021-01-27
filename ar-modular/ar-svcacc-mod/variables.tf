variable "k8s_namespace" {
  type = string
}

variable "az_project" {
  type = string
}

variable "gcp_project" {
  type = string
}

variable "gcp_repository_location" {
  type = string
  default = "southamerica-east1" #or whatever you want
}