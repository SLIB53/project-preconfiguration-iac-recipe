# Project Preconfigure IaC Recipe

This recipe is an Infrastructure as Code (IaC) recipe for preconfiguring a cloud project for Google Cloud Platform.

The infrastructure managed here consists of:

- API enablements
- Terraform backend resources
- Release Operator

Additionally, the repository is configured with GitHub Actions for linting and
validation. Since the preconfiguration contains sensitive resources, this
repository does not have automated releases and should be run by only an
authorized operator.

## Usage

Set the Terraform workspace per the environment:

```sh
cd src

export TF_WORKSPACE_NAME="insert-workspace-name" # e.g. testing, staging, production
terraform workspace new $TF_WORKSPACE_NAME
terraform workspace select $TF_WORKSPACE_NAME
```

Remember to run `init`:

```sh
terraform init
```

Now you may run `terraform apply`:

```sh
# TODO: terraform apply with appropriate tfvars
```

### Migrating to Remote Backend

The first time this recipe is used, the backend will be local. You will
need to run this locally at first, and then it can be migrated to the [gcs backend][terraform-gcs-backend].

<!-- TODO: add remote backend environment howto -->

[terraform-gcs-backend]: https://www.terraform.io/docs/language/settings/backends/gcs.html "Terraform GCS Backend Documentation"
