# Lesson 05: Terraform vs Ansible

> Understand the difference between Infrastructure Provisioning and Configuration Management.

---

# 🎯 Learning Objectives

After this lesson, you will be able to:

- Explain what Ansible is.
- Compare Terraform and Ansible.
- Identify when to use each tool.
- Understand how they work together in production.
- Answer interview questions.

---

# 📖 What is Ansible?

Ansible is an open-source Configuration Management and Automation tool.

It is mainly used to:

- Install software
- Configure servers
- Deploy applications
- Manage operating systems
- Automate repetitive tasks

---

# 📖 What is Terraform?

Terraform is an Infrastructure as Code (IaC) tool.

It is mainly used to:

- Create infrastructure
- Update infrastructure
- Destroy infrastructure
- Manage cloud resources

---

# 🏠 Everyday Example

Imagine building a new house.

## Terraform

- Buys the land
- Builds the house
- Connects electricity
- Creates parking

## Ansible

- Paints walls
- Installs furniture
- Sets up Wi-Fi
- Configures appliances

Terraform creates.

Ansible configures.

---

# ⚙️ Production Workflow

```
Terraform
      │
Creates Infrastructure
      │
      ▼
EC2 Instance
      │
      ▼
Ansible
      │
Configures Server
      │
      ▼
Docker
Nginx
Java
Python
Application
```

---

# ⚖️ Comparison

| Terraform | Ansible |
|------------|----------|
| Infrastructure Provisioning | Configuration Management |
| Uses HCL | Uses YAML |
| Creates Cloud Resources | Configures Servers |
| Creates EC2 | Installs Docker |
| Creates VPC | Configures Nginx |
| Creates RDS | Deploys Applications |
| Manages Infrastructure | Manages Software |

---

# 🏢 Production Example

Terraform creates:

- VPC
- Subnets
- Security Groups
- EC2 Instances
- Load Balancer

After infrastructure is ready,

Ansible:

- Updates packages
- Installs Docker
- Installs Nginx
- Configures SSH
- Deploys applications

---

# ⭐ Best Practices

- Use Terraform for infrastructure.
- Use Ansible for server configuration.
- Store both in Git.
- Keep infrastructure code separate from configuration code.
- Use reusable playbooks and modules.

---

# ❌ Common Mistakes

- Installing many applications with Terraform.
- Creating complete cloud infrastructure with Ansible.
- Mixing provisioning and configuration responsibilities.

---

# 💼 Interview Question

### What is the difference between Terraform and Ansible?

Terraform provisions cloud infrastructure such as EC2 instances, VPCs, and databases using Infrastructure as Code. Ansible configures servers by installing software, managing operating systems, and deploying applications. In production, Terraform creates the infrastructure, and Ansible configures it.

---

# 📝 Revision Notes

- Terraform creates infrastructure.
- Ansible configures infrastructure.
- Terraform uses HCL.
- Ansible uses YAML Playbooks.
- Both are commonly used together.

---

# 📋 Cheat Sheet

| Task | Tool |
|------|------|
| Create EC2 | Terraform |
| Create VPC | Terraform |
| Install Docker | Ansible |
| Install Nginx | Ansible |
| Deploy Application | Ansible |
| Configure Linux | Ansible |

---

# 🧪 Mini Lab

Create 10 EC2 instances using Terraform (later in the course), then write an Ansible playbook to:

- Install Docker
- Install Nginx
- Configure SSH
- Deploy a sample web page

---

# 🔑 Key Takeaways

- Terraform provisions infrastructure.
- Ansible configures infrastructure.
- They solve different problems.
- They complement each other in real-world DevOps workflows.
- Together they automate the complete infrastructure lifecycle.

---

