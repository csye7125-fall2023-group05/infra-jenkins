# Infrastructure setup for Jenkins

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
