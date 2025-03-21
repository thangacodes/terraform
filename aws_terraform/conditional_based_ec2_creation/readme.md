```
The Terraform script provisions 3 EC2 instances dynamically using the count meta-argument.
The number of instances to be created is controlled by the create_ec2_instances variable defined in variables.tf
By default, if the variable is set to true, Terraform will provision 3 EC2 instances.
If the variable is set to false, the Terraform plan will be skipped, and no EC2 instances will be created.

count = var.create_ec2_instances ? var.instance_count : 0
is using a conditional expression in Terraform to determine how many EC2 instances to create based on the value of the create_ec2_instances variable.

Additionally, a null_resource is used to run a script (e.g., a provisioning script) on the EC2 instances after they are created.
The null_resource is a placeholder resource in Terraform, often used to execute scripts or commands, and it can be triggered by changes in other resources or outputs.

If you want to run only the null_resource, use the Terraform command below:

terraform apply -auto-approve -target=null_resource.dummy-exec
terraform destroy -auto-approve -target=null_resource.dummy-exec
