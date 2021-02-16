# terraform {
#   backend "gcs" {}
# }

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

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
