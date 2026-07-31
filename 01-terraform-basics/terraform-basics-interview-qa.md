# Terraform Basics Interview Questions & Answers

> A comprehensive interview guide covering Terraform Basics, Terraform CLI, State Management, Execution Plan, Dependency Graph, Production Workflow, and Troubleshooting.

---

# 🎯 How to Use This Guide

This guide is divided into multiple sections:

- Beginner
- Intermediate
- Advanced
- Scenario-Based
- Troubleshooting
- Rapid Fire

If you are preparing for interviews:

- **0–2 Years** → Focus on Beginner + Rapid Fire
- **2–5 Years** → Complete Beginner + Intermediate + Scenario-Based
- **5+ Years** → Study every section

---

# Section 1 – Beginner Interview Questions

## Q1. What is Terraform?

**Answer**

Terraform is an Infrastructure as Code (IaC) tool developed by HashiCorp that allows you to provision and manage infrastructure using declarative configuration files.

---

## Q2. What is Infrastructure as Code?

**Answer**

Infrastructure as Code (IaC) is the practice of managing infrastructure through code instead of manual configuration.

---

## Q3. Who developed Terraform?

**Answer**

HashiCorp.

---

## Q4. Which language does Terraform use?

**Answer**

HashiCorp Configuration Language (HCL).

---

## Q5. Is Terraform declarative or imperative?

**Answer**

Declarative.

You describe the desired state, and Terraform determines how to achieve it.

---

## Q6. What is a Provider?

**Answer**

A provider is a plugin that enables Terraform to interact with a specific platform, such as AWS, Azure, Google Cloud, or Kubernetes.

---

## Q7. What is a Resource?

**Answer**

A resource represents an infrastructure object managed by Terraform, such as an EC2 instance, VPC, or Security Group.

---

## Q8. What is Terraform State?

**Answer**

Terraform State is a file that stores information about infrastructure managed by Terraform and maps configuration to real resources.

---

## Q9. Which file stores Terraform State?

**Answer**

```text
terraform.tfstate
```

---

## Q10. Why is Terraform State important?

**Answer**

Terraform uses the state file to:

- Track resources
- Detect changes
- Plan updates
- Avoid recreating existing infrastructure

---

## Q11. What does `terraform init` do?

**Answer**

- Initializes the working directory
- Downloads provider plugins
- Configures the backend
- Creates `.terraform.lock.hcl`

---

## Q12. What does `terraform fmt` do?

**Answer**

Formats Terraform code according to the official HCL style.

---

## Q13. What does `terraform validate` do?

**Answer**

Checks the syntax and validates the configuration without accessing cloud resources.

---

## Q14. What does `terraform plan` do?

**Answer**

Generates an execution plan showing what Terraform will create, update, or destroy.

---

## Q15. What does `terraform apply` do?

**Answer**

Executes the approved execution plan and updates the infrastructure.

---

## Q16. What does `terraform destroy` do?

**Answer**

Removes all infrastructure managed by the current Terraform configuration.

---

## Q17. What is `.terraform`?

**Answer**

A working directory containing downloaded providers, backend metadata, and other Terraform-generated files.

---

## Q18. What is `.terraform.lock.hcl`?

**Answer**

A dependency lock file that records the exact provider versions used by the project.

---

## Q19. What is the difference between Local State and Remote State?

**Answer**

Local State is stored on the developer's machine.

Remote State is stored in a shared backend for collaboration.

---

## Q20. Why is Remote State preferred?

**Answer**

Because it enables collaboration, centralized management, improved security, and coordinated state operations.

---

## Q21. What is an Execution Plan?

**Answer**

A preview of infrastructure changes Terraform intends to make.

---

## Q22. What does the `+` symbol indicate in a plan?

**Answer**

A new resource will be created.

---

## Q23. What does the `~` symbol indicate?

**Answer**

An existing resource will be updated.

---

## Q24. What does the `-` symbol indicate?

**Answer**

A resource will be destroyed.

---

## Q25. What is Infrastructure Drift?

**Answer**

Infrastructure Drift occurs when the actual infrastructure differs from Terraform's expected state due to changes made outside Terraform.
