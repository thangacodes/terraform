# Configuring a VPC Gateway Endpoint for Private S3 Access

This repository contains Terraform scripts along with Bash scripts to automate the creation of AWS infrastructure.

## Description

The Terraform scripts in this repository provision the following AWS resources:

- **VPC** (Virtual Private Cloud)
- **Internet Gateway (IGW)**
- **Subnets**
  - One **public subnet**
  - One **private subnet**
- **Route Tables**
  - One **public route table**
  - One **private route table**
- **Route Table Associations**
  - **Public subnet** associated with **public route table**
  - **Private subnet** associated with **private route table**
- **VPC Gateway Endpoint** for S3
- **EC2 Instances**
  - One **public EC2 instance**
  - One **private EC2 instance**
- **Security Groups**
  - One **public security group**
  - One **private security group**

## Accessing EC2 Instances
Once the resources are provisioned, you can connect to the EC2 instances as follows:

### 1. Connect to the Public EC2 Instance (Bastion Host)
Use your WSL or PowerShell terminal on Windows to SSH into the public instance:

```bash
ssh ec2-user@<public_ip> -i captain.pem
Replace <public_ip> with the public IP address of your EC2 instance.
Ensure the captain.pem key file has the correct permissions:
chmod 400 captain.pem
```
### 2. Connect to the Private EC2 Instance via the Public Instance
Once connected to the public EC2 instance (bastion), you can SSH into the private EC2 instance:
```bash
ssh ec2-user@<private_ip>
Replace <private_ip> with the private IP of the private EC2 instance.
```
