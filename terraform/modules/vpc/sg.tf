# bastion instance를 위한 security group
resource "aws_security_group" "mini_bastion_sg" {
  name = "mini_bastion"
  vpc_id = aws_vpc.mini_vpc.id

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "mini_bastion_sg"
  }
}

# load balancer의 security group
resource "aws_security_group" "load_balancer_sg" {
  vpc_id      = aws_vpc.mini_vpc.id
  name        = "Mini_Devops Security Group"
  description = "Mini_Devops Security Group"

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
     "Name" = "Mini_Load_Balancer_Security_Group" 
  }
}

# ecs에서 이용할 security group
resource "aws_security_group" "ecs_sg" {
  vpc_id = aws_vpc.mini_vpc.id
  name = "security_group_for_ecs_ec2"
  description = "security_group_for_ecs_ec2"

  egress {
      cidr_blocks = ["0.0.0.0/0"]
      from_port = 0
      protocol = "-1"
      to_port = 0
  }

  ingress {
      from_port = 0
      protocol = "tcp"
      to_port = 65535
  }

  tags = {
    "Name" = "security_group_ec2"
  }
}

