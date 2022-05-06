resource "aws_vpc" "mini_vpc" {
  tags = {
    Name = "mini_vpc"
  }
  instance_tenancy = "default"
  cidr_block = "10.0.0.0/16"
}
data "aws_availability_zones" "available" {

}

resource "aws_subnet" "pub_subnet" {
  vpc_id            = aws_vpc.mini_vpc.id
  cidr_block        = "10.0.10.0/24"
  tags = {
    Name = "pub_subnet"
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

