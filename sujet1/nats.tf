resource "aws_eip" "nat1" {
  domain = "vpc"
}

resource "aws_eip" "nat2" {
  domain = "vpc"
}

resource "aws_eip" "nat3" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gw_1" {
  subnet_id         = aws_subnet.public[0].id
  allocation_id     = aws_eip.nat1.id
  connectivity_type = "public" #POSER QUESTION A BRANDON!!!! 
  tags = {
    Name = "nat_gw_1"
  }
  depends_on = [aws_internet_gateway.internet_gateway]
}

resource "aws_nat_gateway" "nat_gw_2" {
  subnet_id         = aws_subnet.public[1].id
  allocation_id     = aws_eip.nat2.id
  connectivity_type = "public" #POSER QUESTION A BRANDON!!!! 
  tags = {
    Name = "nat_gw_2"
  }
  depends_on = [aws_internet_gateway.internet_gateway]
}

resource "aws_nat_gateway" "nat_gw_3" {
  subnet_id         = aws_subnet.public[2].id
  allocation_id     = aws_eip.nat3.id
  connectivity_type = "public" #POSER QUESTION A BRANDON!!!! 

  tags = {
    Name = "nat_gw_3"
  }
  depends_on = [aws_internet_gateway.internet_gateway]
}

/*module "nat1" {
  source = "./modules/ngw"

  subnet_id = aws_subnet.public[0].id
  
  name = "nat_gw_1"
}

module "nat2" {
  source = "./modules/ngw"

  subnet_id = aws_subnet.public[1].id
  
  name = "nat_gw_2"

}

module "nat3" {
  source = "./modules/ngw"

  subnet_id = aws_subnet.public[2].id
  
  name = "nat_gw_3"
}*/