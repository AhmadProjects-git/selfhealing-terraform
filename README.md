# 🌍 **Autonomous Self-Healing Infrastructure using AWS + Terraform + Nginx**

This project showcases how to build a **fully automated and self-healing web server infrastructure** on **Amazon Web Services (AWS)** using **Terraform**.
If any EC2 instance fails or is terminated, the **Auto Scaling Group (ASG)** automatically recreates it — ensuring **zero downtime** and **high availability**.

---

## 🚀 **Features**

✅ Fully automated AWS infrastructure provisioning via **Terraform**
✅ **Self-healing EC2 instances** using Auto Scaling Groups
✅ **Application Load Balancer (ALB)** for traffic distribution
✅ **Nginx web server** auto-installed using a user data script
✅ Built entirely as **Infrastructure as Code (IaC)**
✅ Modular, reusable Terraform configuration

---

## 🧩 **Project Structure**

```
Autonomous-SelfHealing-Infrastructure/
│
├── main.tf            # Core infrastructure definitions
├── provider.tf        # AWS provider configuration
├── variables.tf       # Input variables (region, AMI, instance type, etc.)
├── security.tf        # Security group and firewall rules
├── vpc.tf             # VPC, subnets, and networking configuration
├── userdata.tpl       # Nginx auto-installation and sample HTML page
├── outputs.tf         # ALB DNS output after deployment
├── .terraform.lock.hcl# Terraform dependency lock file
└── README.md          # Project documentation
```

---

## ⚙️ **Prerequisites**

Before you begin, make sure you have the following:

* ☁️ **AWS Account** (with administrative permissions)
* 💻 **AWS CLI** installed and configured locally
* 🧱 **Terraform v1.x** installed
* 🔗 **Git** installed

---

## 🪜 **Setup Instructions**

### **Step 1: Clone the Repository**

```bash
git clone https://github.com/AhmadProjects-git/Autonomous-SelfHealing-Infrastructure.git
cd Autonomous-SelfHealing-Infrastructure
```

### **Step 2: Initialize Terraform**

```bash
terraform init
```

### **Step 3: Review the Plan**

```bash
terraform plan
```

### **Step 4: Deploy the Infrastructure**

```bash
terraform apply -auto-approve
```

✅ Terraform will:

* Create a **VPC**, **subnets**, and **security groups**
* Launch an **EC2 Auto Scaling Group** with Nginx installed
* Configure and attach an **Application Load Balancer**
* Output the **ALB DNS endpoint**

---

## 🌐 **Step 5: Access Your Application**

Once deployment completes, Terraform will output something like:

```
alb_dns_name = selfheal-alb-1234567890.us-east-1.elb.amazonaws.com
```

Open that URL in your browser 🌍
You’ll see a green **“Nginx + Terraform + AWS”** webpage — confirming successful deployment ✅

---

## 🧠 **Step 6: Test the Self-Healing Capability**

1. Log in to the **AWS Console → EC2 → Instances**
2. Manually **terminate** the running instance 🧨
3. Watch the **Auto Scaling Group** automatically launch a **new instance** 🎯

Your application will remain available throughout — **no downtime**!

---

## 🧹 **Step 7: Clean Up Resources**

When you’re done testing, destroy all resources to avoid costs:

```bash
terraform destroy -auto-approve
```

---

## 🧰 **Technologies Used**

* **AWS EC2, VPC, ALB, Auto Scaling Groups**
* **Terraform (IaC)**
* **Nginx Web Server**
* **User Data scripting**

---

## 👨‍💻 **Maintainer**

**Developed by:** [@AhmadProjects-git](https://github.com/AhmadProjects-git)
🌐 GitHub Repository: [Autonomous-SelfHealing-Infrastructure](https://github.com/AhmadProjects-git/Autonomous-SelfHealing-Infrastructure)

---

## 💬 **Support & Contributions**

💡 Found an issue or have ideas to improve?

* Open an [Issue](https://github.com/AhmadProjects-git/Autonomous-SelfHealing-Infrastructure/issues)
* Or submit a [Pull Request](https://github.com/AhmadProjects-git/Autonomous-SelfHealing-Infrastructure/pulls)

---

**Happy Automating! 🤖⚙️**
*Build resilient, self-healing, and autonomous cloud systems — the DevOps way!* 🌩️

---

🏁 License

This project is licensed under the MIT License.
You’re free to use, modify, and distribute it — just give credit 💙

---
