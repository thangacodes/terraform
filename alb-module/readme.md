This repository contains a fleet of VMs with Apache web servers deployed, configured to serve a static page accessible via an ALB endpoint..

# Tree structure of the file
.
├── app-alb
│   ├── main.tf
│   ├── outputs.tf
│   └── variables.tf
├── main.tf
├── outputs.tf
├── providers.tf
├── terraform.tfvars
├── variables.tf
└── vm
    ├── ec2.tf
    ├── init_script.sh
    ├── outputs.tf
    └── variables.tf

3 directories, 12 files
