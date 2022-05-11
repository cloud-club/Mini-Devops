resource "aws_lb" "mini_alb" {
  name               = "mini-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [
    var.load_balancer_sg.id]
  subnets            = [
    var.load_balancer_subnet_a.id,
    var.load_balancer_subnet_b.id]

  tags = {
    Name = "mini-alb"
    Project = "mini-alb"
    Billing = "mini-alb"
  }
}

resource "aws_lb_target_group" "mini_tg" {
  name     = "mini-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc.id
  target_type = "ip"

  health_check {
    enabled             = true
    interval            = 300
    path                = "/"
    timeout             = 60
    matcher             = "200"
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  tags = {
    Name = "mini-tg"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.mini_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.mini_tg.arn
  }
}