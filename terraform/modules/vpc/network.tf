resource "aws_vpc" "mini_vpc" {
  cidr_block           = "10.0.0.0/16"

  tags = {
    Name = "mini_vpc"
  }
  instance_tenancy = "default"

}
data "aws_availability_zones" "available" {

}

resource "aws_subnet" "pub_subnet" {
  vpc_id            = aws_vpc.mini_vpc.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = var.region
  tags = {
    Name = "pub_subnet"
  }
}
resource "aws_subnet" "private_subnet_1a" {
	vpc_id            = aws_vpc.mini_vpc.id
	cidr_block        = "10.0.2.0/24"
	availability_zone = var.region

	tags { 
    Name = "Private Subnet 1A" 
  }
}

resource "aws_subnet" "private_subnet_1b" {
	vpc_id            = aws_vpc.mini_vpc.id
	cidr_block        = "10.0.3.0/24"
	availability_zone = var.region
  
  	tags { 
      Name = "Private Subnet 1B" 
    }
}

resource "aws_internet_gateway" "mini_igw" {
  vpc_id = aws_vpc.mini_vpc.id

  tags = {
    Name = "mini-igw"
  }
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.mini_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mini_igw.id
  }

  tags = {
    Name = "mini-route-table"
  }
}

resource "aws_security_group" "mini_sg" {
  vpc_id      = "${aws_vpc.mini_vpc.id}"
  name        = "Mini_Devops Security Group"
  description = "Mini_Devops Security Group"

  tags { Name = "Mini_Devops Security Group" }
}

resource "aws_eip" "mini_EIP" {
  vpc   = true
}

resource "aws_nat_gateway" "mini_nat" {
  allocation_id = aws_eip.EIP.id
  subnet_id     = aws_subnet.pub_subnet

  tags = {Name="mini-nat"}
}


resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.mini_vpc
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.mini_nat.id
  }

  tags = {Name="mini-private-route-table"}
}

resource "aws_route_table_association" "private_routing_a" {
  count = 1
  route_table_id = aws_route_table.private_route_table
  subnet_id      = aws_subnet.private_subnet_1a.id
}

resource "aws_route_table_association" "private_routing_b" {
  count = 1
  route_table_id = aws_route_table.private_route_table
  subnet_id      = aws_subnet.private_subnet_1b.id
}
