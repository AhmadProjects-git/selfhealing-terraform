data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_launch_template" "web_lt" {
  name_prefix   = "selfheal-lt-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = base64encode(file("${path.module}/userdata.tpl"))

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.web_sg.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags          = { Name = "selfheal-instance" }
  }
}

resource "aws_autoscaling_group" "web_asg" {
  desired_capacity    = 1
  max_size            = 2
  min_size            = 1
  vpc_zone_identifier = [aws_subnet.public_a.id, aws_subnet.public_b.id]

  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }

  health_check_type         = "EC2"
  health_check_grace_period = 60

  tag {
    key                 = "Name"
    value               = "selfheal-asg-instance"
    propagate_at_launch = true
  }
}

resource "aws_lb" "app_lb" {
  name                       = "selfheal-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.web_sg.id]
  subnets                    = [aws_subnet.public_a.id, aws_subnet.public_b.id]
  enable_deletion_protection = false
  tags                       = { Name = "selfheal-alb" }
}

resource "aws_lb_target_group" "tg" {
  name     = "selfheal-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  health_check {
    path                = "/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_autoscaling_attachment" "asg_tg" {
  autoscaling_group_name = aws_autoscaling_group.web_asg.id
  lb_target_group_arn    = aws_lb_target_group.tg.arn

}
# ===============================
# OUTPUTS
# ===============================
output "alb_dns_name" {
  description = "Public DNS name of the Application Load Balancer"
  value       = aws_lb.app_lb.dns_name
}

