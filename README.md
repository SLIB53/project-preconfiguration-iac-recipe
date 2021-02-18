# Project Preconfiguration IaC Recipe

This recipe is an Infrastructure as Code (IaC) recipe for preconfiguring a
cloud project in Google Cloud Platform (GCP).

The infrastructure managed here consists of:

- API enablements
- Terraform backend resources
- Release Operator

Additionally, the repository is configured with GitHub Actions for linting.
Since the preconfiguration contains IAM resources, this repository does not
have automated releases, and it only should be run by an operator sufficiently
authorized in IAM.

## Setup

This guide will begin from a local backend for Terraform, and then migrate to a
remote backend (GCS).

For each environment, follow through to the end of remote backend migration in
order to:

- avoid conflating environments
- ensure that setup is possible in lower environments before attempting
  setup in higher environments

Run through setup from the [infra folder](./infra):

```sh
cd infra
```

### Initial Deployment

Firstly, you will need to run `init`:

```sh
terraform init
```

Now you may run `plan` or `apply`:

```sh
terraform apply
```

<sub>Hint: Only an authorized machine can modify GCP resources. Try
running `gcloud auth application-default login`.</sub>

### Migrating to Remote Backend

The recipe initially uses a local backend. While you can run this locally at
first, you should eventually migrate to a remote backend, such as [gcs
backend][terraform-gcs-backend].

Before you begin, take note of the preconfiguration backend bucket:

```sh
terraform output preconfiguration_backend_bucket
```

Now add the GCS backend to [main.tf](./src/main.tf):

```
terraform {
  backend "gcs" {}
}
```

Lastly, rerun `init` and pass the preconfiguration backend bucket in a
[partial backend configuration][terraform-backend-partial-configuration]:

```sh
terraform init # interactive partial backend configuration
```

<sub>Hint: If you are receiving intialization errors, ensure you are in the
[infra folder](./infra).</sub>

### End of Setup

Setup is complete, but please take note of the variables and outputs
(especially the `preconfiguration_backend_bucket`, which you can use to recover
the variables and outputs).

**You will need to run through this setup independently for each environment.
Consider using a branching strategy such as [GitHub Flow][github-flow-guide] to
manage releases across environments.**

## Usage

The resources created in this preconfiguration will help to bootstrap
the main IaC repository quickly. You will need:

- the project backend bucket
- private key of the Release Operator (for setting up CI/CD)

To see the project backend bucket, use `output`:

```sh
terraform output project_backend_bucket
```

To get a key for the Release Operator, create one using `gcloud`:

```sh
gcloud iam service-accounts keys create ~/release_operator_key.json \
  --iam-account `terraform output -raw project_release_operator_sa`
```

[terraform-gcs-backend]: https://www.terraform.io/docs/language/settings/backends/gcs.html "Terraform GCS Backend Documentation"
[terraform-backend-partial-configuration]: https://www.terraform.io/docs/language/settings/backends/configuration.html#partial-configuration
[github-flow-guide]: https://guides.github.com/introduction/flow/
