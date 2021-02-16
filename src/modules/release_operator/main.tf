resource "google_service_account" "release_operator" {
  account_id   = var.release_operator_sa_id
  display_name = "Release Operator Service Account"
  description  = "A service account authorized for CI/CD"
}

resource "google_project_iam_binding" "release_operator_cloud_storage" {
  role = "roles/storage.objectAdmin"

  members = [
    "serviceAccount:${google_service_account.release_operator.email}"
  ]
}

# TODO: create release operator key
