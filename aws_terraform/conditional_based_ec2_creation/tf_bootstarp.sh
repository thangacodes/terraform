#!/bin/bash
echo "Script execution time at:" $(date '+ %Y-%m-%d %H:%M:%S')
echo ""
echo "********************************"
echo " Terraform Script               "
echo "********************************"
echo ""
## Variable injection
TFFMT="terraform fmt"
TFVALIDATE="terraform validate"
TFPLAN="terraform plan"
TFAPPLY="terraform apply --auto-approve"
## SCRIPT BEGINS
echo "terraform fmt"
${TFFMT}
echo "terraform validate"
${TFVALIDATE}
echo "terraform plan"
${TFPLAN}
echo "terraform apply with approval"
${TFAPPLY}
