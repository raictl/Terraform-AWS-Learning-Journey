# 🚀 Terraform AWS Learning Journey


![GitHub last commit](https://img.shields.io/github/last-commit/raictl/Terraform-AWS-Learning-Journey?style=for-the-badge)
![GitHub repo size](https://img.shields.io/github/repo-size/raictl/Terraform-AWS-Learning-Journey?style=for-the-badge)
![GitHub stars](https://img.shields.io/github/stars/raictl/Terraform-AWS-Learning-Journey?style=for-the-badge)
![GitHub forks](https://img.shields.io/github/forks/raictl/Terraform-AWS-Learning-Journey?style=for-the-badge)

> A hands-on journey to master **Terraform** and **Amazon Web Services (AWS)** by building real-world Infrastructure as Code (IaC) projects from the ground up.

![Terraform](https://img.shields.io/badge/Terraform-IaC-7B42BC?style=for-the-badge&logo=terraform)
![AWS](https://img.shields.io/badge/AWS-Cloud-FF9900?style=for-the-badge&logo=amazonaws)
![Status](https://img.shields.io/badge/Status-In%20Progress-blue?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

---

# 📖 About This Repository

Welcome to my **Terraform AWS Learning Journey**!

This repository documents my hands-on learning experience with **Terraform** and **AWS**, focusing on Infrastructure as Code (IaC) and cloud automation.

The goal is not only to learn Terraform syntax but also to understand **how production-ready AWS infrastructure is designed, deployed, and managed using Terraform**.

Every topic in this repository includes practical examples, explanations, and real-world use cases to strengthen both theoretical and hands-on knowledge.

---

# 🎯 Objectives

- Learn Infrastructure as Code (IaC)
- Master Terraform fundamentals
- Understand AWS core services
- Build reusable Terraform modules
- Learn Terraform state management
- Deploy production-style AWS infrastructure
- Follow Terraform and AWS best practices
- Build a strong DevOps portfolio

---

# 🗂 Repository Structure

```text
Terraform-AWS-Learning-Journey/
│
├── README.md
├── .gitignore
├── LICENSE
│
├── 01-basics/
│   ├── providers/
│   ├── variables/
│   ├── outputs/
│   └── locals/
│
├── 02-aws/
│   ├── ec2/
│   ├── s3/
│   ├── iam/
│   ├── vpc/
│   └── security-groups/
│
├── 03-modules/
│
├── 04-state-management/
│
├── 05-workspaces/
│
├── 06-remote-backend/
│
├── 07-projects/
│   ├── static-website/
│   ├── wordpress/
│   └── three-tier-app/
│
├── modules/
│
└── docs/
    ├── notes.md
    ├── commands.md
    └── architecture/
```

---

# 🛣 Learning Roadmap

## 📚 Phase 1 — Terraform Basics

- [x] Repository Setup
- [x] Terraform Installation
- [ ] Terraform CLI
- [ ] Providers
- [ ] Resources
- [ ] Variables
- [ ] Outputs
- [ ] Locals
- [ ] Data Sources
- [ ] Functions
- [ ] Expressions

---

## ☁️ Phase 2 — AWS Resources

- [ ] Configure AWS Provider
- [ ] EC2 Instance
- [ ] Security Groups
- [ ] VPC
- [ ] Subnets
- [ ] Internet Gateway
- [ ] Route Tables
- [ ] NAT Gateway
- [ ] Elastic IP
- [ ] S3 Bucket
- [ ] IAM Users & Roles

---

## 🧩 Phase 3 — Intermediate Terraform

- [ ] Variable Validation
- [ ] Local Values
- [ ] Output Values
- [ ] Count Meta-Argument
- [ ] for_each
- [ ] Dynamic Blocks
- [ ] Conditional Expressions
- [ ] Lifecycle Rules
- [ ] Provisioners

---

## 📦 Phase 4 — Modules & State Management

- [ ] Create Modules
- [ ] Reusable Modules
- [ ] Module Inputs & Outputs
- [ ] Terraform State
- [ ] Remote Backend (S3)
- [ ] State Locking (DynamoDB)
- [ ] Terraform Workspaces
- [ ] Import Existing Resources

---

## 🚀 Phase 5 — Real-World Projects

- [ ] Static Website Hosting
- [ ] Custom VPC
- [ ] Public & Private Subnets
- [ ] Bastion Host
- [ ] Application Load Balancer
- [ ] Auto Scaling Group
- [ ] WordPress Deployment
- [ ] Three-Tier Architecture
- [ ] CloudWatch Monitoring

---

# 🛠 Prerequisites

Before running the examples, make sure you have:

- Terraform installed
- AWS CLI installed
- Git installed
- Visual Studio Code (Recommended)
- An AWS Account
- An IAM User with appropriate permissions
- AWS CLI configured

---

# 🚀 Getting Started

## 1. Clone the Repository

```bash
git clone https://github.com/raictl/Terraform-AWS-Learning-Journey.git
```

## 2. Navigate to the Project

```bash
cd Terraform-AWS-Learning-Journey
```

## 3. Initialize Terraform

```bash
terraform init
```

## 4. Validate Configuration

```bash
terraform validate
```

## 5. Preview Infrastructure

```bash
terraform plan
```

## 6. Deploy Infrastructure

```bash
terraform apply
```

## 7. Destroy Infrastructure

```bash
terraform destroy
```

---

# 📚 Topics Covered

- Terraform CLI
- Providers
- Resources
- Variables
- Outputs
- Locals
- Data Sources
- Modules
- Terraform State
- Remote Backend
- Workspaces
- AWS EC2
- AWS VPC
- AWS IAM
- AWS S3
- Security Groups
- Route Tables
- Internet Gateway
- NAT Gateway
- Best Practices

---

# 📂 Documentation

Additional notes and learning resources are available in the **docs/** directory.

Topics include:

- Terraform Notes
- AWS Notes
- Common Commands
- Best Practices
- Architecture Diagrams
- Troubleshooting Tips

---

# 💡 Best Practices Followed

- Clean folder structure
- Reusable Terraform modules
- Version pinning
- Resource tagging
- Consistent formatting
- Descriptive variable names
- Documentation for every example
- Incremental Git commits
- Learning-focused organization

---

# ⚠️ Important Notes

This repository is intended for learning purposes.

Some Terraform examples may provision billable AWS resources.

Always remember to destroy resources after testing to avoid unnecessary AWS charges.

```bash
terraform destroy
```

---

# 🤝 Contributing

Suggestions, improvements, and discussions are welcome!

If you have ideas to improve this repository, feel free to:

- Open an Issue
- Submit a Pull Request
- Share best practices

---

# 📈 Repository Progress

| Section | Status |
|----------|--------|
| Repository Setup | ✅ Completed |
| Terraform Basics | 🚧 In Progress |
| AWS Resources | ⏳ Planned |
| Modules | ⏳ Planned |
| State Management | ⏳ Planned |
| Real Projects | ⏳ Planned |

---

# 📚 Learning Resources

- Terraform Official Documentation
- AWS Documentation
- Terraform Registry
- AWS Well-Architected Framework

---

# 📜 License

This project is licensed under the **MIT License**.

---

# ⭐ Support

If you find this repository useful, please consider giving it a **⭐ Star**.

It motivates me to continue documenting my learning journey and sharing practical Terraform + AWS examples with the community.

---

## 👨‍💻 Author

**Prayagraj**

Learning • Building • Automating • Sharing

> *"The best way to learn Infrastructure as Code is by building real infrastructure."*

---

**Happy Learning! 🚀**
