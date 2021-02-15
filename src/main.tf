provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

module "api_enablements" {
  source = "./modules/api_enablements"
}

module "preconfigure_backend_resources" {
  source = "./modules/gcs_backend_bucket"

  tfstate_bucket_location = var.preconfigure_tfstate_bucket_location
  tfstate_bucket_name     = var.preconfigure_tfstate_bucket_name
}


# TODO: output bucket for migration use case
module "project_backend_resources" {
  source = "./modules/gcs_backend_bucket"

  tfstate_bucket_location = var.project_tfstate_bucket_location
  tfstate_bucket_name     = var.project_tfstate_bucket_name
}

module "project_release_operator" {
  source = "./modules/release_operator"

  release_operator_sa_id = var.project_release_operator_sa_id
}
