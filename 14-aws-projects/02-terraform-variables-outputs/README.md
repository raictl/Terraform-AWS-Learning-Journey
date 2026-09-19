# Project 02 — Terraform Variables & Outputs with AWS EC2

## 📌 Overview

This project demonstrates how to use **Terraform input variables and output values** with an AWS EC2 instance.

In Project 01, several values were hardcoded directly inside `main.tf`. In this project, those values are moved into Terraform variables so that the configuration becomes more **reusable, configurable, and maintainable**.

---

## 🎯 Objectives

By completing this project, I learned:

* How to define Terraform input variables
* How to provide variable values using `terraform.tfvars`
* How to use variables inside Terraform resources
* How to define Terraform outputs
* How to expose values from AWS resources
* Basic Terraform variable precedence
* How to make Terraform configurations reusable
* How to use `terraform output`
* Terraform validation and formatting

---

## 🛠️ Technologies Used

* Terraform
* AWS
* AWS EC2
* HCL
* Git

---

## ☁️ AWS Configuration

| Configuration | Value        |
| ------------- | ------------ |
| AWS Region    | `ap-south-1` |
| Resource      | EC2          |
| Instance Type | `t3.micro`   |
| Environment   | `learning`   |

> **Note:** AMI IDs are region-specific. The AMI used in this project is configured for `ap-south-1`.

---

## 📁 Project Structure

```text
18-terraform-variables-outputs/
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── terraform.tfvars
├── .gitignore
└── README.md
```

# 🔄 Terraform Workflow

## 1. Initialize Terraform

```bash
terraform init
```

Initializes the Terraform working directory and downloads the required provider.

---

## 2. Format the configuration

```bash
terraform fmt
```

Formats Terraform files according to standard Terraform formatting.

---

## 3. Validate the configuration

```bash
terraform validate
```

Checks whether the Terraform configuration is syntactically and structurally valid.

---

## 4. Create an execution plan

```bash
terraform plan
```

Shows what Terraform intends to create, modify, or destroy.

---

## 5. Apply the configuration

```bash
terraform apply
```

Creates or updates the infrastructure.

---

## 6. View outputs

```bash
terraform output
```

Displays the output values defined in `outputs.tf`.

Example:

```text
environment        = "learning"
instance_id        = "i-xxxxxxxxxxxxxxxxx"
instance_public_ip = "xx.xx.xx.xx"
instance_type      = "t3.micro"
```

---

## 7. Destroy infrastructure

```bash
terraform destroy
```

Removes the resources managed by Terraform.

---

# 🧠 Important Terraform Concepts

## Input Variables

Input variables allow us to pass values into a Terraform configuration.

```text
Input
  ↓
Terraform
  ↓
Resource
```

Example:

```hcl
variable "instance_type" {
  type = string
}
```

---

## Variable Values

Values can be provided through `terraform.tfvars`.

```hcl
instance_type = "t3.micro"
```

---

## Outputs

Outputs expose useful information from resources.

```text
Resource
   ↓
Output
   ↓
User / CLI / Module
```

Example:

```hcl
output "instance_id" {
  value = aws_instance.devops_server.id
}
```

---

# 🔢 Variable Precedence

Terraform can receive variable values from multiple sources.

A simplified precedence concept is:

```text
default value
      ↓
terraform.tfvars
      ↓
*.auto.tfvars
      ↓
environment variables
      ↓
command-line variables
```

Higher-precedence values can override lower-precedence values.

For example:

```hcl
variable "instance_type" {
  type    = string
  default = "t3.micro"
}
```

If `terraform.tfvars` contains:

```hcl
instance_type = "t3.small"
```

Terraform uses:

```text
t3.small
```

instead of the default `t3.micro`.

---

# 🔐 Important Note About `terraform.tfvars`

`terraform.tfvars` can contain environment-specific or sensitive values.

For real projects, sensitive values should **not** be committed to Git.

Use:

```text
terraform.tfvars
```


# 🧪 Verification

The following Terraform commands were successfully used during this project:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform output
terraform destroy
```

---

# 🎤 Interview Questions

### 1. What is a Terraform input variable?

An input variable allows values to be passed into a Terraform configuration.

### 2. What is `variables.tf`?

`variables.tf` is commonly used to define Terraform input variables, including their type, description, and optional default value.

### 3. What is `terraform.tfvars`?

`terraform.tfvars` is commonly used to provide values for Terraform input variables.

### 4. What is the difference between `variables.tf` and `terraform.tfvars`?

`variables.tf` defines the variables, while `terraform.tfvars` provides values for those variables.

### 5. What is a Terraform output?

A Terraform output exposes useful values from resources or modules.

### 6. Why use variables instead of hardcoding values?

Variables make Terraform configurations more reusable, configurable, and easier to maintain.

### 7. What happens if a variable has no provided value?

If the variable has a default value, Terraform uses the default. If it has no default, Terraform requires the value from another supported input source.

---


# 🚀 Key Takeaway

The main goal of this project was to move from **hardcoded Terraform configuration** to a more reusable configuration using variables and outputs.

```text
variables.tf
     ↓
Define variables
     ↓
terraform.tfvars
     ↓
Provide values
     ↓
main.tf
     ↓
Create infrastructure
     ↓
outputs.tf
     ↓
Expose resource values
```
