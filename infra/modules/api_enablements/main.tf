resource "google_project_service" "cloud_storage_api_enablement" {
  service                    = "storage.googleapis.com"
  disable_dependent_services = true
}

resource "google_project_service" "cloud_run_api_enablement" {
  service                    = "run.googleapis.com"
  disable_dependent_services = true
}
