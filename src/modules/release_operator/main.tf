data "google_iam_policy" "release_operator" {
  binding {
    role = "roles/storage.objectAdmin"

    members = [
      google_service_account.release_operator.email
    ]
  }

  # TODO: pass list of additional roles
}

resource "google_service_account" "release_operator" {
  account_id   = var.release_operator_sa_id
  display_name = "Release Operator Service Account"
}

resource "google_service_account_iam_policy" "release_operator" {
  service_account_id = google_service_account.release_operator.name
  policy_data        = data.google_iam_policy.release_operator.policy_data
}

# TODO: create release operator key
