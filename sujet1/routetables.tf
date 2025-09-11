resource "aws_route_table" "public" {
  vpc_id = aws_vpc.production.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "public"
  }
}



resource "aws_route_table" "private_1" {
  vpc_id = aws_vpc.production.id

  route {
    cidr_block = "0.0.0.0/0"
    //nat_gateway_id = aws_nat_gateway.nat1.id
    nat_gateway_id = aws_nat_gateway.nat_gw_1.id
  }

  tags = {
    Name = "private_1"
  }
}

resource "aws_route_table" "private_2" {
  vpc_id = aws_vpc.production.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_2.id

    //nat_gateway_id = aws_nat_gateway.nat2.id
  }

  tags = {
    Name = "private_2"
  }
}

resource "aws_route_table" "private_3" {
  vpc_id = aws_vpc.production.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_3.id

    //nat_gateway_id = aws_nat_gateway.nat3.id
  }

  tags = {
    Name = "private_3"
  }
}