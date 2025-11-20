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

# Create website directory
sudo mkdir -p /var/www/html

# Write custom HTML page
cat << 'EOF' > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1" />
<title>Autonomous Self-Healing Infrastructure — Final Year Project</title>
<link href="https://fonts.googleapis.com/css2?family=Fira+Code:wght@400;600&display=swap" rel="stylesheet">
<style>
  :root{
    --bg:#0a0f1a;
    --card:#0f1722;
    --muted:#9fb0d8;
    --accent:#4ade80;
    --glass: rgba(255,255,255,0.03);
  }
  *{box-sizing:border-box}
  body{
    margin:0;
    font-family:"Fira Code",monospace;
    background:var(--bg);
    color:#e6eef8;
    -webkit-font-smoothing:antialiased;
    -moz-osx-font-smoothing:grayscale;
  }
  header{
    text-align:center;
    padding:64px 20px 36px;
    background:linear-gradient(180deg,#071021 0%, #071827 100%);
  }
  .typing-wrap{max-width:960px;margin:0 auto 18px;}
  .hero-title{font-size:2.6rem;color:var(--accent);text-shadow:0 0 16px rgba(34,197,94,0.16);margin:12px 0 6px}
  .hero-sub{color:#aabbe0;margin-bottom:20px;font-size:1.05rem}

  /* About */
  .about{max-width:980px;margin:0 auto;padding:18px 22px 36px;text-align:center}
  .about p{color:var(--muted);line-height:1.65;font-size:1rem}

  /* cards */
  .cards{display:flex;flex-wrap:wrap;gap:20px;justify-content:center;padding:18px 22px 38px}
  .card{
    width:280px; background:var(--card); border-radius:12px; padding:22px;
    border:1px solid rgba(255,255,255,0.03);
    box-shadow:0 6px 20px rgba(2,6,23,0.6);
    transition: transform .18s ease, box-shadow .18s ease;
    cursor:pointer;
  }
  .card:hover{transform:translateY(-8px); box-shadow:0 12px 30px rgba(2,120,60,0.12)}
  .card .icon{font-size:42px;margin-bottom:10px}
  .card h3{margin:6px 0;color:#fff;font-size:1.05rem}
  .card p{color:var(--muted);font-size:0.95rem}

  /* Project stacks slider - seamless */
  .stacks-wrap{max-width:1100px;margin:28px auto 8px;padding:0 12px}
  .stacks-title{font-weight:600;color:var(--accent);text-align:center;margin-bottom:12px;font-size:1.1rem}
  .slider{
    overflow:hidden;
    background:linear-gradient(180deg, rgba(255,255,255,0.01), transparent);
    border-radius:12px;
    padding:12px;
  }
  .track{
    display:flex;
    align-items:center;
    gap:28px;
    will-change:transform;
    /* animation moves left by half the track width (we duplicate icons) */
    animation: scroll 18s linear infinite;
  }
  .track img{
    width:90px;height:90px;object-fit:contain;display:block;
    filter: drop-shadow(0 6px 18px rgba(0,0,0,0.6));
  }
  @keyframes scroll {
    0%{transform:translateX(0)}
    100%{transform:translateX(-50%)}
  }

  /* Terminate button */
  .actions{display:flex;justify-content:center;padding:26px 10px}
  .terminate{
    background:#ef4444;color:white;border:none;padding:14px 28px;border-radius:10px;font-size:16px;cursor:pointer;
    box-shadow:0 8px 28px rgba(239,68,68,0.25);transition:transform .16s ease;
  }
  .terminate:hover{transform:scale(1.03)}

  /* Footer */
  footer{padding:28px 18px;text-align:center;border-top:1px solid rgba(255,255,255,0.02);margin-top:30px}
  footer p{color:var(--muted);margin:6px 0}
  footer .by{color:var(--accent);font-weight:600}

  /* Modal */
  .modal-backdrop{position:fixed;inset:0;background:rgba(2,6,23,0.6);display:none;align-items:center;justify-content:center;z-index:60}
  .modal{background:linear-gradient(180deg,#071226,#071827);padding:22px;border-radius:12px;max-width:720px;width:92%;border:1px solid rgba(255,255,255,0.04)}
  .modal h3{margin:0 0 8px}
  .modal p{color:var(--muted);line-height:1.6}
  .modal .close{position:absolute;right:16px;top:12px;background:transparent;border:none;color:#9fb0d8;font-size:20px;cursor:pointer}

  /* Responsive */
  @media (max-width:760px){
    .card{width:calc(50% - 24px)}
    .track img{width:72px;height:72px}
    .hero-title{font-size:1.9rem}
  }
  @media (max-width:460px){
    .card{width:100%}
    .track img{width:58px;height:58px}
  }
</style>
</head>
<body>

<header>
  <div class="typing-wrap">
    <!-- PROFESSIONAL FIRST SVG: Welcome to my Final Year Project -->
    <img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&weight=700&size=34&duration=3500&pause=900&color=1E90FF&center=true&vCenter=true&width=980&lines=Welcome+to+My+Final+Year+Project;Autonomous+Self-Healing+Infrastructure" alt="Welcome to my Final Year Project" style="max-width:100%;height:auto;display:block;margin:0 auto">
  </div>

  <h1 class="hero-title">Autonomous Self-Healing Infrastructure</h1>
  <div class="hero-sub">Final Year Project — <span class="by">Ahmad Hassan & Group</span></div>
</header>

<!-- ABOUT -->
<section class="about" id="about">
  <h2 style="color:var(--accent);margin-bottom:12px">About the Project</h2>
  <p>
    This project demonstrates a resilient cloud architecture that automatically recovers from instance failures.
    It uses infrastructure-as-code and AWS services to provide continuous availability with minimal human intervention.
    Click any service card below to learn more about how each component contributes to the self-healing workflow.
  </p>
</section>

<!-- SERVICE CARDS -->
<section class="cards" aria-label="Project services">
  <div class="card" data-service="lambda" onclick="openModal('AWS Lambda','AWS Lambda runs short-lived functions and automation tasks (e.g., automation for instance lifecycle events, health processing, or CI/CD hooks). In this project Lambda is used for automation tasks like instance termination handlers and integration with API Gateway.')">
    <div class="icon">⚡</div>
    <h3>AWS Lambda</h3>
    <p>Serverless compute for automation and glue logic (click for details).</p>
  </div>

  <div class="card" data-service="terraform" onclick="openModal('Terraform','Terraform manages the entire cloud infrastructure as code: VPC, subnets, ASG, ALB, security groups, and launch templates. It ensures repeatable, versioned deployments.')">
    <div class="icon">🛠️</div>
    <h3>Terraform</h3>
    <p>Infrastructure as Code — reproducible, version-controlled infra (click for details).</p>
  </div>

  <div class="card" data-service="aws" onclick="openModal('AWS Core','AWS provides the compute, networking and managed services used: EC2, Auto Scaling, ALB, CloudWatch and more. The platform hosts and scales the application.')">
    <div class="icon">☁️</div>
    <h3>AWS Core</h3>
    <p>EC2, networking and platform services powering the system (click for details).</p>
  </div>

  <div class="card" data-service="asg" onclick="openModal('Auto Scaling Group (ASG)','ASG monitors instance health and maintains the desired capacity. If an instance fails or is terminated, ASG launches a replacement automatically to maintain availability.')">
    <div class="icon">📈</div>
    <h3>Auto Scaling Group</h3>
    <p>Automatic instance replacement and scaling policies (click for details).</p>
  </div>

  <div class="card" data-service="alb" onclick="openModal('Application Load Balancer (ALB)','ALB distributes incoming traffic across healthy instances, performs health checks, and ensures requests are routed to available servers.')">
    <div class="icon">🌀</div>
    <h3>Application Load Balancer</h3>
    <p>Traffic distribution and health checks (click for details).</p>
  </div>

  <div class="card" data-service="cloudwatch" onclick="openModal('CloudWatch','CloudWatch collects logs, metrics, and alarms. It is used to track instance health, ASG activity, and trigger alerts or automation.')">
    <div class="icon">📊</div>
    <h3>CloudWatch</h3>
    <p>Central monitoring, metrics and alarms (click for details).</p>
  </div>

  <div class="card" data-service="prometheus" onclick="openModal('Prometheus','Prometheus scrapes metrics from services for detailed monitoring and alerting. It can be used alongside CloudWatch for custom application metrics and alerting rules.')">
    <div class="icon">📡</div>
    <h3>Prometheus</h3>
    <p>Open-source metrics & monitoring for deeper insights (click for details).</p>
  </div>
</section>

<!-- PROJECT STACKS (seamless loop, no gap) -->
<section class="stacks-wrap" aria-label="Project stacks">
  <div class="stacks-title">Project Stacks</div>
  <div class="slider" role="img" aria-label="Project stacks sliding icons">
    <div class="track" id="track">
      <!-- set of icons (first set) -->
      <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/aws/aws-original.svg" alt="AWS">
      <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/terraform/terraform-original.svg" alt="Terraform">
      <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/docker/docker-original.svg" alt="Docker">
      <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/kubernetes/kubernetes-plain.svg" alt="Kubernetes">
      <img src="https://www.vectorlogo.zone/logos/amazon_aws/amazon_aws-icon.svg" alt="AWS icon">
      <img src="https://www.vectorlogo.zone/logos/amazonwebservices/amazonwebservices-icon.svg" alt="AWS mark">
      <img src="https://www.vectorlogo.zone/logos/prometheusio/prometheusio-icon.svg" alt="Prometheus">
      <img src="https://www.vectorlogo.zone/logos/grafana/grafana-icon.svg" alt="Grafana">
      <!-- duplicated set immediately after for seamless loop -->
      <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/aws/aws-original.svg" alt="AWS">
      <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/terraform/terraform-original.svg" alt="Terraform">
      <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/docker/docker-original.svg" alt="Docker">
      <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/kubernetes/kubernetes-plain.svg" alt="Kubernetes">
      <img src="https://www.vectorlogo.zone/logos/amazon_aws/amazon_aws-icon.svg" alt="AWS icon">
      <img src="https://www.vectorlogo.zone/logos/amazonwebservices/amazonwebservices-icon.svg" alt="AWS mark">
      <img src="https://www.vectorlogo.zone/logos/prometheusio/prometheusio-icon.svg" alt="Prometheus">
      <img src="https://www.vectorlogo.zone/logos/grafana/grafana-icon.svg" alt="Grafana">
    </div>
  </div>
</section>

<!-- Terminate / Demo action -->
<div class="actions">
  <button class="terminate" onclick="onTerminateClick()">🛑 Terminate This Server</button>
</div>

<!-- Footer -->
<footer>
  <p>Final Year Project by <span class="by">Ahmad Hassan & Group</span></p>
  <p style="margin-top:8px;color:#9fb0d8;font-size:.92rem">© 2025 Autonomous Self-Healing Infrastructure</p>
</footer>

<!-- Modal (hidden by default) -->
<div class="modal-backdrop" id="modalBackdrop" role="dialog" aria-hidden="true" aria-modal="true">
  <div class="modal" role="document" id="modal">
    <button class="close" aria-label="Close modal" onclick="closeModal()">✕</button>
    <h3 id="modalTitle"></h3>
    <p id="modalBody"></p>
  </div>
</div>

<script>
  // Open modal with title + body
  function openModal(title, body){
    document.getElementById('modalTitle').innerText = title;
    document.getElementById('modalBody').innerText = body;
    const md = document.getElementById('modalBackdrop');
    md.style.display = 'flex';
    md.setAttribute('aria-hidden','false');
  }
  function closeModal(){
    const md = document.getElementById('modalBackdrop');
    md.style.display = 'none';
    md.setAttribute('aria-hidden','true');
  }
  // close modal with Esc
  document.addEventListener('keydown', (e)=>{ if(e.key === 'Escape') closeModal(); });

  // Terminate button behaviour (placeholder)
  function onTerminateClick(){
    // For security, termination must be implemented via API Gateway + Lambda (server-side).
    // This placeholder shows user intent and will be replaced by the real API endpoint.
    const confirmed = confirm('Are you sure you want to terminate this instance? This will trigger auto-healing by the ASG.');
    if(!confirmed) return;
    // call API (you will replace URL with your API Gateway endpoint)
    const apiUrl = 'https://REPLACE_WITH_YOUR_API_GATEWAY/terminate';
    fetch(apiUrl, { method: 'POST' })
      .then(r => {
        if(!r.ok) throw new Error('Request failed');
        alert('Termination requested. ASG will replace the instance automatically.');
      })
      .catch(err=>{
        console.warn(err);
        alert('API not configured. I can provide Terraform to create the API, Lambda and IAM.');
      });
  }

  // Accessibility: clicking backdrop closes
  document.getElementById('modalBackdrop').addEventListener('click', (e)=>{
    if(e.target.id === 'modalBackdrop') closeModal();
  });

  // Keep slider animation smooth (pauses on hover)
  const track = document.getElementById('track');
  track.addEventListener('mouseenter', ()=> track.style.animationPlayState = 'paused');
  track.addEventListener('mouseleave', ()=> track.style.animationPlayState = 'running');

  // Ensure seamless scroll: duplicated set required (already duplicated in HTML)
  // No JS needed for seamless effect beyond duplication above.
</script>

</body>
</html>

EOF

# Restart Nginx
sudo systemctl restart nginx
