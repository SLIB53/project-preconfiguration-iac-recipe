output "preconfiguration_backend_bucket" {
  value = module.preconfiguration_backend_resources.bucket_name
}

output "project_backend_bucket" {
  value = module.project_backend_resources.bucket_name
}
