# Project Preconfigure IaC Recipe

This recipe is an Infrastructure as Code (IaC) recipe for preconfiguring a cloud project, and bootstraps the Google Cloud Platform provider.

Configurations here include:

- API enablements
- CI/CD service account
- Terraform state bucket

Additionally, the repository is configured with GitHub Actions to lint source
code. This repository intentionally does not have automated releases, as the
preconfiguration contains resources that should be run rarely by an authorized
user.
