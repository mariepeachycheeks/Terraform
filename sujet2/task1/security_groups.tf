resource "aws_security_group" "alb" {
  name        = "alb"
  description = "Allow HTTP inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.server.id

  tags = {
    Name = "alb_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_alb" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id            = aws_security_group.alb.id
  referenced_security_group_id = aws_security_group.ec2.id
  from_port                    = 0
  ip_protocol                  = "tcp"
  to_port                      = 65000
}


resource "aws_security_group" "ec2" {
  name        = "ec2"
  description = "Allow alb inbound traffic"
  vpc_id      = aws_vpc.server.id

  tags = {
    Name = "ec2_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ec2" {
  security_group_id = aws_security_group.ec2.id
  referenced_security_group_id = aws_security_group.alb.id
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
}


//Je ne me rappellle plus pourquoi j'ai mis cette egress rule
resource "aws_vpc_security_group_egress_rule" "allow_https_ec2" {
  security_group_id = aws_security_group.ec2.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}




