# Lesson 01: Infrastructure as Code (IaC)

> The first step in my Terraform & AWS Learning Journey.

---

## 📖 What is Infrastructure as Code (IaC)?

Infrastructure as Code (IaC) is the practice of managing and provisioning infrastructure using code instead of manually creating resources through a graphical user interface (GUI).

Infrastructure includes:

- 🖥️ Servers (EC2)
- 🌐 Networks (VPC, Subnets)
- 🛡️ Security Groups
- 💾 Storage (S3, EBS)
- 🗄️ Databases (RDS)
- ⚖️ Load Balancers

Instead of clicking through the AWS Console, we define infrastructure in code and let an IaC tool create it automatically.

---

## 🤔 Why Do We Need IaC?

Without IaC:

- Manual work
- Time-consuming deployments
- Human errors
- Different environments
- Difficult disaster recovery
- No version control

With IaC:

- Fast deployments
- Repeatable infrastructure
- Consistent Dev, Test, and Production environments
- Version-controlled infrastructure
- Easy collaboration
- Automated deployments

---

## ☁️ Everyday Example

Imagine making tea every morning.

Without a recipe:
- Every cup tastes different.

With a recipe:
- Every cup tastes exactly the same.

IaC works like a recipe for your infrastructure.

---

## 🔄 Manual vs IaC

### Manual Infrastructure

```
Engineer
    │
    ▼
AWS Console
    │
    ▼
Click → Click → Click → Click
```

### Infrastructure as Code

```
Terraform Code
       │
       ▼
Terraform
       │
       ▼
AWS Infrastructure
```

---

## ✅ Advantages of IaC

- Faster infrastructure provisioning
- Consistent environments
- Version control with Git
- Reduced human errors
- Easy disaster recovery
- Automation
- Better team collaboration
- Reusable infrastructure
- Easy scaling
- Improved auditing and change tracking

---

## 🏢 Where Do Companies Use IaC?

IaC is widely used in:

- DevOps
- Platform Engineering
- Cloud Engineering
- Site Reliability Engineering (SRE)
- DevSecOps
- Multi-cloud environments

---

## 🎯 Interview Answer

**Q: What is Infrastructure as Code (IaC)?**

**Answer:**

Infrastructure as Code (IaC) is the practice of provisioning and managing infrastructure using code instead of manual processes. It enables automation, consistency, version control, repeatability, and faster deployments across different environments.

---

## 📝 Revision Notes

- IaC = Infrastructure as Code
- Infrastructure is defined in code.
- Eliminates manual cloud provisioning.
- Supports version control.
- Ensures consistency.
- Enables automation.
- Makes disaster recovery easier.

---

## 📚 Cheat Sheet

| Topic | Summary |
|--------|---------|
| IaC | Infrastructure managed using code |
| Goal | Automation and consistency |
| Benefits | Speed, Repeatability, Version Control |
| Used By | DevOps, SRE, Cloud Engineers |
| Popular Tools | Terraform, OpenTofu, AWS CloudFormation, Pulumi |

---

## 💻 Mini Lab

```bash
mkdir terraform-aws-learning-journey
cd terraform-aws-learning-journey

mkdir 00-prerequisites
cd 00-prerequisites

touch notes.md
```

Write your own definition of Infrastructure as Code in `notes.md`.

---

## 📌 Key Takeaways

- Infrastructure can be managed like software.
- IaC reduces manual effort and errors.
- The same code can create identical environments.
- Infrastructure changes can be tracked using Git.
- IaC is a foundational skill for DevOps, Cloud, and Platform Engineers.

---
