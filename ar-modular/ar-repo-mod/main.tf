##################################################################################
# RESOURCES GCP
##################################################################################

#Ativa a API do Artifact Registry caso ainda não esteja ativada
resource "google_project_service" "artifactregistry" {
  project = var.gcp_project
  service = "artifactregistry.googleapis.com"

  disable_dependent_services = true
  disable_on_destroy = true
}

#Cria o repositório no Artifact Registry
resource "google_artifact_registry_repository" "ar-repo" {

  provider = google-beta
  location = var.gcp_repository_location
  project = var.gcp_project
  repository_id = var.repository
  format = "DOCKER"
  
  depends_on = [google_project_service.artifactregistry]
}

##################################################################################
# ROBOT PUSH
##################################################################################

#Aplica a permissão no repositório criado
resource "google_artifact_registry_repository_iam_member" "robotpush-iam" {
  provider = google-beta
  
  repository = google_artifact_registry_repository.ar-repo.name

  location = var.gcp_repository_location
  role   = "roles/artifactregistry.${var.user_role_type["push"]}"
  member = "serviceAccount:${var.push_service_account}"
}

##################################################################################
# ROBOT PULL
##################################################################################

#Aplica a permissão no repositório criado
resource "google_artifact_registry_repository_iam_member" "robotpull-iam" {
  provider = google-beta
  
  repository = google_artifact_registry_repository.ar-repo.name
  
  location = var.gcp_repository_location
  role   = "roles/artifactregistry.${var.user_role_type["pull"]}"
  member = "serviceAccount:${var.pull_service_account}"
}