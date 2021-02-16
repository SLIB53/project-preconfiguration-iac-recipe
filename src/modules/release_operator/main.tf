resource "google_service_account" "release_operator" {
  account_id   = var.release_operator_sa_id
  display_name = "Release Operator Service Account"
  description  = "This service account is authorized for deployments."
}

resource "google_service_account_key" "release_operator_credentials" {
  service_account_id = google_service_account.release_operator.name
}
