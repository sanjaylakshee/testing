provider "aws" {
  region = "us-east-1"
  access_key = "AKIAQANDPRTIHUHAIJWR"
  secret_key = "iz5CLJ2/XjaKVsBZYYhAC/lqr9qkbPjcqHTtK3nN"
}

resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "example-vpc"
  }
}

resource "aws_subnet" "example_subnet" {
  vpc_id     = aws_vpc.example_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "example-subnet"
  }
}

resource "aws_internet_gateway" "example_gateway" {
  vpc_id = aws_vpc.example_vpc.id
  tags = {
    Name = "example-gateway"
  }
}

resource "aws_route_table" "example_route_table" {
  vpc_id = aws_vpc.example_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example_gateway.id
  }
  tags = {
    Name = "example-route-table"
  }
}

resource "aws_route_table_association" "example_association" {
  subnet_id      = aws_subnet.example_subnet.id
  route_table_id = aws_route_table.example_route_table.id
}
