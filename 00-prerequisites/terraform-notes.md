# Lesson 02: What is Terraform?

> Learn what Terraform is, why it was created, and how it provisions infrastructure using Infrastructure as Code (IaC).

---

# 📖 Learning Objectives

By the end of this lesson, you will be able to:

- Define Terraform.
- Explain why Terraform was created.
- Understand how Terraform works.
- Explain how Terraform communicates with AWS.
- Describe real-world use cases.
- Answer basic Terraform interview questions.

---

# What is Terraform?

Terraform is an **Open Source Infrastructure as Code (IaC)** tool developed by **HashiCorp**.

It allows you to define infrastructure in code and automatically create, modify, and delete cloud resources.

Instead of manually creating infrastructure through the AWS Console, Terraform provisions resources using configuration files.

---

# Simple Definition

> Terraform is a tool that converts infrastructure code into real cloud infrastructure.

---

# Real-Life Example

Imagine building a house.

- Blueprint → Terraform Code
- Engineer → Terraform
- Construction Workers → AWS APIs
- House → Cloud Infrastructure

You create the blueprint once, and Terraform follows it to build the infrastructure.

---

# How Terraform Works

```
Terraform Code
        │
        ▼
Terraform
        │
        ▼
AWS API
        │
        ▼
AWS Resources
```

Terraform communicates with AWS using AWS APIs.

---

# Why Do We Need Terraform?

Terraform helps us:

- Automate infrastructure provisioning.
- Eliminate manual errors.
- Create consistent environments.
- Store infrastructure in Git.
- Reuse infrastructure.
- Improve collaboration.
- Speed up deployments.

---

# Problems Solved

Without Terraform

- Manual clicking
- Slow deployments
- Human mistakes
- Difficult disaster recovery

With Terraform

- Automated deployments
- Repeatable infrastructure
- Version-controlled infrastructure
- Faster recovery

---

# Where Companies Use Terraform

- AWS
- Azure
- Google Cloud
- Kubernetes
- VMware
- Multi-cloud
- Hybrid Cloud

---

# Advantages

- Infrastructure as Code
- Automation
- Repeatability
- Version Control
- Multi-cloud support
- Collaboration
- Faster deployment
- Consistent infrastructure

---

# Interview Question

### What is Terraform?

Terraform is an open-source Infrastructure as Code (IaC) tool developed by HashiCorp that automates infrastructure provisioning using code. It enables repeatable, consistent, and version-controlled deployments across multiple cloud providers.

---

# Revision Notes

- Terraform = Infrastructure as Code
- Developed by HashiCorp
- Uses HCL
- Communicates using Cloud APIs
- Supports multiple providers

---

# Cheat Sheet

| Topic | Summary |
|-------|---------|
| Tool | Terraform |
| Developer | HashiCorp |
| Purpose | Infrastructure as Code |
| Language | HCL |
| Works With | AWS, Azure, GCP, Kubernetes, VMware |

---

# Mini Lab

Create a file.

```bash
touch terraform-notes.md
```

Write:

- What is Terraform?
- Who developed Terraform?
- Why is Terraform used?
- What problems does it solve?

---

# Key Takeaways

- Terraform is an IaC tool.
- Infrastructure is managed using code.
- Terraform uses provider APIs.
- Infrastructure becomes repeatable and version-controlled.

---
