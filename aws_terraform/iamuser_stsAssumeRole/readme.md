```bash

* This Terraform script creates an IAM role (dev-role) with a trust policy allowing specific users (including captain) to assume it,
and attaches an inline policy to the captain user to grant them sts:AssumeRole permissions for that role.
* Additionally, it uses a null_resource to execute an AWS CLI command that simulates assuming the role via aws sts assume-role

You just need to run the following commands to test this script:-

terraform init
terraform validate 
terraform plan                      //shows that what changes Terraform will make to your infrastructure based on the current state and the configuration files
terraform apply --auto-approve     //applies the changes to your infrastructure automatically without prompting you for approval.
terraform destroy --auto-approve  //destroys all the resources that were created by the Terraform configuration, again automatically without approval
terraform state list             //lists all the resources currently tracked by Terraform in the state file.

Instead of running the Terraform commands one after another, simply run the "init_script.sh" which does the work for you.

sh init_script.sh
