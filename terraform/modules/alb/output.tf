output "alb" {
  value = aws_lb.mini-alb
}

output "ecs_target_group" {
  value = aws_lb_target_group.mini-tg
}