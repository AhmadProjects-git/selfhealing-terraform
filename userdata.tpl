#!/bin/bash
# Log everything to /var/log/user-data.log
exec > /var/log/user-data.log 2>&1
set -eux

echo "===== Starting Nginx installation ====="

# Wait for apt locks to be released
while sudo fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1; do
  echo "Waiting for apt lock..."
  sleep 5
done

# Update and install nginx
sudo apt-get update -y
sudo apt-get install -y nginx

# Enable and start nginx
sudo systemctl enable nginx
sudo systemctl start nginx

# Create a sample page
sudo mkdir -p /var/www/html
cat <<'EOF' | sudo tee /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>🚀 Self-Healing Cloud Infrastructure</title>
  <style>
    body {
      background: #0a0f1a;
      color: #d8e2f3;
      font-family: "Segoe UI", sans-serif;
      text-align: center;
      padding: 60px 20px;
      animation: fadeIn 1.5s ease-in-out;
    }

    h1 {
      font-size: 48px;
      color: #4ade80;
      text-shadow: 0 0 15px #22c55e;
      margin-bottom: 10px;
    }

    h2 {
      font-weight: 300;
      font-size: 20px;
      opacity: 0.8;
      margin-bottom: 40px;
    }

    .container {
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
      justify-content: center;
      margin-top: 30px;
    }

    .card {
      background: #111827;
      width: 260px;
      padding: 25px;
      border-radius: 15px;
      box-shadow: 0 0 18px rgba(0,255,100,0.15);
      transition: transform .25s ease, box-shadow .25s ease;
      border: 1px solid #1f2937;
    }

    .card:hover {
      transform: translateY(-10px) scale(1.03);
      box-shadow: 0 0 25px rgba(0,255,100,0.55);
    }

    .icon {
      font-size: 45px;
      margin-bottom: 15px;
    }

    .footer {
      margin-top: 60px;
      opacity: 0.6;
      font-size: 14px;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to   { opacity: 1; transform: translateY(0); }
    }
  </style>
</head>

<body>

  <h1>⚙️ Self-Healing Cloud Infrastructure</h1>
  <h2>Fully Automated • Terraform • AWS • Auto Scaling • Nginx</h2>

  <div class="container">

    <div class="card">
      <div class="icon">🌐</div>
      <h3>AWS EC2</h3>
      <p>Auto-provisioned web servers with full automation & monitoring.</p>
    </div>

    <div class="card">
      <div class="icon">📈</div>
      <h3>Auto Scaling Group</h3>
      <p>Self-healing mechanism replaces unhealthy servers instantly.</p>
    </div>

    <div class="card">
      <div class="icon">🌀</div>
      <h3>Application Load Balancer</h3>
      <p>Distributes traffic & performs health checks every 30 seconds.</p>
    </div>

    <div class="card">
      <div class="icon">📦</div>
      <h3>Terraform</h3>
      <p>Infrastructure as Code — repeatable & version-controlled deployments.</p>
    </div>

    <div class="card">
      <div class="icon">🧩</div>
      <h3>Nginx Web Server</h3>
      <p>Fast, lightweight HTTP server deployed automatically at boot.</p>
    </div>

    <div class="card">
      <div class="icon">🔁</div>
      <h3>Self-Healing Logic</h3>
      <p>If this instance dies, ASG launches a new one within seconds.</p>
    </div>

  </div>

  <div class="footer">
    🚀 Built Automatically using Terraform & AWS • Dark Mode Enabled • Self-Healing Active
  </div>

</body>
</html>
EOF
