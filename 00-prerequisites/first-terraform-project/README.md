# 🚀 Project 01: My First Terraform Project (AWS S3 Bucket)

![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-S3-FF9900?logo=amazonaws)
![Beginner](https://img.shields.io/badge/Level-Beginner-success)

> Learn Terraform from scratch by creating your first AWS S3 Bucket while understanding every file, every command, and every concept used in a real-world Terraform project.

---

# 📖 Project Overview

This is the first hands-on Terraform project in the **Terraform & AWS Learning Journey**.

Instead of learning only theory, you will build real AWS infrastructure using Terraform.

The project creates an **Amazon S3 Bucket** using Infrastructure as Code (IaC).

More importantly, you'll understand **why every file exists**, **why every command is used**, and **how Terraform works internally**.

---

# 🎯 Learning Objectives

After completing this project, you will be able to:

- Understand Infrastructure as Code (IaC)
- Understand Terraform Project Structure
- Understand HCL (HashiCorp Configuration Language)
- Configure AWS Provider
- Create AWS Resources
- Use Variables
- Use Outputs
- Understand Terraform Workflow
- Understand Terraform State
- Use Git with Terraform
- Follow Production Best Practices

---

# 🏗️ Architecture

```

                Developer

│

▼

Terraform Code (.tf Files)

│

▼

Terraform CLI

│

▼

AWS Provider Plugin

│

▼

AWS API

│

▼

Amazon S3 Bucket

```

---

# 📂 Project Structure

```

terraform-first-project/

├── provider.tf

├── versions.tf

├── variables.tf

├── terraform.tfvars

├── main.tf

├── outputs.tf

├── README.md

└── .gitignore

```

---

# 📁 Understanding Every File

Terraform projects are generally divided into multiple files.

Each file has one responsibility.

This makes projects easy to read and maintain.

---

## 📄 versions.tf

Purpose:

Defines which Terraform version and Provider versions are allowed.

Example:

```hcl
terraform {

required_version = ">= 1.5.0"

required_providers {

aws = {

source = "hashicorp/aws"

version = "~> 6.0"

}

}

}
```

---

### Line 1

```hcl
terraform {
```

Starts the Terraform configuration block.

Only one terraform block usually exists.

---

### Line 2

```hcl
required_version = ">= 1.5.0"
```

Meaning:

Only Terraform version 1.5.0 or newer can execute this project.

Why?

Different Terraform versions support different features.

Using an unsupported version may break the project.

Production Best Practice:

Always define Terraform version.

Never leave it unspecified.

---

### Line 3

```hcl
required_providers
```

Terraform itself cannot communicate with AWS.

It needs a plugin.

That plugin is called a Provider.

---

### AWS Provider

```hcl
aws = {
```

Defines AWS provider configuration.

---

### Source

```hcl
source = "hashicorp/aws"
```

Tells Terraform:

Download the official AWS Provider from HashiCorp.

Without this line,

Terraform would not know where to obtain the provider.

---

### Version

```hcl
version = "~> 6.0"
```

Means:

Use version 6.x

Do not automatically upgrade to version 7.

This protects production environments from unexpected breaking changes.

---

# Why is versions.tf Important?

Imagine this situation.

Developer A

Terraform 1.8

AWS Provider 6.0

Developer B

Terraform 2.0

AWS Provider 7.0

Result?

Different behavior.

Unexpected failures.

Different syntax.

Production outages.

versions.tf ensures every engineer uses compatible versions.

---

# Interview Question

### Why do we use versions.tf?

Answer:

versions.tf ensures everyone uses compatible Terraform and Provider versions, preventing unexpected errors caused by version mismatches.

---

# 📄 provider.tf

Purpose:

Tells Terraform which cloud platform to connect to.

Example

```hcl
provider "aws" {

region = var.aws_region

}
```

---

## Line 1

```hcl
provider "aws"
```

Meaning:

Use AWS as the cloud provider.

Terraform supports many providers:

AWS

Azure

Google Cloud

GitHub

Cloudflare

Kubernetes

Datadog

VMware

etc.

---

### Region

```hcl
region = var.aws_region
```

Instead of hardcoding

```hcl
region="ap-south-1"
```

we use

```hcl
var.aws_region
```

Why?

Because projects should be reusable.

Today

India

Tomorrow

US East

Next Month

Europe

Only variable changes.

Code stays same.

---

# Production Best Practice

Never hardcode:

- Region
- Account IDs
- Credentials
- Secrets
- Bucket Names

Use Variables.

---

# Interview Question

### What is provider.tf?

Answer:

provider.tf defines which cloud provider Terraform should communicate with and contains provider-specific configuration such as the AWS Region.

---

### Why do we separate provider.tf?

Because it improves readability.

Instead of placing provider configuration inside main.tf,

we keep it isolated.

Large companies may have multiple providers.

Example

AWS

GitHub

Cloudflare

Datadog

Kubernetes

Keeping providers separate makes the project easier to understand.

---

# Internal Working of Provider

```

terraform init

↓

Reads provider.tf

↓

Finds AWS Provider

↓

Downloads Provider Plugin

↓

Stores inside .terraform/

↓

Terraform is ready

```

Without the Provider,

Terraform cannot communicate with AWS APIs.

---

# What Happens if provider.tf is Missing?

Terraform will not know:

- Which cloud to use
- Which APIs to call
- Which authentication method to use

Result:

Terraform fails.

---

# Common Mistakes

❌ Hardcoding Region

```hcl
region="ap-south-1"
```

Better

```hcl
region=var.aws_region
```

---

❌ Hardcoding Credentials

```hcl
access_key="ABC"

secret_key="XYZ"
```

Never do this.

Use AWS CLI credentials or environment variables.

---

# Quick Revision

✔ versions.tf

Controls versions.

✔ provider.tf

Configures cloud provider.

✔ Provider Plugin

Connects Terraform to AWS.

✔ Region

Specifies where resources will be created.

---

# Interview Questions

## Q1 What is a Provider?

Answer

A Provider is a plugin that allows Terraform to communicate with external platforms such as AWS, Azure, Google Cloud, Kubernetes, GitHub, and many others.

---

## Q2 Why does Terraform require a Provider?

Answer

Terraform itself does not know how to create AWS resources. The Provider translates Terraform configuration into API requests that AWS understands.

---

## Q3 What happens during `terraform init`?

Answer

Terraform:

- Reads the configuration.
- Identifies required providers.
- Downloads provider plugins.
- Creates the `.terraform` directory.
- Generates `.terraform.lock.hcl`.
- Initializes the working directory.

---

## Q4 Why should Provider versions be pinned?

Answer

Pinning provider versions ensures consistent behavior across environments and prevents unexpected issues caused by breaking changes in newer releases.

---

# 📄 variables.tf

## Purpose

The `variables.tf` file defines **input variables** for your Terraform project.

Think of variables as placeholders that make your code reusable.

Instead of writing fixed values directly into your code, you define variables and provide their values separately.

---

## Why Do We Need Variables?

Imagine you have the following configuration:

```hcl
provider "aws" {
  region = "ap-south-1"
}
```

Tomorrow your company wants to deploy in **us-east-1**.

You must edit the code.

Next week they want **eu-west-1**.

Again you edit the code.

This is not a good practice.

Instead,

```hcl
provider "aws" {
  region = var.aws_region
}
```

Now only the variable value changes.

The code never changes.

---

## Example

```hcl
variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "bucket_name" {
  description = "Unique S3 Bucket Name"
  type        = string
}
```

---

# Line-by-Line Explanation

## Line 1

```hcl
variable "aws_region"
```

Creates a variable named:

```
aws_region
```

Later it is accessed as

```hcl
var.aws_region
```

---

## Description

```hcl
description = "AWS Region"
```

Description explains the purpose of the variable.

Useful for:

- Documentation
- Team members
- Terraform Registry modules

Always write meaningful descriptions.

---

## Type

```hcl
type = string
```

Specifies the data type.

Terraform supports many types.

| Type | Example |
|------|----------|
| string | "Mumbai" |
| number | 100 |
| bool | true |
| list | ["a","b"] |
| map | {name="Ashu"} |
| object | Complex structures |
| set | Unique values |

---

# Interview Question

### Why do we define variable types?

Answer:

Variable types prevent invalid data from being passed and improve validation, readability, and reliability.

---

# Production Best Practices

Always specify:

- description
- type

Avoid:

```hcl
variable "region" {}
```

Good:

```hcl
variable "region" {
  description = "AWS Region"
  type        = string
}
```

---

# terraform.tfvars

## Purpose

This file contains the actual values of variables.

variables.tf defines

terraform.tfvars supplies values.

---

Example

```hcl
aws_region = "ap-south-1"

bucket_name = "ashutosh-terraform-demo-001"
```

---

Terraform automatically loads this file.

You do not need to specify it manually.

---

# Internal Working

```
variables.tf

↓

Declares Variable

↓

terraform.tfvars

↓

Assigns Value

↓

Terraform Uses Value
```

---

# Why Not Hardcode Values?

Bad

```hcl
bucket = "company-production-bucket"
```

Good

```hcl
bucket = var.bucket_name
```

Benefits

✔ Reusable

✔ Easy to maintain

✔ Easy to change

✔ Better collaboration

---

# Variable Flow

```
terraform.tfvars

↓

Variable Value

↓

variables.tf

↓

main.tf

↓

AWS Resource
```

---

# Difference Between variables.tf and terraform.tfvars

| variables.tf | terraform.tfvars |
|--------------|------------------|
| Declares variables | Assigns values |
| Contains metadata | Contains actual values |
| Defines type | Defines user input |
| Usually unchanged | Changes per environment |

---

# Interview Question

## What is the difference between variables.tf and terraform.tfvars?

Answer:

variables.tf declares variables and defines their properties such as description and type.

terraform.tfvars provides actual values for those variables.

---

# Variable Precedence

Terraform reads variables in the following order (highest priority first):

1. Command-line `-var`
2. Command-line `-var-file`
3. Environment variables (`TF_VAR_*`)
4. `terraform.tfvars`
5. `*.auto.tfvars`
6. Default values in `variables.tf`

Higher-priority values override lower-priority values.

---

# main.tf

## Purpose

main.tf contains the infrastructure resources.

This is where Terraform creates AWS services.

Example

```hcl
resource "aws_s3_bucket" "demo" {

  bucket = var.bucket_name

  tags = {
    Name        = "Terraform Demo Bucket"
    Environment = "Learning"
    Owner       = "Ashutosh Rai"
  }

}
```

---

# Understanding Every Line

## resource

```hcl
resource
```

A resource represents one infrastructure object.

Examples

- EC2
- S3
- VPC
- IAM User
- RDS
- EBS
- Security Group

Everything Terraform creates is usually defined as a resource.

---

## aws_s3_bucket

Specifies the AWS resource type.

Terraform knows how to create it through the AWS Provider.

---

## demo

This is the Terraform resource name.

```
resource "aws_s3_bucket" "demo"
```

Terraform refers to this resource as

```
aws_s3_bucket.demo
```

Important:

This name exists only inside Terraform.

AWS does not see this name.

---

## bucket

```hcl
bucket = var.bucket_name
```

This is the actual S3 bucket name created in AWS.

Remember:

S3 bucket names must be globally unique.

---

## tags

```hcl
tags = {

}
```

Tags help identify resources.

Example

```
Environment = Production

Owner = DevOps

Application = Banking
```

---

# Why Tags Are Important

Without tags

```
EC2

EC2

EC2

EC2
```

Nobody knows which server belongs to which application.

With tags

```
Project = Terraform

Environment = Dev

Owner = DevOps
```

Everything becomes organized.

---

# Production Best Practices

Every AWS resource should have tags.

Recommended tags

- Name
- Environment
- Owner
- Project
- Team
- CostCenter
- Application

---

# outputs.tf

## Purpose

Outputs display useful information after deployment.

Example

```hcl
output "bucket_name" {

  value = aws_s3_bucket.demo.bucket

}
```

---

# Why Outputs?

Imagine Terraform creates

- VPC
- EC2
- Load Balancer
- S3

How do you know their IDs?

Outputs display them automatically.

Example

```
bucket_name = ashutosh-terraform-demo-001
```

---

# Real Production Example

Output

```
VPC ID

Subnet IDs

EC2 Public IP

Load Balancer DNS

RDS Endpoint
```

These outputs are often consumed by:

- CI/CD pipelines
- Ansible
- Other Terraform modules
- Documentation
- Scripts

---

# .gitignore

## Purpose

Prevents unnecessary and sensitive files from being uploaded to GitHub.

Example

```
.terraform/

*.tfstate

*.tfstate.*

.terraform.lock.hcl

crash.log
```

---

# Why is .terraform Ignored?

Terraform downloads provider plugins.

These files are machine-generated.

They should not be committed.

---

# Why Ignore terraform.tfstate?

The state file contains:

- Resource IDs
- Infrastructure metadata
- Sometimes sensitive information

Uploading it to GitHub is a security risk.

---

# Why Ignore crash.log?

If Terraform crashes,

it creates a log.

This file is temporary.

---

# Interview Question

## Why is .gitignore important?

Answer:

.gitignore prevents generated files, provider plugins, state files, logs, and other unnecessary or sensitive files from being committed to version control.

---

# Complete File Relationships

```
versions.tf

↓

provider.tf

↓

variables.tf

↓

terraform.tfvars

↓

main.tf

↓

outputs.tf

↓

AWS Resources
```

---

# Quick Revision

✔ variables.tf

Declares variables.

✔ terraform.tfvars

Provides values.

✔ main.tf

Creates infrastructure.

✔ outputs.tf

Displays information.

✔ .gitignore

Protects repository cleanliness and security.

---

# Interview Questions

## What is a Variable?

A variable is an input parameter that makes Terraform configurations reusable and configurable.

---

## Why should we avoid hardcoding values?

Hardcoded values reduce flexibility and make code difficult to reuse across environments.

---

## Why are tags important?

Tags help organize, identify, manage costs, automate operations, and improve governance of cloud resources.

---

## What is an Output?

An output is a value that Terraform displays after deployment and can also be consumed by other modules or automation tools.

---

## Why should terraform.tfstate never be pushed to GitHub?

Because it may contain infrastructure metadata and sensitive information that could expose your cloud environment.

---

# ⚙️ Terraform Workflow

Terraform follows a predictable workflow.

```
Write Terraform Code
        │
        ▼
terraform init
        │
        ▼
terraform fmt
        │
        ▼
terraform validate
        │
        ▼
terraform plan
        │
        ▼
terraform apply
        │
        ▼
AWS Infrastructure Created
        │
        ▼
terraform destroy (Optional)
```

Every Terraform project follows this workflow.

Never skip steps in production.

---

# Step 1 - terraform init

## Syntax

```bash
terraform init
```

---

## What is terraform init?

`terraform init` initializes the Terraform working directory.

It prepares Terraform before any infrastructure can be created.

Think of it as installing everything Terraform needs for the project.

---

## What Happens Internally?

When you run:

```bash
terraform init
```

Terraform performs several tasks.

```
Read Configuration Files
        │
        ▼
Find Required Providers
        │
        ▼
Download Provider Plugins
        │
        ▼
Create .terraform Directory
        │
        ▼
Create .terraform.lock.hcl
        │
        ▼
Initialize Working Directory
```

---

## Detailed Steps

### Step 1

Terraform scans all `.tf` files.

Example

```
provider.tf

versions.tf

main.tf
```

---

### Step 2

Reads

```
required_providers
```

Example

```hcl
required_providers {

aws = {

source = "hashicorp/aws"

version = "~>6.0"

}

}
```

Terraform now knows

"I need AWS Provider."

---

### Step 3

Downloads AWS Provider Plugin.

Example

```
hashicorp/aws
```

---

### Step 4

Creates

```
.terraform/
```

Directory.

---

### Step 5

Creates

```
.terraform.lock.hcl
```

---

### Step 6

Initialization completed.

Terraform is now ready.

---

# Generated Directory

```
terraform-first-project/

├── .terraform/

├── .terraform.lock.hcl

├── main.tf

├── provider.tf

...
```

---

# What is .terraform Directory?

It stores downloaded provider plugins.

Example

```
.terraform/

providers/

registry.terraform.io/

hashicorp/

aws/

6.x.x/
```

Never edit this folder manually.

---

# Should We Commit .terraform?

No.

Reason

✔ Machine Generated

✔ Large

✔ Downloaded Automatically

✔ Different for Different Systems

Always ignore it.

---

# What is .terraform.lock.hcl?

Terraform creates this automatically.

Purpose

Locks provider versions.

Without lock file

Developer A

AWS Provider 6.0

Developer B

AWS Provider 6.5

Different behavior.

With lock file

Everyone uses exactly the same provider version.

Consistency.

---

# Interview Question

## What is .terraform.lock.hcl?

Answer

The lock file records the exact provider versions selected during initialization to ensure consistent Terraform behavior across all environments.

---

# Common Errors

### Error

```
Provider not found
```

Reason

No Internet

Wrong provider name

Typo

---

### Error

```
Failed to query provider
```

Reason

Firewall

Corporate Proxy

Network Issue

---

### Error

```
Unsupported Terraform Version
```

Reason

Current Terraform version does not satisfy

```
required_version
```

---

# Production Best Practices

Always run

```bash
terraform init
```

After

- cloning a repository
- changing providers
- changing backend configuration
- switching branches with Terraform changes

---

# Step 2 - terraform fmt

---

## Syntax

```bash
terraform fmt
```

---

## What is terraform fmt?

Formats Terraform code automatically.

Similar to formatting code in VS Code.

---

Before

```hcl
resource "aws_s3_bucket" "demo"{
bucket=var.bucket_name
}
```

After

```hcl
resource "aws_s3_bucket" "demo" {
  bucket = var.bucket_name
}
```

Much cleaner.

---

# Why Use terraform fmt?

Readable code

Consistent formatting

Easy code reviews

Professional repositories

---

# Production Best Practice

Always run

```bash
terraform fmt
```

before committing code.

Many companies enforce this in CI/CD pipelines.

---

# Interview Question

## What does terraform fmt do?

Answer

terraform fmt automatically formats Terraform configuration files according to the official HashiCorp style guidelines.

---

# Step 3 - terraform validate

---

## Syntax

```bash
terraform validate
```

---

## Purpose

Checks whether Terraform configuration is syntactically valid.

It does NOT create infrastructure.

It only validates configuration.

---

Example

Correct

```hcl
resource "aws_s3_bucket" "demo" {

}
```

Incorrect

```hcl
resource aws_s3_bucket demo

{
```

Terraform reports an error immediately.

---

# What validate Checks

✔ Syntax

✔ Variable references

✔ Resource references

✔ Block structure

✔ Required arguments

---

# What validate Does NOT Check

❌ AWS Credentials

❌ Whether bucket already exists

❌ Whether EC2 quota is exceeded

❌ AWS Billing

Those are checked during

```
terraform plan

or

terraform apply
```

---

# Production Workflow

Developer

↓

terraform fmt

↓

terraform validate

↓

Git Commit

↓

Pull Request

↓

CI Pipeline

↓

terraform plan

---

# Common Errors

Unknown variable

Unknown resource

Missing brackets

Missing quotes

Invalid references

---

# Interview Question

## Difference Between fmt and validate?

fmt

Formats code.

validate

Checks configuration correctness.

---

# Step 4 - terraform plan

---

## Syntax

```bash
terraform plan
```

---

# What is terraform plan?

This is one of the MOST IMPORTANT Terraform commands.

It creates an execution plan.

It tells you

"What Terraform is going to do"

before doing it.

---

Think Like This

Doctor

↓

Diagnosis

↓

Treatment Plan

↓

Operation

Terraform

↓

Reads Code

↓

Creates Plan

↓

Creates Infrastructure

---

# Internal Working

```
Terraform Configuration

↓

Read State File

↓

Read AWS Infrastructure

↓

Compare Both

↓

Generate Execution Plan
```

---

Terraform compares

Desired State

vs

Current State

Difference

↓

Execution Plan

---

# Example Output

```
Terraform will perform the following actions

+ create aws_s3_bucket.demo

Plan: 1 to add, 0 to change, 0 to destroy
```

Meaning

One resource

Will be created.

Nothing modified.

Nothing deleted.

---

# Another Example

```
Plan:

0 to add

1 to change

0 to destroy
```

Meaning

Existing resource will be updated.

---

# Another Example

```
Plan:

0 add

0 change

1 destroy
```

Terraform wants to delete something.

Be careful.

---

# Why Is terraform plan Important?

Without plan

You don't know

What Terraform is about to do.

With plan

Everything is visible before execution.

---

# Production Rule

Never run

```bash
terraform apply
```

without reviewing

```bash
terraform plan
```

---

# Save Execution Plan

```bash
terraform plan -out=tfplan
```

Creates

```
tfplan
```

file.

Later

```bash
terraform apply tfplan
```

This guarantees the reviewed plan is exactly what gets applied.

---

# Production CI/CD Workflow

Developer

↓

terraform fmt

↓

terraform validate

↓

terraform plan

↓

Team Review

↓

Approval

↓

terraform apply

---

# Interview Question

## What does terraform plan do?

Answer

terraform plan compares the desired configuration with the current infrastructure and generates an execution plan showing what resources will be created, modified, or destroyed without making any changes.

---

## Why should we review terraform plan?

Answer

Reviewing the execution plan helps detect unintended changes before they affect production infrastructure.

---

# Quick Comparison

| Command | Purpose |
|----------|---------|
| terraform init | Initialize working directory |
| terraform fmt | Format Terraform code |
| terraform validate | Validate configuration syntax |
| terraform plan | Preview infrastructure changes |

---

# 🚀 Step 5 - terraform apply

## Syntax

```bash
terraform apply
```

---

## What is terraform apply?

`terraform apply` executes the execution plan generated by Terraform and creates, updates, or deletes infrastructure to match the desired configuration.

Think of it as pressing the **"Execute"** button.

---

## Internal Workflow

```
Terraform Code
      │
      ▼
Read State File
      │
      ▼
Compare with AWS
      │
      ▼
Generate Execution Plan
      │
      ▼
Ask for Confirmation
      │
      ▼
Call AWS APIs
      │
      ▼
Create Infrastructure
      │
      ▼
Update State File
```

---

## Example

```bash
terraform apply
```

Terraform displays

```
Plan: 1 to add, 0 to change, 0 to destroy.
```

Then asks

```
Do you want to perform these actions?

Only 'yes' will be accepted.

Enter a value:
```

Type

```
yes
```

Terraform creates the resources.

---

## Skip Confirmation

```bash
terraform apply -auto-approve
```

⚠ Never use this blindly in Production.

---

# What Happens Internally?

Terraform

✔ Reads configuration

✔ Reads state file

✔ Calls AWS APIs

✔ Creates resources

✔ Updates state

✔ Displays outputs

---

# Production Best Practice

Always run

```bash
terraform plan
```

before

```bash
terraform apply
```

Never directly apply infrastructure changes in production.

---

# Step 6 - terraform destroy

## Syntax

```bash
terraform destroy
```

---

## Purpose

Deletes all infrastructure managed by the current Terraform configuration.

---

## Internal Workflow

```
Read State File
      │
      ▼
Identify Managed Resources
      │
      ▼
Call AWS APIs
      │
      ▼
Delete Resources
      │
      ▼
Update State
```

---

## Example

```
Plan: 0 to add, 0 to change, 1 to destroy.
```

Terraform asks for confirmation before deletion.

---

# Production Warning

Always review what will be destroyed.

Deleting production infrastructure accidentally can cause outages.

---

# What is terraform.tfstate?

One of the most important Terraform files.

Terraform stores information about every managed resource in the **state file**.

Example

```
terraform.tfstate
```

---

## Why is State Required?

Suppose Terraform creates

- S3 Bucket
- EC2 Instance
- VPC

Later you change only a tag.

How does Terraform know what already exists?

Answer

```
terraform.tfstate
```

---

## Internal Working

```
Terraform Configuration

↓

terraform.tfstate

↓

AWS Infrastructure

↓

Compare

↓

Create Plan
```

Without the state file Terraform cannot accurately determine what it manages.

---

# Contents of State File

The state file may include

- Resource IDs
- ARNs
- Public IPs
- Metadata
- Output values

Sometimes it may contain sensitive information.

---

# Should terraform.tfstate Be Uploaded to GitHub?

❌ No.

Reasons

- Security risk
- May contain sensitive metadata
- Causes merge conflicts
- Shared state should use a remote backend

Always ignore it using `.gitignore`.

---

# What is terraform.tfstate.backup?

Terraform automatically creates a backup of the previous state before updating it.

Purpose

Recovery.

---

# Drift Detection

## What is Drift?

Drift occurs when infrastructure is changed **outside Terraform**.

Example

Terraform creates

```
EC2
```

Later

Someone manually deletes it in the AWS Console.

Now

Terraform code

≠

AWS Infrastructure

This difference is called **Configuration Drift**.

---

# How Terraform Detects Drift

```
terraform plan

↓

Read State

↓

Read AWS

↓

Compare

↓

Show Differences
```

---

# Security Best Practices

✔ Never hardcode credentials.

✔ Never commit state files.

✔ Use IAM roles where possible.

✔ Enable bucket encryption.

✔ Follow least-privilege IAM policies.

✔ Store remote state securely.

✔ Review every execution plan.

---

# Git Best Practices

Commit

✔ .tf files

✔ README.md

✔ .gitignore

✔ Documentation

Do NOT Commit

❌ .terraform/

❌ terraform.tfstate

❌ terraform.tfstate.backup

❌ crash.log

---

# Common Errors

## Bucket Already Exists

Reason

S3 bucket names are globally unique.

Fix

Choose another name.

---

## Invalid Credentials

```
No valid credential sources found.
```

Fix

Configure AWS CLI credentials or environment variables.

---

## Access Denied

Reason

IAM user lacks permissions.

Fix

Attach the required IAM policy.

---

## Provider Version Conflict

Reason

Different provider versions.

Fix

Run

```bash
terraform init -upgrade
```

only after reviewing compatibility.

---

## Unsupported Terraform Version

Reason

Current Terraform version does not satisfy `required_version`.

Fix

Install a compatible version.

---

# Troubleshooting Checklist

Before troubleshooting:

- Did you run `terraform init`?
- Is AWS CLI configured?
- Is the provider version correct?
- Is the bucket name unique?
- Did `terraform validate` pass?
- Did you review `terraform plan`?

---

# Cheat Sheet

| Command | Purpose |
|----------|---------|
| terraform init | Initialize project |
| terraform fmt | Format code |
| terraform validate | Validate configuration |
| terraform plan | Preview changes |
| terraform apply | Apply changes |
| terraform destroy | Remove infrastructure |

---

# Revision Notes

- Terraform is Declarative.
- Provider connects Terraform to AWS.
- Variables make code reusable.
- Outputs display useful values.
- State tracks infrastructure.
- Always review plans before applying.
- Never commit state files.
- Use Git for version control.

---

# Frequently Asked Interview Questions

## 1. What is Terraform?

Terraform is an Infrastructure as Code (IaC) tool developed by HashiCorp that provisions and manages infrastructure using declarative configuration files.

---

## 2. What is HCL?

HashiCorp Configuration Language (HCL) is the language used to write Terraform configurations.

---

## 3. What is a Provider?

A provider is a plugin that enables Terraform to communicate with platforms such as AWS, Azure, GCP, Kubernetes, GitHub, and others.

---

## 4. What is a Resource?

A resource represents a piece of infrastructure managed by Terraform, such as an EC2 instance, S3 bucket, VPC, or IAM user.

---

## 5. Why do we use provider.tf?

To configure the cloud provider and provider-specific settings, such as the AWS Region.

---

## 6. Why do we use versions.tf?

To enforce compatible Terraform and provider versions.

---

## 7. Why do we use variables.tf?

To declare reusable input variables and define their types and descriptions.

---

## 8. What is terraform.tfvars?

A file that provides values for variables declared in `variables.tf`.

---

## 9. Difference between variables.tf and terraform.tfvars?

- `variables.tf` declares variables.
- `terraform.tfvars` assigns values to those variables.

---

## 10. Why do we use outputs.tf?

To display useful values after deployment and share information with users or other modules.

---

## 11. Why is .gitignore important?

It prevents generated files, state files, logs, and other unnecessary or sensitive files from being committed to Git.

---

## 12. What does terraform init do?

It initializes the working directory, downloads required providers, creates the `.terraform` directory, and generates the provider lock file.

---

## 13. What does terraform fmt do?

It formats Terraform code according to HashiCorp's style guidelines.

---

## 14. What does terraform validate do?

It validates the syntax and structure of the Terraform configuration without creating infrastructure.

---

## 15. What does terraform plan do?

It compares the desired configuration with the current state and generates an execution plan showing what will be created, modified, or destroyed.

---

## 16. What does terraform apply do?

It executes the approved plan and creates, updates, or deletes infrastructure.

---

## 17. What does terraform destroy do?

It removes all infrastructure managed by the current Terraform configuration.

---

## 18. What is terraform.tfstate?

The state file that records Terraform-managed resources and their current state.

---

## 19. Why should terraform.tfstate not be committed to Git?

Because it may contain sensitive information, causes merge conflicts, and is better managed through a secure remote backend.

---

## 20. What is Infrastructure Drift?

Infrastructure drift occurs when resources are changed manually outside Terraform, causing the actual infrastructure to differ from the Terraform configuration or state.

---

# Assignment

### Task 1

Create the project from scratch without copying the code.

---

### Task 2

Use your own unique S3 bucket name.

---

### Task 3

Add these tags:

```
Project = Terraform Learning

Environment = Dev

Team = DevOps
```

---

### Task 4

Run

```bash
terraform fmt

terraform validate

terraform plan
```

Record the output.

---

### Task 5

Create the bucket.

Verify it in the AWS Console.

---

### Task 6

Destroy the bucket.

Verify that it has been deleted.

---

# Final Summary

Congratulations! 🎉

By completing this project, you have learned:

- Terraform project structure
- HCL basics
- Providers
- Resources
- Variables
- Outputs
- Version constraints
- State files
- Terraform workflow
- `terraform init`
- `terraform fmt`
- `terraform validate`
- `terraform plan`
- `terraform apply`
- `terraform destroy`
- Drift detection
- Security best practices
- Git best practices
- Troubleshooting
- Interview concepts

This project provides the foundation for all future Terraform work. Every production-grade Terraform project builds upon these core concepts.

---

