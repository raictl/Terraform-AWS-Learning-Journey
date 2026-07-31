# Terraform Dependency Graph

> Learn how Terraform determines the correct order for creating, updating, and deleting infrastructure using the Dependency Graph.

---

# 📖 Overview

Terraform does **not** execute resources randomly.

Instead, it builds a **Dependency Graph**—a directed graph that identifies relationships between resources and determines the safest execution order.

This graph allows Terraform to:

- Create resources in the correct order
- Destroy resources safely
- Execute independent resources in parallel
- Avoid dependency conflicts

> 💡 **Pro Tip:** The Dependency Graph is one of Terraform's biggest advantages over writing manual shell scripts.

---

# 🎯 Learning Objectives

After completing this lesson, you will be able to:

- Understand the Dependency Graph
- Learn implicit and explicit dependencies
- Use `depends_on`
- Visualize dependencies
- Avoid circular dependencies
- Understand parallel execution

---

# Why Do We Need a Dependency Graph?

Imagine you want to launch an EC2 instance.

Can AWS create the EC2 instance before its VPC exists?

**No.**

The order must be:

```text
VPC
 ↓
Subnet
 ↓
Security Group
 ↓
EC2 Instance
```

Terraform automatically discovers these relationships.

---

# Internal Working

```text
Terraform Configuration
          │
          ▼
Parse HCL Files
          │
          ▼
Identify Resource References
          │
          ▼
Build Dependency Graph
          │
          ▼
Determine Execution Order
          │
          ▼
Call AWS APIs
```

---

# Implicit Dependency

Terraform automatically creates dependencies when one resource references another.

Example:

```hcl
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
}
```

### Why is there a dependency?

This line:

```hcl
vpc_id = aws_vpc.main.id
```

tells Terraform:

> "The subnet cannot exist until the VPC exists."

Terraform automatically creates the dependency.

No additional configuration is required.

---

# Explicit Dependency (`depends_on`)

Sometimes resources do not reference each other directly, but one still depends on another.

Example:

```hcl
resource "aws_security_group" "web" {
  name   = "web-sg"
  vpc_id = aws_vpc.main.id
}

resource "aws_instance" "web" {
  ami           = "ami-xxxxxxxx"
  instance_type = "t3.micro"

  depends_on = [
    aws_security_group.web
  ]
}
```

Terraform ensures the Security Group is fully created before starting the EC2 instance.

> **Note:** Use `depends_on` only when Terraform cannot infer the dependency automatically.

---

# Dependency Graph Example

```text
          VPC
           │
           ▼
        Subnet
           │
     ┌─────┴─────┐
     ▼           ▼
Route Table   Security Group
     │           │
     └─────┬─────┘
           ▼
      EC2 Instance
```

Terraform processes the graph from top to bottom.

---

# Parallel Execution

Terraform creates independent resources simultaneously.

Example:

```text
        VPC
         │
   ┌─────┴─────┐
   ▼           ▼
Subnet A   Subnet B
   │           │
   ▼           ▼
EC2-A      EC2-B
```

After the VPC is created:

- Subnet A and Subnet B can be created **in parallel**.
- EC2 instances can also be created **in parallel** once their respective subnets are ready.

This reduces deployment time.

---

# Circular Dependency

A circular dependency occurs when two resources depend on each other.

```text
Resource A
     ▲
     │
     ▼
Resource B
```

Terraform cannot determine which resource should be created first and reports a **Cycle** error.

---

# Visualizing the Graph

Generate a dependency graph:

```bash
terraform graph
```

The output is in **DOT** format.

To generate an image (requires Graphviz):

```bash
terraform graph | dot -Tpng > dependency-graph.png
```

---

# Real-World Use Cases

- Multi-tier VPC deployments
- Auto Scaling Groups
- Application Load Balancers
- RDS databases
- NAT Gateways
- Route Tables
- IAM Roles attached to EC2 instances

---

# Best Practices

- Let Terraform infer dependencies whenever possible.
- Avoid unnecessary `depends_on`.
- Keep resources modular.
- Review the graph for complex deployments.
- Use `terraform graph` when troubleshooting dependency issues.

---

# Common Mistakes

- Overusing `depends_on`
- Creating circular dependencies
- Hardcoding resource IDs instead of referencing resources
- Ignoring dependency errors

---

# Interview Questions

### 1. What is the Terraform Dependency Graph?

A directed graph that determines the correct order for creating, updating, and destroying resources.

---

### 2. What is an implicit dependency?

A dependency Terraform automatically detects through resource references.

---

### 3. What is an explicit dependency?

A dependency defined using `depends_on` when Terraform cannot infer it automatically.

---

### 4. Does Terraform create resources sequentially?

Not always.

Independent resources are created in parallel whenever possible.

---

### 5. What command generates the dependency graph?

```bash
terraform graph
```

---

### 6. What is a circular dependency?

A situation where two or more resources depend on each other, preventing Terraform from determining a valid execution order.

---

# 📋 Cheat Sheet

| Concept | Description |
|---------|-------------|
| Implicit Dependency | Created automatically through references |
| Explicit Dependency | Defined using `depends_on` |
| Graph Command | `terraform graph` |
| Parallel Execution | Independent resources created simultaneously |
| Circular Dependency | Invalid dependency loop |

---

# 📝 Summary

Terraform's Dependency Graph is the engine that determines the correct order of infrastructure operations. By automatically detecting relationships between resources and executing independent tasks in parallel, Terraform provides safe, efficient, and reliable infrastructure deployments. Understanding dependency management is essential for building scalable and maintainable Infrastructure as Code.
