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
	cidr_block        = "10.2.3.0/24"
	availability_zone = "ap-northeast-1a"

	tags { Name = "Private Subnet 1A" }
}

resource "aws_subnet" "application_private_1c" {
	vpc_id            = aws_vpc.mini_vpc.id
	cidr_block        = "10.2.4.0/24"
	availability_zone = "ap-northeast-1c"
  
  	tags { Name = "Private Subnet 1C" }
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