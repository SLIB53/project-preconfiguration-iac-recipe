variable "gcp_project_id" {
  type        = string
  description = "The Google Cloud Platform project id"
}

variable "gcp_project_number" {
  type        = string
  description = "The Google Cloud Platform project number"
}

variable "gcp_region" {
  type        = string
  default     = "us-central1"
  description = "The default Google Cloud Platform region"
}

variable "preconfiguration_tfstate_bucket_name" {
  type        = string
  description = "The Cloud Storage bucket used to store the 'preconfiguration' Terraform state (Use this as the GCS backend bucket.)"
}

variable "preconfiguration_tfstate_bucket_location" {
  type    = string
  default = "us"
}

variable "project_tfstate_bucket_name" {
  type        = string
  description = "The Cloud Storage bucket used to store the project's Terraform state (Use this as the GCS backend bucket.)"
}

variable "project_tfstate_bucket_location" {
  type    = string
  default = "us"
}

variable "project_release_operator_sa_id" {
  type        = string
  default     = "release-operator"
  description = "Used for the service account id of release operator service account. (Use this service account for automation.)"
}
