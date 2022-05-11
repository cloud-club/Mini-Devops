output "alb" {
  value = aws_lb.mini_alb
}

output "ecs_target_group" {
  value = aws_lb_target_group.mini_tg
}