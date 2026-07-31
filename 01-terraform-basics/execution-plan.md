# Terraform Execution Plan

> Learn how Terraform analyzes infrastructure changes before making them, ensuring deployments are predictable, safe, and reviewable.

---

# 📖 Overview

An **Execution Plan** is Terraform's preview of the changes it intends to make to your infrastructure.

It compares:

- Your Terraform configuration (`*.tf`)
- The Terraform State (`terraform.tfstate`)
- The actual infrastructure (AWS)

Then it determines exactly what actions are required.

> 💡 **Pro Tip:** In production, **never run `terraform apply` without reviewing the execution plan.**

---

# 🎯 Learning Objectives

After completing this lesson, you will be able to:

- Understand Terraform Execution Plans
- Read and interpret plan output
- Identify resource actions
- Save execution plans
- Apply saved plans
- Follow production workflows

---

# Why Do We Need an Execution Plan?

Suppose you update your EC2 instance:

Before:

```hcl
instance_type = "t3.micro"
```

After:

```hcl
instance_type = "t3.small"
```

Without an execution plan:

❌ Terraform could make unexpected changes.

With an execution plan:

```text
Terraform will perform the following actions:

~ aws_instance.web

instance_type:

t3.micro

↓

t3.small
```

You know exactly what will change before anything is modified.

---

# Internal Working

```text
Terraform Configuration
        │
        ▼
Read terraform.tfstate
        │
        ▼
Refresh Infrastructure State
        │
        ▼
Compare Desired vs Current State
        │
        ▼
Generate Execution Plan
        │
        ▼
Display Proposed Changes
```

No infrastructure changes are made during this process.

---

# Example Infrastructure

Imagine the following resources:

```text
VPC
 │
 ├── Public Subnet
 │
 ├── Internet Gateway
 │
 └── EC2 Instance
```

You modify the EC2 instance type.

Terraform analyzes only the affected resource instead of recreating the entire infrastructure.

---

# Generate an Execution Plan

```bash
terraform plan
```

Example output:

```text
Terraform will perform the following actions:

# aws_instance.web will be updated in-place

~ resource "aws_instance" "web" {

instance_type = "t3.micro"

↓

instance_type = "t3.small"

}
```

Terraform indicates:

- Resource name
- Resource type
- Action to perform
- Exact attribute changes

---

# Resource Action Symbols

Terraform uses symbols to indicate actions.

| Symbol | Meaning |
|---------|----------|
| `+` | Create |
| `~` | Update |
| `-` | Destroy |
| `-/+` | Destroy and recreate |

Example:

```text
+ aws_subnet.public
```

Terraform will create a new subnet.

---

```text
~ aws_instance.web
```

Terraform will update the EC2 instance.

---

```text
- aws_security_group.old
```

Terraform will delete the Security Group.

---

```text
-/+ aws_instance.web
```

Terraform must destroy and recreate the EC2 instance.

---

# Save the Execution Plan

Instead of applying immediately:

```bash
terraform plan -out=tfplan
```

Terraform creates:

```text
tfplan
```

This file contains the reviewed execution plan.

Apply it later:

```bash
terraform apply tfplan
```

> 💡 **Pro Tip:** Saving and applying the same plan ensures that the reviewed changes are exactly what gets deployed.

---

# Real-World Example

A company wants to:

- Create a new private subnet
- Attach a route table
- Launch an EC2 application server

Terraform Plan:

```text
Plan:

3 to add

0 to change

0 to destroy
```

The infrastructure team reviews the plan.

After approval:

```bash
terraform apply tfplan
```

Deployment proceeds exactly as reviewed.

---

# Production Workflow

```text
Developer
      │
      ▼
terraform fmt
      │
      ▼
terraform validate
      │
      ▼
terraform plan -out=tfplan
      │
      ▼
Peer Review / Approval
      │
      ▼
terraform apply tfplan
```

This workflow reduces deployment risks and supports change management.

---

# Best Practices

- Always review the execution plan.
- Save plans using `-out`.
- Apply reviewed plans instead of generating a new one.
- Store Terraform code in Git.
- Use pull requests for infrastructure changes.
- Avoid direct `terraform apply` in production.

---

# Common Mistakes

### Skipping `terraform plan`

May result in unexpected infrastructure changes.

---

### Applying Without Review

Can lead to accidental deletions or costly mistakes.

---

### Ignoring `-/+`

A resource replacement may cause downtime or data loss.

---

### Regenerating Plans

Generating a new plan after approval may include additional changes.

---

# Troubleshooting

| Problem | Solution |
|----------|----------|
| Unexpected resource replacement | Review changed arguments and lifecycle settings |
| Too many resources to destroy | Verify configuration and state before applying |
| Plan differs from expectations | Check for infrastructure drift or manual changes |
| Unknown values in plan | Some values are determined only during apply |

---

# Security Considerations

- Review plans before approval.
- Protect plan files if they contain sensitive information.
- Restrict who can approve production changes.
- Use CI/CD pipelines for controlled deployments.

---

# Interview Questions

### 1. What is an Execution Plan?

A preview of the infrastructure changes Terraform intends to make.

---

### 2. Which command generates an Execution Plan?

```bash
terraform plan
```

---

### 3. Does `terraform plan` modify infrastructure?

No.

It only analyzes and displays proposed changes.

---

### 4. What does the `+` symbol mean?

Terraform will create a new resource.

---

### 5. What does `~` represent?

Terraform will update an existing resource.

---

### 6. Why should we use `terraform plan -out`?

It saves the reviewed plan so the exact approved changes can be applied later.

---

### 7. Why is the Execution Plan important in production?

It enables teams to review, approve, and understand infrastructure changes before deployment, reducing operational risk.

---

# 📋 Cheat Sheet

| Command | Purpose |
|----------|---------|
| `terraform plan` | Generate an execution plan |
| `terraform plan -out=tfplan` | Save the execution plan |
| `terraform apply tfplan` | Apply the saved plan |

---

# 📝 Summary

The Terraform Execution Plan is a critical safety feature that previews infrastructure changes before they are applied. It compares your configuration, state, and real infrastructure to determine the required actions. Reviewing and saving execution plans is a production best practice that improves reliability, enables team collaboration, and reduces deployment risk.
