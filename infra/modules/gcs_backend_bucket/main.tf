resource "google_storage_bucket" "tfstate" {
  location = var.tfstate_bucket_location
  name     = var.tfstate_bucket_name

  force_destroy = false

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}
