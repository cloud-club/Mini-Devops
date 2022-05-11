output "vpc" {
  value = aws_vpc.mini_vpc
}

output "public_subnet" {
  value = aws_subnet.pub_subnet
}

output "private_subnet_a" {
  value = aws_subnet.private_subnet_1a
}

output "private_subnet_b" {
  value = aws_subnet.private_subnet_1b
}

output "load_balancer_sg" {
  value = aws_security_group.load_balancer_sg
}

output "ecs_sg" {
  value = aws_security_group.ecs_sg
}

output "bastion_sg"{
  value = aws_security_group.mini_bastion_sg
}