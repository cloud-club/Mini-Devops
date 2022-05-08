# SG for ALB
resource "aws_security_group" "mini-alb" {
  name        = "mini-alb"
  description = "Security group for ALB"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "${var.ingress_cidr_blocks}"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
      Name = "${var.name}-alb-sg"
  }
}

# Application load balancer
resource "aws_lb" "mini-alb" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.mini-alb.id}"]
  subnets            = [for subnet in var.subnet_id : subnet]

  enable_deletion_protection = true

  tags = {
    Environment = "production",
    Name = "${var.name}-alb"
  }
}

# target group
resource "aws_lb_target_group" "mini_tg" {
  name     = "${var.name}-tg"
  port     = 80
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = "${var.vpc_id}"

  health_check {
    interval            = 30
    path                = "/"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags { Name = "Mini Target Group" }
}


