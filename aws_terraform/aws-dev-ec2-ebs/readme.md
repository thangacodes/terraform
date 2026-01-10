## Overview

This configuration will:

- Create 5 EC2 instances (`devvm1` to `devvm5`) in the `ap-south-1a` availability zone.
- Attach one EBS volume to each EC2 instance.
- Assign a public IP only to `devvm1`.
- Use tags to manage metadata for instances and volumes.

---

## Prerequisites

- Terraform installed (`>= 1.14.2, < 2.0.0`)
- AWS CLI configured with a profile named `captain`
- Access to the specified VPC, subnet, and security groups
- SSH key named `captain` uploaded in your AWS account

---

## Terraform Version

```hcl
terraform {
  required_version = ">= 1.14.2, < 2.0.0"
}
This ensures compatibility with Terraform v1.14.2 and later.