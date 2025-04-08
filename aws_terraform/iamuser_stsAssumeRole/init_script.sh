#!/bin/bash
# Function to ask user for input (yes/no)
ask_user() {
    while true; do
        read -p "$1 (yes/no): " choice
        case $choice in
            [Yy]* ) return 0;;  # Yes
            [Nn]* ) return 1;;  # No
            * ) echo "Please answer yes or no.";;
        esac
    done
}
# Function to run terraform init
terraform_init() {
    if ask_user "Do you want to run terraform init?"; then
        echo "Running terraform init"
        terraform init
    else
        echo "Skipping terraform init"
    fi
}
# Function to run terraform fmt
terraform_fmt() {
    if ask_user "Do you want to run terraform fmt?"; then
        echo "Running terraform fmt"
        terraform fmt
    else
        echo "Skipping terraform fmt"
    fi
}
# Function to run terraform validate
terraform_validate() {
    if ask_user "Do you want to run terraform validate?"; then
        echo "Running terraform validate"
        terraform validate
    else
        echo "Skipping terraform validate"
    fi
}
# Function to run terraform plan
terraform_plan() {
    if ask_user "Do you want to run terraform plan?"; then
        echo "Running terraform plan"
        terraform plan
    else
        echo "Skipping terraform plan"
    fi
}
# Function to run terraform apply
terraform_apply() {
    if ask_user "Do you want to run terraform apply?"; then
        echo "Running terraform apply"
        terraform apply --auto-approve
    else
        echo "Skipping terraform apply"
    fi
}
# Function to run terraform destroy
terraform_destroy() {
    if ask_user "Do you want to run terraform destroy?"; then
        echo "Running terraform destroy"
        terraform destroy --auto-approve
    else
        echo "Skipping terraform destroy"
    fi
}
# Main script execution
terraform_init
echo ""
terraform_fmt
echo ""
terraform_validate
echo ""
terraform_plan
echo ""
terraform_apply
echo ""
terraform_destroy


