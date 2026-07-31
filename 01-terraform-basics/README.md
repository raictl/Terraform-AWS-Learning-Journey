# Chapter 01 – Terraform Basics

> Master the Terraform fundamentals required to provision, manage, and troubleshoot infrastructure using Infrastructure as Code (IaC).

![Terraform](https://img.shields.io/badge/Terraform-Basics-623CE4?style=for-the-badge&logo=terraform)
![AWS](https://img.shields.io/badge/AWS-Examples-FF9900?style=for-the-badge&logo=amazonaws)
![Level](https://img.shields.io/badge/Level-Beginner-success?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)

---

# 📖 Introduction

This chapter introduces the core concepts of Terraform and the standard workflow used by DevOps and Cloud Engineers to provision and manage infrastructure.

By the end of this chapter, you will understand how Terraform initializes projects, validates configurations, previews infrastructure changes, manages state, resolves dependencies, and safely deploys infrastructure in production environments.

This chapter forms the foundation for all future Terraform topics.

---

# 🎯 Learning Objectives

After completing this chapter, you will be able to:

- Understand the Terraform workflow
- Initialize Terraform projects
- Format and validate Terraform code
- Generate and review execution plans
- Apply and destroy infrastructure
- Understand Terraform State and its lifecycle
- Differentiate between Local and Remote State
- Use Terraform State commands safely
- Understand the Dependency Graph
- Follow production-ready Terraform workflows
- Troubleshoot common Terraform issues
- Apply Terraform best practices

---

# 🗺️ Learning Path

```text
Terraform Basics

│

├── Terraform CLI

│      ├── terraform init

│      ├── terraform fmt

│      ├── terraform validate

│      ├── terraform plan

│      ├── terraform apply

│      └── terraform destroy

│

├── Terraform State

│      ├── State Basics

│      ├── State Lifecycle

│      ├── Local vs Remote State

│      └── State Commands

│

├── Dependency Graph

├── Execution Plan

├── Production Workflow

├── Common Errors

├── Troubleshooting

│

└── Revision & Cheat Sheet
```

---

# 📂 Chapter Contents

| # | Topic | Description |
|---|--------|-------------|
| 01 | [`terraform-init.md`](./terraform-init.md) | Initialize a Terraform working directory |
| 02 | [`terraform-fmt.md`](./terraform-fmt.md) | Format Terraform configuration files |
| 03 | [`terraform-validate.md`](./terraform-validate.md) | Validate Terraform configuration |
| 04 | [`terraform-plan.md`](./terraform-plan.md) | Preview infrastructure changes |
| 05 | [`terraform-apply.md`](./terraform-apply.md) | Deploy infrastructure |
| 06 | [`terraform-destroy.md`](./terraform-destroy.md) | Remove managed infrastructure |
| 07 | [`terraform-refresh.md`](./terraform-refresh.md) | Refresh state (legacy) and modern alternatives |
| 08 | [`terraform-state.md`](./terraform-state.md) | Understand Terraform State |
| 09 | [`state-lifecycle.md`](./state-lifecycle.md) | Learn the State lifecycle |
| 10 | [`local-vs-remote-state.md`](./local-vs-remote-state.md) | Compare Local and Remote State |
| 11 | [`state-commands.md`](./state-commands.md) | Manage Terraform State |
| 12 | [`dependency-graph.md`](./dependency-graph.md) | Understand resource dependencies |
| 13 | [`execution-plan.md`](./execution-plan.md) | Learn Execution Plans |
| 14 | [`production-workflow.md`](./production-workflow.md) | Enterprise Terraform workflow |
| 15 | [`common-errors.md`](./common-errors.md) | Common Terraform errors |
| 16 | [`troubleshooting.md`](./troubleshooting.md) | Production troubleshooting guide |
| 17 | [`terraform-basics-revision.md`](./terraform-basics-revision.md) | Quick revision notes |
| 18 | [`terraform-basics-cheat-sheet.md`](./terraform-basics-cheat-sheet.md) | Daily quick reference |

---

# 🔄 Terraform Workflow

```text
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
Infrastructure Created
```

---

# 🏗️ Core Concepts Covered

- Terraform CLI
- Infrastructure as Code (IaC)
- Terraform State
- Local State
- Remote State
- Backend Initialization
- Dependency Graph
- Execution Plan
- Production Workflow
- Infrastructure Drift
- State Management
- Troubleshooting

---

# 🛠️ Prerequisites

Before starting this chapter, you should be familiar with:

- Basic Linux commands
- Git and GitHub
- AWS fundamentals
- Infrastructure as Code concepts

> **Recommended:** Complete **Chapter 00 – Prerequisites** first.

---

# 💻 Hands-on Skills You Will Gain

By completing the labs in this chapter, you will be able to:

- Initialize Terraform projects
- Validate and format Terraform code
- Review execution plans before deployment
- Deploy AWS infrastructure
- Destroy infrastructure safely
- Inspect and manage Terraform State
- Troubleshoot common deployment failures
- Follow production-ready deployment workflows

---

# ⭐ Best Practices

- Run `terraform fmt` before every commit.
- Validate configurations before planning.
- Review every execution plan.
- Use Remote State for team environments.
- Protect Terraform State files.
- Store Terraform code in Git.
- Avoid manual infrastructure changes.
- Apply reviewed plans in production.

---

# 🎯 Interview Skills Covered

This chapter prepares you to answer interview questions on:

- Terraform workflow
- Terraform CLI commands
- State management
- Local vs Remote State
- Dependency Graph
- Execution Plans
- Infrastructure Drift
- Production deployments
- Troubleshooting

---

# 📚 Chapter Summary

In this chapter, you learned the complete Terraform lifecycle—from initializing a project to deploying, managing, and troubleshooting infrastructure. You also explored how Terraform tracks resources using State, determines execution order through the Dependency Graph, previews changes with Execution Plans, and supports safe, collaborative workflows in production environments.

These fundamentals form the foundation for advanced Terraform topics such as variables, modules, lifecycle rules, workspaces, remote backends, and reusable infrastructure.

---

# 🚀 Next Chapter

➡️ **Chapter 02 – Terraform Language (HCL)**

Upcoming topics include:

- HCL Syntax
- Blocks
- Arguments
- Expressions
- Variables
- Data Types
- Locals
- Outputs
- Functions
- Meta Arguments
- Dynamic Blocks
- For Expressions
- Conditional Expressions

---

## 🤝 Contributing

Found an issue or have an improvement?

Feel free to open an Issue or submit a Pull Request.

Contributions are always welcome!

---

## 📜 License

This project is licensed under the MIT License.
