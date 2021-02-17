output "service_account" {
  value = google_service_account.release_operator.email
}

output "as_member" {
  value = "serviceAccount:${google_service_account.release_operator.email}"
}
