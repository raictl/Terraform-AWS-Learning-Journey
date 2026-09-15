# Project 01 — Terraform + AWS EC2 Instance

## 📌 Project Overview

This project is the first project in the **Terraform + AWS** phase of the learning roadmap.

The goal is to use Terraform to provision and manage an **Amazon EC2 instance** using the AWS provider.

During this project, I learned the basic Terraform workflow for AWS:

```text
Terraform Configuration
        ↓
terraform init
        ↓
terraform validate
        ↓
terraform plan
        ↓
terraform apply
        ↓
AWS EC2 Instance
        ↓
Configuration Change
        ↓
terraform apply
        ↓
In-place Update
        ↓
terraform destroy
```

---

## 🎯 Objectives

By completing this project, I learned how to:

* Configure the AWS Terraform provider.
* Specify an AWS region.
* Create an EC2 instance using Terraform.
* Use an Amazon Machine Image (AMI).
* Select an EC2 instance type.
* Add tags to AWS resources.
* Define Terraform outputs.
* Inspect Terraform state.
* Preview infrastructure changes with `terraform plan`.
* Apply infrastructure changes with `terraform apply`.
* Understand in-place resource updates.
* Destroy Terraform-managed infrastructure.

---

## 🛠️ Technologies Used

| Technology               | Purpose                      |
| ------------------------ | ---------------------------- |
| Terraform                | Infrastructure as Code       |
| AWS                      | Cloud platform               |
| AWS Provider             | Terraform-to-AWS integration |
| Amazon EC2               | Virtual machine              |
| Amazon Linux AMI         | EC2 operating system image   |
| Windows PowerShell / CMD | Command-line environment     |

---

## ☁️ AWS Region

The project uses:

```text
ap-south-1
```

This is the AWS Mumbai region.

---

## 🏗️ Architecture

The project uses a simple EC2 architecture:

```text
                    Terraform
                        |
                        v
                  AWS Provider
                        |
                        v
                  AWS API
                        |
                        v
                  EC2 Instance
                   t3.micro
```

This project intentionally keeps the architecture simple.

A custom VPC, subnets, route tables, security groups, and other networking components will be introduced in later projects.

---

## 📁 Project Structure

```text
17-terraform-aws-ec2/
│
├── main.tf
├── providers.tf
├── outputs.tf
├── variables.tf
├── terraform.tfvars
├── .gitignore
└── README.md
```

> `variables.tf` and `terraform.tfvars` are part of the planned project structure, but the first implementation primarily uses the provider, EC2 resource, and outputs.

---

# 📄 Terraform Configuration

## `providers.tf`

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}
```

### Explanation

The `required_providers` block declares the AWS provider dependency.

```hcl
source = "hashicorp/aws"
```

specifies the HashiCorp AWS provider.

```hcl
version = "~> 6.0"
```

allows compatible versions in the 6.x series.

The provider configuration specifies the AWS region:

```hcl
region = "ap-south-1"
```

---

## `main.tf`

```hcl
resource "aws_instance" "devops_server" {
  ami           = "ami-0f918f7e67a3323f0"
  instance_type = "t3.micro"

  tags = {
    Name        = "terraform-devops-server"
    Environment = "learning"
  }
}
```

### Resource Explanation

```hcl
resource "aws_instance" "devops_server"
```

creates an AWS EC2 instance.

### AMI

```hcl
ami = "ami-0f918f7e67a3323f0"
```

specifies the Amazon Machine Image used to launch the instance.

> AMI IDs are region-specific. The AMI used in this project is intended for `ap-south-1`.

### Instance Type

```hcl
instance_type = "t3.micro"
```

specifies the EC2 instance type used for the project.

### Tags

```hcl
tags = {
  Name        = "terraform-devops-server"
  Environment = "learning"
}
```

adds useful metadata to the EC2 instance.

---

# 📤 Terraform Outputs

## `outputs.tf`

```hcl
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.devops_server.id
}

output "instance_type" {
  description = "EC2 instance type"
  value       = aws_instance.devops_server.instance_type
}

output "private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.devops_server.private_ip
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.devops_server.public_ip
}
```

These outputs allow Terraform to display useful information about the EC2 instance.

To view them:

```bash
terraform output
```

---

# 🚀 Terraform Workflow

## 1. Initialize Terraform

```bash
terraform init
```

This initializes the Terraform working directory and downloads the required AWS provider.

---

## 2. Format Configuration

```bash
terraform fmt
```

Formats Terraform configuration files according to Terraform's standard formatting rules.

---

## 3. Validate Configuration

```bash
terraform validate
```

Checks whether the Terraform configuration is syntactically valid and internally consistent.

Expected result:

```text
Success! The configuration is valid.
```

---

## 4. Preview Changes

```bash
terraform plan
```

Displays the changes Terraform intends to make without actually modifying AWS infrastructure.

For the initial deployment:

```text
Plan: 1 to add, 0 to change, 0 to destroy.
```

---

## 5. Create Infrastructure

```bash
terraform apply
```

Terraform creates the EC2 instance.

When prompted:

```text
Do you want to perform these actions?
```

enter:

```text
yes
```

Expected result:

```text
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

---

# 🔍 Terraform State

Terraform maintains a state file to track resources it manages.

Check the resources tracked by Terraform:

```bash
terraform state list
```

Expected:

```text
aws_instance.devops_server
```

To inspect the resource:

```bash
terraform state show aws_instance.devops_server
```

This displays information such as:

* Instance ID
* Instance type
* AMI
* IP addresses
* Tags
* Other resource attributes

---

# 🔄 In-Place Resource Update

During the project, the EC2 instance was updated by adding the following tag:

```hcl
Environment = "learning"
```

Terraform detected that the change could be performed **in place**.

The plan showed an update rather than resource replacement.

Conceptually:

```text
Existing EC2
     |
     +---- Add Environment tag
     |
     v
Same EC2 Instance
```

Terraform therefore did not need to destroy and recreate the EC2 instance.

---

# 🧪 Verify the Infrastructure

After applying the configuration, the EC2 instance can be verified using:

```bash
terraform output
```

and:

```bash
terraform state show aws_instance.devops_server
```

The AWS Console can also be used to verify:

```text
EC2
 ↓
Instances
 ↓
terraform-devops-server
```

The instance should have:

```text
Instance Type: t3.micro
Environment: learning
```

---

# 🧹 Cleanup

Because this is a learning project, the EC2 instance should be destroyed after testing.

Run:

```bash
terraform destroy
```

Confirm with:

```text
yes
```

Expected result:

```text
Destroy complete! Resources: 1 destroyed.
```

After destruction, running:

```bash
terraform plan
```

will show that Terraform wants to create the EC2 instance again because the configuration still declares it as desired infrastructure.

---

# 💰 Cost Awareness

EC2 resources can generate AWS charges.

Before finishing the project, destroy the EC2 instance:

```bash
terraform destroy
```

Do not leave learning resources running unnecessarily.

> AWS Free Tier eligibility and limits depend on the AWS account and the current AWS Free Tier terms. Always verify the current pricing/Free Tier status in your AWS account.

---

# 🧠 Key Concepts Learned

## Terraform Provider

A provider allows Terraform to communicate with an external platform.

```text
Terraform
    |
    v
AWS Provider
    |
    v
AWS API
```

---

## AMI

AMI stands for:

**Amazon Machine Image**

It is a template used to launch an EC2 instance.

---

## Instance Type

The instance type determines the compute configuration of the EC2 instance.

Example:

```text
t3.micro
```

---

## Terraform State

Terraform state records information about resources managed by Terraform.

```text
Terraform Configuration
        +
Terraform State
        ↓
Terraform determines required changes
```

---

## Terraform Plan

```bash
terraform plan
```

previews changes without applying them.

---

## Terraform Apply

```bash
terraform apply
```

creates or updates infrastructure according to the configuration.

---

## Terraform Destroy

```bash
terraform destroy
```

removes resources managed by the Terraform configuration.

---

# 🎤 Interview Questions

### 1. What is Terraform?

Terraform is an Infrastructure as Code tool used to define, provision, and manage infrastructure through declarative configuration.

### 2. What is a Terraform provider?

A provider is a plugin that allows Terraform to interact with a specific platform or service such as AWS.

### 3. What is an AWS provider?

The AWS provider allows Terraform to communicate with AWS APIs and manage AWS resources.

### 4. What is an EC2 instance?

Amazon EC2 is an AWS service that provides resizable compute capacity in the cloud.

### 5. What is an AMI?

An Amazon Machine Image is a template used to launch an EC2 instance.

### 6. What is the difference between an AMI and an instance type?

```text
AMI
→ Defines the image/software used to launch the instance.

Instance Type
→ Defines the compute characteristics of the instance.
```

### 7. What is `terraform plan`?

It previews the changes Terraform would make without applying them.

### 8. What is `terraform apply`?

It executes the infrastructure changes defined by the Terraform configuration.

### 9. What is Terraform state?

Terraform state is the record Terraform uses to track managed infrastructure and its attributes.

### 10. Why did changing the EC2 tag not recreate the instance?

Because the AWS provider supports updating the tag in place, so replacement of the EC2 instance was not required.

---

# 🧠 Important Commands Cheat Sheet

| Command                | Purpose                          |
| ---------------------- | -------------------------------- |
| `terraform init`       | Initialize project and providers |
| `terraform fmt`        | Format Terraform code            |
| `terraform validate`   | Validate configuration           |
| `terraform plan`       | Preview changes                  |
| `terraform apply`      | Create/update infrastructure     |
| `terraform output`     | Display outputs                  |
| `terraform state list` | List managed resources           |
| `terraform state show` | Inspect a managed resource       |
| `terraform destroy`    | Destroy managed infrastructure   |

---

