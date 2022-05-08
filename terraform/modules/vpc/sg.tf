# bastion instance를 위한 security group
resource "aws_security_group" "mini-bastion-sg" {
  name = "mini-bastion"
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
    "Name" = "mini-bastion-sg"
  }
}

