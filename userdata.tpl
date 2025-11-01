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
<html>
  <head><title>Terraform Nginx Server</title></head>
  <body style="text-align:center; margin-top:50px;">
    <h1 style="color:green;">Welcome to Terraform Self-Healing Server</h1>
    <h3>Powered by Auto Scaling + Nginx</h3>
  </body>
</html>
EOF

echo "===== Nginx installation complete ====="

