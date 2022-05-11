resource "aws_security_group" "ec2" {
    name = "security_group_ec2"
    description = "security_group_ec2"

    egress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 0
        protocol = "-1"
        to_port = 0
    }

    ingress {
        from_port = 0
        protocol = "tcp"
        security_groups = [aws_lb.mini-alb.id]
        to_port = 65535
    }

    tags = {
      "Name" = "security_group_ec2"
    }

    vpc_id = aws_vpc.mini_vpc.id
}