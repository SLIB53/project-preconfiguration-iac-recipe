# Project Preconfiguration IaC Recipe

This recipe is an Infrastructure as Code (IaC) recipe for preconfiguring a
cloud project in Google Cloud Platform (GCP).

The infrastructure managed here consists of:

- API enablements
- Terraform backend resources
- Release Operator

Additionally, the repository is configured with GitHub Actions for linting and
validation. Since the preconfiguration contains IAM resources, this repository
does not have automated releases and should be run only by an operator
sufficiently authorized in IAM.

## Setup

Set the Terraform workspace per the environment:

```sh
export CLOUD_ENVIRONMENT="testing" # e.g. testing, staging, production
```

```sh
terraform workspace new $CLOUD_ENVIRONMENT
terraform workspace select $CLOUD_ENVIRONMENT
```

Run `init`:

```sh
terraform init src
```

Now you may run `plan` or `apply`:

```sh
terraform plan src
```

```sh
terraform apply src
```

<sub>Hint: You will need to be authorized for modifying your GCP project. Try running `gcloud auth application-default login`.</sub>

<!-- TODO: finish remote backend environment howto -->

<!-- ### Migrating to Remote Backend

The first time this recipe is used, the backend will be external. You can run
this locally at first, and then it can be migrated to the
[gcs backend][terraform-gcs-backend].

[terraform-gcs-backend]: https://www.terraform.io/docs/language/settings/backends/gcs.html "Terraform GCS Backend Documentation" -->

<!-- TODO: GitHub Actions setup -->
