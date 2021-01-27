##################################################################################
# ROBOT PUSH
##################################################################################

#Cria a Service Account RobotPush (envio de imagens para o registry)
resource "google_service_account" "robotpush" {
  provider = google-beta
  account_id   = "robotpush"
  display_name = "Repository Push Service Account"
}

#Gera a chave de autenticação do RobotPush
resource "google_service_account_key" "pushkey" {
  service_account_id = google_service_account.robotpush.name
}

##################################################################################
# ROBOT PULL
##################################################################################

#Cria a Service Account RobotPull (download de imagens do registry)
resource "google_service_account" "robotpull" {
  provider = google-beta
  account_id   = "robotpull"
  display_name = "Repository Pull Service Account"
}

#Gera a chave de autenticação do RobotPull
resource "google_service_account_key" "pullkey" {
  service_account_id = google_service_account.robotpull.name
}

##################################################################################
# DATA AZURE
##################################################################################

data "azuredevops_project" "totvsapps" {
  name = var.az_project
}

##################################################################################
# RESOURCES AZURE
##################################################################################

resource "azuredevops_serviceendpoint_dockerregistry" "dockerhubregistry" {
    project_id             = data.azuredevops_project.totvsapps.id
    service_endpoint_name  = "registry-${var.k8s_namespace}-pull"
    docker_registry        = "https://${var.gcp_repository_location}-docker.pkg.dev/${var.gcp_project}"
    docker_username        = "_json_key_base64"
    docker_password        = google_service_account_key.pullkey.private_key
    registry_type          = "Others"
}