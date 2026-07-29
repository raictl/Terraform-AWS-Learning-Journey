# Lesson 07: Declarative vs Imperative

> Learn the two major approaches to infrastructure automation and understand why Terraform uses the declarative model.

---

# 🎯 Learning Objectives

After completing this lesson, you will be able to:

- Understand Declarative and Imperative approaches.
- Explain the differences.
- Know why Terraform is Declarative.
- Identify tools that use each approach.
- Answer interview questions confidently.

---

# 📖 What is Imperative?

Imperative means telling the computer **how** to perform every step.

You provide all instructions in sequence.

Example:

1. Create a VPC.
2. Create a Subnet.
3. Create an EC2 instance.
4. Install software.
5. Configure networking.

The tool follows your exact instructions.

---

# 📖 What is Declarative?

Declarative means describing **what** you want.

You define the desired final state.

Example:

"I need one VPC, two subnets, and two EC2 instances."

Terraform decides how to create them.

---

# 🏠 Everyday Example

Imagine traveling from your home to the airport.

## Imperative

Turn left.

Go straight.

Turn right.

Take the flyover.

Take Exit 4.

Every step is specified.

---

## Declarative

Book a cab.

Tell the driver:

"Take me to the airport."

The driver decides the route.

Terraform works in the same way.

---

# ⚙️ How Terraform Works

```
Desired State
       │
       ▼
Terraform
       │
Calculates Changes
       │
       ▼
Actual Infrastructure
```

Terraform compares:

- Desired state
- Current state

Then makes only the required changes.

---

# ⚖️ Comparison

| Declarative | Imperative |
|-------------|------------|
| Focuses on desired state | Focuses on execution steps |
| Easier to maintain | More manual effort |
| Less code | More code |
| Automatically calculates changes | User defines every action |
| Used by Terraform | Used in shell scripts and many programming languages |

---

# 🏢 Production Example

### Imperative

A Bash script:

- Create VPC
- Create Subnet
- Create EC2
- Create Security Group

Every command must be written manually.

### Declarative

Terraform configuration:

```
Desired Infrastructure:

- VPC
- Two Subnets
- Two EC2 Instances
```

Terraform determines the order of creation.

---

# ⭐ Best Practices

- Prefer declarative infrastructure whenever possible.
- Let Terraform calculate dependencies.
- Avoid unnecessary manual provisioning.
- Keep configurations simple and readable.

---

# ❌ Common Mistakes

- Treating Terraform like a shell script.
- Manually changing infrastructure after deployment.
- Assuming Terraform executes resources line by line.

---

# 💼 Interview Question

### Why is Terraform called a declarative tool?

Terraform is declarative because users describe the desired infrastructure instead of defining every step required to build it. Terraform compares the desired state with the current state and automatically performs the necessary actions to reach the target state.

---

# 📝 Revision Notes

- Declarative = Describe the desired outcome.
- Imperative = Describe every step.
- Terraform is declarative.
- Bash scripting is imperative.
- Declarative infrastructure is easier to maintain.

---

# 📋 Cheat Sheet

| Topic | Declarative | Imperative |
|--------|-------------|------------|
| Focus | Desired State | Execution Steps |
| User Controls | What | How |
| Example | Terraform | Bash Script |
| Maintenance | Easier | Harder |
| Automation | Higher | Lower |

---

# 🧪 Mini Lab

Choose three tools you already know (for example, Terraform, Bash, Ansible, Docker Compose, Kubernetes).

Classify each as:

- Declarative
- Imperative

Then explain why.

---

# 🔑 Key Takeaways

- Terraform follows the declarative model.
- Declarative focuses on the desired state.
- Imperative focuses on the execution process.
- Declarative configurations are easier to manage and scale.
- Understanding this concept is essential for Terraform.

---
