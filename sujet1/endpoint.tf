resource "aws_vpc_endpoint" "s3endpoint" {
  vpc_id            = aws_vpc.production.id
  service_name      = "com.amazonaws.${var.region}.s3"
  route_table_ids   = [aws_route_table.private_1.id, aws_route_table.private_2.id, aws_route_table.private_3.id, aws_route_table.public.id]
  vpc_endpoint_type = "Gateway"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = "*"
      Action = [
        "s3:GetObject",
        "s3:ListBucket"
      ]
      Resource = "*"
    }]
  })

  tags = {
    Name = "app-vpce-s3"
  }
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = aws_vpc.production.id
  service_name      = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [aws_subnet.private[0].id, aws_subnet.private[1].id, aws_subnet.private[2].id]
  security_group_ids = [
    aws_security_group.allow_all.id,
  ]

  private_dns_enabled = true
}




resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id            = aws_vpc.production.id
  service_name      = "com.amazonaws.${var.region}.ssmmessages"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [aws_subnet.private[0].id, aws_subnet.private[1].id, aws_subnet.private[2].id]
  security_group_ids = [
    aws_security_group.allow_all.id,
  ]

  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id            = aws_vpc.production.id
  service_name      = "com.amazonaws.${var.region}.ec2messages"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [aws_subnet.private[0].id, aws_subnet.private[1].id, aws_subnet.private[2].id]
  security_group_ids = [
    aws_security_group.allow_all.id,
  ]

  private_dns_enabled = true
}