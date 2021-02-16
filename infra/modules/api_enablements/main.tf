resource "google_project_service" "cloud_storage_api_enablement" {
  service                    = "storage.googleapis.com"
  disable_dependent_services = true
}
