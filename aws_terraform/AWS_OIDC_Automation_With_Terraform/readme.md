# AWS OIDC Automation with Terraform

## Description
This project automates the creation and management of AWS IAM OIDC providers using Terraform.  
It dynamically fetches the OIDC thumbprint and updates Terraform variables to simplify the provisioning workflow.

---

## Pre-requisites
- Terraform installed and available on your system (Windows, Linux, or macOS)
- OpenSSL installed (required for fetching OIDC thumbprint)
- AWS CLI configured with proper credentials/profile
- `get_thumbprint.sh` present in the project directory

---

## Usage
1. Make the deploy script executable:
    ```bash
    chmod +x deploy.sh
    ```

2. Run the deploy script:
    ```bash
    ./deploy.sh
    ```

The script will perform the following steps automatically:

- Invoke `get_thumbprint.sh` to fetch the OIDC thumbprint and update `terraform.tfvars`.
- Run Terraform commands in order: `init`, `fmt`, `validate`, `plan`.
- Prompt you for confirmation before applying changes.  

Type `yes` or `y` to apply the Terraform changes, or any other key to skip.

---

## Notes
- The `null_resource` in Terraform is used to invoke the thumbprint fetch script if you want to run it via Terraform.
- Terraform requires two apply steps if you want the dynamically fetched thumbprint to be used:
  1. Run the `null_resource` target to generate/update `terraform.tfvars`.
  2. Apply the OIDC provider resources using the updated variable.

---

## License
Specify your license here (e.g., MIT, Apache 2.0)
