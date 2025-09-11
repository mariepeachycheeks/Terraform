resource "aws_route_table_association" "sub_pub1_rta" {
  subnet_id      = aws_subnet.public[0].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "sub_pub2_rta" {
  subnet_id      = aws_subnet.public[1].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "sub_pub3_rta" {
  subnet_id      = aws_subnet.public[2].id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table_association" "sub_priv1_rta" {
  subnet_id      = aws_subnet.private[0].id
  route_table_id = aws_route_table.private_1.id
}

resource "aws_route_table_association" "sub_priv2_rta" {
  subnet_id      = aws_subnet.private[1].id
  route_table_id = aws_route_table.private_2.id
}

resource "aws_route_table_association" "sub_priv3_rta" {
  subnet_id      = aws_subnet.private[2].id
  route_table_id = aws_route_table.private_3.id
}

resource "aws_route_table_association" "endpoint" {
  subnet_id      = aws_subnet.private[0].id
  route_table_id = aws_route_table.private_1.id

}