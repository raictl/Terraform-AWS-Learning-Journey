# 📚 Project 11 — Terraform Data Sources

Learn how Terraform can **read information from existing resources or external sources** using Data Sources.

---

## 📖 Overview

Terraform provides two important concepts for working with infrastructure:

* **Resources** — Create and manage infrastructure.
* **Data Sources** — Read or retrieve information about existing infrastructure or external data.

In this project, we use the Terraform **Local provider** to read an existing text file using a Data Source.

The goal is to understand how Terraform can consume information that already exists instead of creating everything itself.

---


---

# 📁 Project Structure

```text
11-terraform-data-sources/
│
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
├── data/
│   ├── application-info.txt
│   └── server-info.txt
│
└── .gitignore
```

---


# 📝 Step 1 — Create the Existing File

Create:

```text
data/application-info.txt
```

Add:

```text
Application Name: Terraform Portfolio
Environment: Production
Owner: DevOps Team
Version: 1.0
```

This file represents an **existing piece of information**.

Terraform will read it.

Terraform will not create it.

---

# 📝 Step 2 — Configure the Provider

The project uses the Local provider.

```hcl
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

provider "local" {}
```

---

# 📝 Step 3 — Create a Data Source

The Data Source is defined using the `data` keyword.

```hcl
data "local_file" "application_info" {
  filename = "${path.module}/${var.application_file}"
}
```

Let's understand the syntax:

```text
data "TYPE" "NAME"
```

For our project:

```text
data
 │
 ├── TYPE → local_file
 │
 └── NAME → application_info
```

---

# 🧠 Step 4 — Understand Data Source References

Terraform allows us to access attributes from the Data Source.

For example:

```hcl
data.local_file.application_info.content
```

This means:

```text
data
  ↓
local_file
  ↓
application_info
  ↓
content
```

In simple language:

> Read the content of the `application_info` Data Source.

---

# 📝 Step 5 — Use Variables

The project uses a variable so that the file path can be changed without modifying the Data Source configuration.

`variables.tf`:

```hcl
variable "application_file" {
  description = "Path to the existing application information file"
  type        = string

  default = "data/application-info.txt"
}
```

The Data Source uses this variable:

```hcl
data "local_file" "application_info" {
  filename = "${path.module}/${var.application_file}"
}
```

This makes the configuration more reusable.

---

# 📝 Step 6 — Use a Local Value

We can store the Data Source information in a local value.

```hcl
locals {
  application_content = data.local_file.application_info.content
}
```

Now we can reference:

```hcl
local.application_content
```

instead of repeatedly writing:

```hcl
data.local_file.application_info.content
```

---

# 📝 Step 7 — Create Outputs

`outputs.tf`:

```hcl
output "application_file_path" {
  description = "Path of the existing application information file"
  value       = data.local_file.application_info.filename
}

output "application_content" {
  description = "Content read from the existing application information file"
  value       = data.local_file.application_info.content
}

output "application_content_from_local" {
  description = "Application content accessed through a local value"
  value       = local.application_content
}
```

---

# 🚀 Step 8 — Initialize Terraform

Navigate into the project directory:

```bash
cd 11-terraform-data-sources
```

Initialize Terraform:

```bash
terraform init
```

Terraform downloads the required Local provider.

---

# 🔍 Step 9 — Format the Configuration

Run:

```bash
terraform fmt
```

This automatically formats Terraform configuration files.

---

# ✅ Step 10 — Validate

Run:

```bash
terraform validate
```

Expected result:

```text
Success! The configuration is valid.
```

---

# 👀 Step 11 — Run Terraform Plan

Run:

```bash
terraform plan
```

Terraform reads:

```text
data/application-info.txt
```

Notice that Terraform is **not creating the file**.

This is because we are using:

```hcl
data "local_file"
```

rather than:

```hcl
resource "local_file"
```

---

# 🚀 Step 12 — Apply

Run:

```bash
terraform apply
```

Type:

```text
yes
```

Terraform reads the existing file.

---

# 📤 Step 13 — View the Output

Run:

```bash
terraform output
```

You should see information similar to:

```text
application_file_path = "./data/application-info.txt"

application_content = <<EOT
Application Name: Terraform Portfolio
Environment: Production
Owner: DevOps Team
Version: 1.0
EOT
```

---

# 🧪 Experiments

## Experiment 1 — Modify Existing Data

Change:

```text
Environment: Production
Version: 1.0
```

to:

```text
Environment: Development
Version: 2.0
```

Run:

```bash
terraform plan
```

Then:

```bash
terraform apply
```

Finally:

```bash
terraform output
```

Terraform should display the updated information.

---

# 🧪 Experiment 2 — Create Another Data Source

Create:

```text
data/server-info.txt
```

Add:

```text
Server Name: DevOps-Server-01
Environment: Development
Operating System: Linux
```

Add another Data Source:

```hcl
data "local_file" "server_info" {
  filename = "${path.module}/data/server-info.txt"
}
```

Then create an output:

```hcl
output "server_information" {
  description = "Information read from the existing server information file"
  value       = data.local_file.server_info.content
}
```

Run:

```bash
terraform fmt
terraform validate
terraform plan
terraform apply
```

Then:

```bash
terraform output server_information
```

---

# 🧪 Experiment 3 — Override the Variable

The default variable points to:

```text
data/application-info.txt
```

You can temporarily provide another file using the command line.

On **Windows CMD**, use:

```bash
terraform plan -var="application_file=data/server-info.txt"
```

> On Windows CMD, use double quotes around the `-var` value.

On Linux/macOS, you can use:

```bash
terraform plan -var='application_file=data/server-info.txt'
```

This demonstrates how variables can change Data Source behavior without modifying the Terraform code.

---

# 🆚 Resource vs Data Source

| Feature                    | Resource                                          | Data Source                          |
| -------------------------- | ------------------------------------------------- | ------------------------------------ |
| Keyword                    | `resource`                                        | `data`                               |
| Main purpose               | Create/manage                                     | Read/discover                        |
| Creates infrastructure     | Usually                                           | No                                   |
| Reads existing information | Can manage existing objects depending on provider | Yes                                  |
| Example                    | `resource "local_file"`                           | `data "local_file"`                  |
| Common cloud usage         | Create EC2, VPC, etc.                             | Find existing AMI, VPC, subnet, etc. |

### Easy way to remember

```text
RESOURCE
    ↓
BUILD IT

DATA SOURCE
    ↓
FIND IT
```

---

# 🌎 Real-World DevOps Use Cases

Data Sources become particularly useful when working with existing cloud infrastructure.

For example:

```text
Existing VPC
     │
     ▼
Terraform Data Source
     │
     ▼
Retrieve VPC ID
     │
     ▼
Use VPC ID in another resource
```

Another common example:

```text
Existing AMI
     │
     ▼
Data Source
     │
     ▼
Find AMI ID
     │
     ▼
EC2 Resource
     │
     ▼
Launch EC2 instance
```

Another:

```text
Existing Subnet
     │
     ▼
Data Source
     │
     ▼
Retrieve Subnet ID
     │
     ▼
New Infrastructure
```

This is extremely common in real-world Terraform projects because companies often have infrastructure that was created **before your Terraform configuration**.

---

# 🧠 Important Terraform Concept

Terraform doesn't always operate in isolation.

A real environment might look like:

```text
Existing Infrastructure
        │
        ▼
   Data Sources
        │
        ▼
   Terraform Code
        │
        ▼
 New Infrastructure
```

Data Sources allow Terraform to **discover and use existing information**.

---

# ❗ Common Errors & Solutions

## Error 1 — Windows command-line quoting

If you run:

```bash
terraform plan -var='application_file=data/server-info.txt'
```

in Windows CMD, Terraform may interpret the `'` character as part of the variable name.

Use:

```bash
terraform plan -var="application_file=data/server-info.txt"
```

---

## Error 2 — File does not exist

You may see an error indicating that the file cannot be found.

Check:

```text
data/application-info.txt
```

exists relative to your project directory.

---

## Error 3 — Incorrect file path

Check the variable:

```hcl
variable "application_file" {
  default = "data/application-info.txt"
}
```

And the Data Source:

```hcl
data "local_file" "application_info" {
  filename = "${path.module}/${var.application_file}"
}
```

---

# 💡 Best Practices

### 1. Use descriptive Data Source names

Prefer:

```hcl
data "local_file" "application_info"
```

instead of:

```hcl
data "local_file" "file1"
```

---

### 2. Use variables for reusable paths

Instead of hardcoding:

```hcl
filename = "${path.module}/data/application-info.txt"
```

use:

```hcl
filename = "${path.module}/${var.application_file}"
```

---

### 3. Don't confuse Data Sources with Resources

Remember:

```text
resource → manage

data → discover
```

---

### 4. Don't assume existing infrastructure is managed by Terraform

A Data Source can read an existing object without putting Terraform in charge of managing its lifecycle.

This distinction becomes very important in production environments.

---

### 5. Keep Data Sources focused

Use a Data Source when you need information from something that already exists.

Don't use a Data Source simply because you can.

---

# 🧪 Verification Checklist

Run:

```bash
terraform fmt
```

```bash
terraform validate
```

```bash
terraform plan
```

```bash
terraform apply
```

Then:

```bash
terraform output
```

Confirm that Terraform successfully reads the existing file.

---

# 📚 Key Commands

| Command              | Purpose                       |
| -------------------- | ----------------------------- |
| `terraform init`     | Initialize project            |
| `terraform fmt`      | Format configuration          |
| `terraform validate` | Validate configuration        |
| `terraform plan`     | Preview changes               |
| `terraform apply`    | Apply configuration           |
| `terraform output`   | Display outputs               |
| `terraform destroy`  | Remove managed infrastructure |

Because this project primarily uses a **Data Source**, there may be little or nothing for Terraform to destroy.

---

# 💼 Interview Questions

### Q1. What is a Terraform Data Source?

A Data Source allows Terraform to retrieve information about an existing resource or external system.

---

### Q2. What keyword is used to define a Data Source?

```hcl
data
```

---

### Q3. What is the difference between a Resource and Data Source?

A Resource is used to create and manage infrastructure, while a Data Source is used to retrieve information about existing infrastructure or external data.

---

### Q4. Does a Data Source create infrastructure?

No. Its primary purpose is to read or discover information.

---

### Q5. How do you reference a Data Source?

The general syntax is:

```hcl
data.<TYPE>.<NAME>.<ATTRIBUTE>
```

Example:

```hcl
data.local_file.application_info.content
```

---

### Q6. Why are Data Sources important in real-world Terraform?

Because organizations frequently have existing infrastructure. Data Sources allow Terraform to discover existing information and use it when creating or configuring other resources.

---

### Q7. Can a Data Source be used with variables?

Yes.

For example:

```hcl
data "local_file" "application_info" {
  filename = "${path.module}/${var.application_file}"
}
```

---

# 🎯 Mini Challenge

Create:

```text
data/database-info.txt
```

with:

```text
Database Name: ProductionDB
Engine: PostgreSQL
Environment: Production
Owner: Database Team
```

Create a Data Source that reads this file.

Then create an output:

```text
database_information
```

that displays its contents.

### Challenge goal

Try to complete it without copying the exact solution from the project.

---

# 📚 Official Documentation

* [Terraform Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)
* [Terraform Language Documentation](https://developer.hashicorp.com/terraform/language)
* [Terraform Local Provider](https://registry.terraform.io/providers/hashicorp/local/latest)
* [Terraform `data` Block](https://developer.hashicorp.com/terraform/language/block/data)

---

