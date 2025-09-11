resource "aws_eip" "this" {
  domain = "vpc"
}

resource "aws_nat_gateway" "this" {
  subnet_id         = var.subnet_id
  allocation_id     = aws_eip.this.id
  connectivity_type = "public" #POSER QUESTION A BRANDON!!!! 
  tags = {
    Name = var.name
  }
  //depends_on = [aws_internet_gateway.internet_gateway]
}