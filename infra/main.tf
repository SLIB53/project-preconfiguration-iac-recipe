# terraform {
#   backend "gcs" {}
# }

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

# TODO: configure default SA for production grade environments
# resource "google_project_default_service_accounts" "default_service_account_reconfiguration" {
#   project = var.gcp_project_id

#   action = "DEPRIVILEGE"
# }

module "api_enablements" {
  source = "./modules/api_enablements"
}

module "preconfiguration_backend_resources" {
  source = "./modules/gcs_backend_bucket"

  tfstate_bucket_location = var.preconfiguration_tfstate_bucket_location
  tfstate_bucket_name     = var.preconfiguration_tfstate_bucket_name
}

module "project_backend_resources" {
  source = "./modules/gcs_backend_bucket"

  tfstate_bucket_location = var.project_tfstate_bucket_location
  tfstate_bucket_name     = var.project_tfstate_bucket_name
}

module "project_release_operator" {
  source = "./modules/release_operator"

  release_operator_sa_id = var.project_release_operator_sa_id
}

resource "google_storage_bucket_iam_member" "release_operator_backend_access" {
  bucket = module.project_backend_resources.bucket_name
  role   = "roles/storage.objectAdmin"

  member = module.project_release_operator.as_member
}

resource "google_project_iam_member" "release_operator_cloud_run_access" {
  role = "roles/run.admin"

  member = module.project_release_operator.as_member
}

resource "google_service_account_iam_binding" "release_operator_default_compute_user" {
  service_account_id = "projects/${var.gcp_project_id}/serviceAccounts/${var.gcp_project_number}-compute@developer.gserviceaccount.com"
  role               = "roles/iam.serviceAccountUser"

  members = [
    module.project_release_operator.as_member
  ]
}
