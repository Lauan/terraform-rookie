variable "repositories" {
  type = list(string)
}

variable "gcp_resource_region" {
  type = string
  default = "us-west1-a" #or whatever you want"
}

variable "az_org_url" {
  type = string
}

variable "az_auth_token" {
  description = "Token de autenticação Azure DevOps"
}

variable "gcp_project" {
  type = string
}

variable "k8s_namespace" {
  type = string
}