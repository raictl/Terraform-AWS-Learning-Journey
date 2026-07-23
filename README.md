# Terraform AWS Learning Journey 🚀

A beginner-friendly, hands-on journey learning **Terraform** on **AWS** — from
absolute basics to production-grade infrastructure, through 25 real
projects and plain-English notes anyone can follow.

## 📌 About This Repo

This repo is both my personal learning log **and** a free, open resource
for anyone who wants to learn Terraform + AWS from scratch. Everything
here is explained in simple language first — no assumed prior cloud or
coding experience — then backed by real, working code you can run
yourself.

**Goal:** Go from zero to production-ready IaC skills (state management,
modules, remote backends, CI/CD, multi-environment setups) by actually
building 25 real projects — not just copy-pasting code without
understanding it.

**New here?** Start with [`notes/00-terraform-basics.md`](notes/00-terraform-basics.md),
then build [Project 1](project-01-static-website-s3/).

## 📓 Notes — Terraform Explained Simply

Plain-English concept notes (with everyday analogies, no jargon) written
before diving into each project — anyone can follow along, even with zero
prior experience: **[notes/](notes/)**

## 🗺️ Project Roadmap (Basics → Expert)

Learning Terraform + AWS by building 25 progressively harder projects — from a single S3 bucket to a production-grade, multi-account, multi-region setup.

### 🟢 Level 1: Beginner — Core Concepts (Project 1-6)
| # | Project | Key Concepts | Status |
|---|---|---|---|
| 1 | Static Website on S3 | Providers, resources, `init/plan/apply` | 🔲 |
| 2 | S3 Bucket with Versioning & Lifecycle Rules | Resource arguments, tags | 🔲 |
| 3 | EC2 Instance with Key Pair | Variables, outputs | 🔲 |
| 4 | Security Group + EC2 (Web Server) | Data sources, dependencies | 🔲 |
| 5 | IAM User, Group & Policy Setup | IAM resources, least privilege | 🔲 |
| 6 | Remote State with S3 Backend + DynamoDB Lock | State management, locking | 🔲 |

### 🟡 Level 2: Intermediate — Real Infrastructure (Project 7-13)
| # | Project | Key Concepts | Status |
|---|---|---|---|
| 7 | Custom VPC with Public/Private Subnets | Networking, route tables, IGW | 🔲 |
| 8 | NAT Gateway + Private EC2 Access | NAT, bastion host pattern | 🔲 |
| 9 | Application Load Balancer + Auto Scaling Group | ASG, target groups, health checks | 🔲 |
| 10 | RDS (MySQL/Postgres) with Private Subnet | Databases, subnet groups, secrets | 🔲 |
| 11 | Reusable VPC Module | Writing your own modules | 🔲 |
| 12 | Multi-Environment Setup (dev/staging/prod) | Workspaces or dir-per-env pattern | 🔲 |
| 13 | Terraform + `terraform.tfvars` per Environment | Variable files, `-var-file` | 🔲 |

### 🟠 Level 3: Advanced — Serverless & Automation (Project 14-19)
| # | Project | Key Concepts | Status |
|---|---|---|---|
| 14 | Lambda Function + API Gateway | Serverless, IAM roles for Lambda | 🔲 |
| 15 | S3 → Lambda Trigger Pipeline | Event-driven architecture | 🔲 |
| 16 | ECS Cluster with Fargate | Containers, task definitions | 🔲 |
| 17 | EKS Cluster (basic) | Kubernetes on AWS via Terraform | 🔲 |
| 18 | CI/CD Pipeline (GitHub Actions → Terraform Apply) | Automation, `plan` on PR, `apply` on merge | 🔲 |
| 19 | Terraform Modules Published to a Private Registry | Module versioning, reuse | 🔲 |

### 🔴 Level 4: Expert — Production-Grade (Project 20-25)
| # | Project | Key Concepts | Status |
|---|---|---|---|
| 20 | Multi-Region Active-Passive Architecture | Provider aliases, cross-region | 🔲 |
| 21 | Multi-Account Setup with AWS Organizations | Assume-role, account isolation | 🔲 |
| 22 | Policy as Code with OPA / Sentinel | Governance, compliance guardrails | 🔲 |
| 23 | Cost Estimation with Infracost in CI | Cost visibility before apply | 🔲 |
| 24 | Automated Testing with Terratest | Unit/integration testing for IaC | 🔲 |
| 25 | Full Production Capstone: 3-Tier App (VPC + ALB + ASG + RDS + CI/CD + Monitoring) | Everything combined | 🔲 |

*(Status: 🔲 Not Started · 🔄 In Progress · ✅ Done — updated as I build each project)*

## 📂 Repo Structure

```
Terraform-AWS-Learning-Journey/
├── project-01-static-website-s3/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── README.md         # what I built + what I learned
├── project-02-s3-versioning-lifecycle/
│   ├── main.tf
│   └── README.md
├── ...
├── project-25-capstone-3-tier-app/
│   └── README.md
└── README.md               # you are here
```

## 🛠️ Tech & Tools

- **IaC:** Terraform
- **Cloud:** AWS (EC2, VPC, S3, IAM, and more as the course progresses)
- **Version Control:** Git & GitHub

## ⚙️ Prerequisites

To run any of the code in this repo yourself:

- [Terraform CLI](https://developer.hashicorp.com/terraform/install) installed
- AWS CLI installed and configured (`aws configure`) with a scoped IAM user
- An AWS account (free tier is enough for most early lessons)

## 💻 My Environment

I practice across both Linux and Windows, so my setup is verified on both:

| Tool | Linux | Windows |
|---|---|---|
| Terraform CLI | ✅ Installed & configured | ✅ Installed & configured |
| AWS CLI | ✅ Installed & `aws configure` done | ✅ Installed & `aws configure` done |

To verify your own setup is ready:

```bash
terraform -version
aws --version
aws sts get-caller-identity   # confirms AWS CLI is authenticated correctly
```

## ▶️ How to Run Any Day's Code

```bash
cd day01
terraform init
terraform plan
terraform apply
# ... explore the resource in the AWS Console ...
terraform destroy
```

## 🧠 Key Learnings So Far

*(This section grows as I go — one or two bullet points per major concept.)*

- *(coming soon)*

## 📖 Notes to Future Me

*(Personal cheat-sheet of things that tripped me up — gotchas, error messages, fixes.)*

- *(coming soon)*

## 🔗 Resources

- [Terraform Docs](https://developer.hashicorp.com/terraform/docs)
- [AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Course repo I'm following](https://github.com/piyushsachdeva/Terraform-Full-Course-Aws)

---

⭐ Following along or learning too? Feel free to fork this and track your own journey.
