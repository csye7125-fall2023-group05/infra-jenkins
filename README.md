# Infrastructure setup for Jenkins

[![Terraform IaC template validation for Jenkins](https://github.com/cyse7125-fall2023-group05/infra-jenkins/actions/workflows/tf-validate.yml/badge.svg?branch=master)](https://github.com/cyse7125-fall2023-group05/infra-jenkins/actions/workflows/tf-validate.yml)

Hashicorp Terraform is a Infrastructure as Code tool which is used to provision infrastructure and manage resources in any cloud or data center.

We will be using this tool to provision our Jenkins server.

## :arrow_heading_down: Installation

Install Terraform using Homebrew (only on MacOS):

> For any other distros, please follow the [setup guide in the official docs](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#install-terraform).

- First, install the HashiCorp tap, a repository of all our Homebrew packages.

```bash
brew tap hashicorp/tap
```

- Now, install Terraform with `hashicorp/tap/terraform`.

```bash
# This installs a signed binary and is automatically updated with every new official release.
brew install hashicorp/tap/terraform
```

- To update to the latest version of Terraform, first update Homebrew.

```bash
brew update
```

- Then, run the upgrade command to download and use the latest Terraform version.

```bash
brew upgrade hashicorp/tap/terraform
```

### :white_check_mark: Verify Installation

Verify that the installation worked by opening a new terminal session and listing Terraform's available subcommands.

```bash
terraform -help
```

- Add any subcommand to terraform -help to learn more about what it does and available options.

```bash
terraform -help plan
```

> NOTE: If you get an error that `terraform` could not be found, your `PATH` environment variable was not set up properly. Please go back and ensure that your `PATH` variable contains the directory where Terraform was installed.

### :+1: Enable tab completion

- If you use either Bash or Zsh, you can enable tab completion for Terraform commands. To enable autocomplete, first ensure that a config file exists for your chosen shell.

```bash
# bash
touch ~/.bashrc
# zsh
touch ~/.zshrc
```

- Install the autocomplete package

```bash
terraform -install-autocomplete
```

## :wrench: Working with Terraform

1. Initialize Terraform
   This installs the required providers and other plugins for our infrastructure.

   ```bash
   # run in the `root` dir
   terraform init
   ```

2. Create a `<filename>.tfvars` using the `example.tfvars` template.

3. Validate the terraform configuration

   ```bash
      terraform validate
   ```

4. Plan the cloud infrastructure
   This command shows how many resources will be created, deleted or modified when we run `terraform apply`.

   > NOTE: Remember to set your aws profile in the terminal to run the commands going forward

   ```bash
   export AWS_PROFILE=root
   terraform plan -var-file="<filename>.tfvars"
   ```

5. Apply the changes/updates to the infrastructure to create it

   ```bash
   # execute the tf plan
   # `--auto-approve` is to prevent tf from prompting you to say y/n to apply the plan
   terraform apply --auto-approve -var-file="<filename>.tfvars"
   ```

6. To destroy your infrastructure, use the command:

   ```bash
   terraform destroy --auto-approve -var-file="<filename>.tfvars"
   ```

## :file_cabinet: Terraform Backend

> NOTE: This is the recommended best practice.

This is a storage location within AWS from where we access out `.tfstate` file.

> All the information about the infrastructure resources are defined in the `.tfstate` file when we run `terraform apply`. So next time when we run `terraform apply`, it will only compare the *desired state* to the *actual state*.

If we do not use a `backend` to store our `.tfstate` file, it is stored locally on a server (if we provision our infrastructure through a server) or on our local development workstation. The `.tfstate` file may also contain confidential credentials. In order to avoid these problems, it is recommended to use the terraform `backend` to store the `.tfstate` file.

Now, when we run the `terraform apply` command, the `.tfstate` will be accessed through the AWS S3 bucket.

> NOTE: The terraform `backend` does not allow the use of tfvars, so we hardcode these values in the configuration.

```tf
terraform {
  backend "s3" {
    bucket         = "tfstate-sid"
    key            = "backend/infra-jenkins.tfstate"
    region         = "us-east-1"
    dynamodb_table = "infra-state"
  }
}
```
