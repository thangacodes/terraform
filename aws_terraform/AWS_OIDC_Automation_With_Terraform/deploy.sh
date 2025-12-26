#!/usr/bin/env bash
set -euo pipefail

# Step 1: Run get_thumbprint.sh
echo "Fetching OIDC thumbprint..."
./get_thumbprint.sh

# Step 2: Terraform commands
echo "Initializing Terraform..."
terraform init

echo "Formatting Terraform files..."
terraform fmt

echo "Validating Terraform configuration..."
terraform validate

echo "Creating Terraform plan..."
terraform plan

# Step 3: Prompt user for apply
read -rp "Do you want to apply the Terraform changes? (yes/no): " CONFIRM

if [[ "$CONFIRM" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo "Applying Terraform changes..."
    terraform apply -auto-approve
else
    echo "Terraform apply skipped."
fi
exit 0
