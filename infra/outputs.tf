output "preconfiguration_backend_bucket" {
  value = module.preconfiguration_backend_resources.bucket_name
}

output "project_backend_bucket" {
  value = module.project_backend_resources.bucket_name
}

output "project_release_operator_sa" {
  value = module.project_release_operator.service_account
}
