# VPC
resource "aws_vpc" "server" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  region               = var.region
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Server VPC"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  pub_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
  ]


  subnet_public_names = [
    "public-subnet-1",
    "public-subnet-2",
    "public-subnet-3",
  ]
}



resource "aws_subnet" "public" {
  count             = 3
  vpc_id            = aws_vpc.server.id
  cidr_block        = local.pub_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
map_public_ip_on_launch = true
  tags = {
    Name = local.subnet_public_names[count.index]
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.server.id

  tags = {
    Name = "internet_gateway"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.server.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "public"
  }
}

resource "aws_route_table_association" "rta" {
  count          = 3
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}