# 🌍 AWS Self-Healing Infrastructure using Terraform + Nginx

This project demonstrates how to build a **self-healing web server infrastructure** on AWS using **Terraform** and **Auto Scaling Groups**.  
If an EC2 instance fails or is terminated, AWS automatically recreates it — ensuring **zero downtime**.

---

## 🚀 Features
✅ Fully automated AWS infrastructure provisioning  
✅ Auto-healing EC2 instances using Auto Scaling Group  
✅ Load balancing using Application Load Balancer (ALB)  
✅ Nginx web server automatically installed via user data  
✅ Infrastructure as Code using Terraform  

---

## 🧩 Project Structure

selfhealing-terraform/
│
├── main.tf # Main Terraform configuration
├── variables.tf # Input variables (VPC, subnets, etc.)
├── userdata.tpl # Nginx auto-installation + HTML page script
├── outputs.tf # ALB DNS output
└── README.md # Project documentation


---

## ⚙️ Prerequisites
- AWS account (with admin access)
- AWS CLI configured locally  
- Terraform v1.x installed  
- Git installed  

---

## 🪜 Step-by-Step Setup

### **Step 1: Clone the repository**

```bash
git clone https://github.com/<your-username>/selfhealing-terraform.git
cd selfhealing-terraform
Step 2: Initialize Terraform
terraform init

Step 3: Review the plan
terraform plan

Step 4: Deploy the infrastructure
terraform apply -auto-approve


Terraform will:

Create a VPC, subnets, and security groups

Launch an EC2 Auto Scaling Group with Nginx installed

Attach a Load Balancer

Output the ALB DNS URL

🌐 Step 5: Access the Application

After deployment, Terraform outputs a DNS like:

alb_dns_name = selfheal-alb-1234567890.us-east-1.elb.amazonaws.com


Visit that URL in your browser — you’ll see a green Nginx + Terraform + AWS web page.

🧠 Step 6: Test Self-Healing

Go to AWS Console → EC2 → Instances
➡️ Terminate the running instance manually.

Within a minute, Auto Scaling will automatically launch a new instance — your app stays live 🎯.

🧹 Step 7: Clean Up Resources

To avoid charges:

terraform destroy -auto-approve
