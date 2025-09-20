# OpenTofu:

# Open-Source Infrastructure as Code.

```bash

What is OpenTofu?
OpenTofu is a reliable, flexible, community-driven infrastructure as code tool.

Command to Check version:
$ tofu version
OpenTofu v1.10.6
on windows_amd64
```

``` bash
OpenTofu commands:

The available commands for execution are listed below.
Main commands:
  tofu init          Prepare your working directory for other commands
  tofu fmt           formatting
  tofu validate      Check whether the configuration is valid
  tofu plan          Show changes required by the current configuration
  tofu apply         Create or update infrastructure
  tofu destroy       Destroy previously-created infrastructure

All other commands to check, run the command below,
tofu --help
```
To learn more about
[OpenTofu Doc](https://opentofu.org/docs/intro/)

```bash
Project folder Structure:
File Name         Purpose
main.tf           Main configuration file containing resource definition
variables.tf      Contains variable declarations
outputs.tf        Contains outputs from resources
provider.tf       Contains Provider definition
opentofu.tf       Configures OpenTofu behaviour
```
