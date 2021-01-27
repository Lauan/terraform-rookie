provider "google-beta" {
  project    = var.gcp_project
  region     = var.gcp_resource_region
}

provider "azuredevops" {
  org_service_url = var.az_org_url
  personal_access_token = var.az_auth_token
}

module "svcaccounts" {
  source              = "../ar-svcacc-mod"
  k8s_namespace       = var.k8s_namespace
  gcp_project         = var.gcp_project
}

module "arrepos" {
  depends_on            = [module.svcaccounts]
  for_each              = toset(var.repositories)
  repository            = each.key
  source                = "../ar-repo-mod"
  gcp_project           = var.gcp_project
  pull_service_account  = module.svcaccounts.pull_service_account
  push_service_account  = module.svcaccounts.push_service_account
}