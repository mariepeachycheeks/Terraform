/*##### PROD APP FRONT SG
resource "aws_security_group" "prod_app_front" {
  name        = "prod-app-front-sg"
  description = "SG for prod-app-front"
  vpc_id      = aws_vpc.production.id

  tags = {
    Name = "prod-app-front-sg"
  }
}
resource "aws_vpc_security_group_egress_rule" "prod_app_front_http" {
  security_group_id            = aws_security_group.prod_app_front.id
  referenced_security_group_id = aws_security_group.prod_app_back_alb.id
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80
}



##### PROD APP BACK ALB SG
resource "aws_security_group" "prod_app_back_alb" {
  name        = "prod-app-back-alb-sg"
  description = "SG for prod-app-back ALB"
  vpc_id      = aws_vpc.production.id

  tags = {
    Name = "prod-app-back-alb-sg"
  }
}


resource "aws_security_group" "prod_app_back" {
  name        = "prod-app-back-sg"
  description = "SG for prod-app-back"
  vpc_id      = aws_vpc.production.id

  tags = {
    Name = "prod-app-back-sg"
  }
}
*/

resource "aws_security_group" "front_lb_sg" {
  name        = "front-lb-sg"
  description = "Allow TCP inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.production.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    //security_groups = [aws_security_group.prod_app_front_sg.id]
  }

}
/*
resource "aws_vpc_security_group_egress_rule" "allow_prod_app_front" {
  security_group_id = aws_security_group.front_lb_sg.id
  referenced_security_group_id = aws_security_group.prod_app_front_sg.id
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}
*/
resource "aws_security_group" "prod_app_front_sg" {
  name        = "prod-app-front-sg"
  description = "Allow front-alb inbound traffic and back-alb outbound traffic"
  vpc_id      = aws_vpc.production.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    //security_groups = [aws_security_group.front_lb_sg.id]
  }


  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    //security_groups = [aws_security_group.back_lb_sg.id]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    //security_groups = [aws_security_group.back_lb_sg.id]
  }

}

/*

resource "aws_vpc_security_group_ingress_rule" "allow_front_lb_sg" {
  security_group_id = aws_security_group.front_lb_sg.id
  referenced_security_group_id = aws_security_group.front_lb_sg.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_back_lb_sg_https" {
  security_group_id = aws_security_group.front_lb_sg.id
  referenced_security_group_id = aws_security_group.back_lb_sg.id
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_back_lb_sg" {
  security_group_id = aws_security_group.front_lb_sg.id
  referenced_security_group_id = aws_security_group.back_lb_sg.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}
*/

resource "aws_security_group" "back_lb_sg" {
  name        = "back-lb-sg"
  description = "Allow prod-app-front inbound traffic and prod-app-back or all outbound traffic" // BRANDON QUESTION
  vpc_id      = aws_vpc.production.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    //security_groups = [aws_security_group.prod_app_front_sg.id]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    //security_groups = [aws_security_group.prod_app_back_sg.id]
  }


}

/*resource "aws_vpc_security_group_ingress_rule" "allow_prod_app_front_sg" {
  security_group_id = aws_security_group.front_lb_sg.id
  referenced_security_group_id = aws_security_group.prod_app_front_sg.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

BRANDON: Egress - pour prod app back on n'a pas besoin parce que ca sera jamais initié de prod-app-back, mais plutot de LB ver l'instance???*/

resource "aws_security_group" "prod_app_back_sg" {
  name        = "prod-app-back-sg"
  description = "Allow back-lg inbound traffic and all outbound"
  vpc_id      = aws_vpc.production.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    //security_groups = [aws_security_group.back_lb_sg.id]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    //security_groups = [aws_security_group.back_lb_sg.id]
  }

  egress {

    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {

    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {

    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

/*resource "aws_vpc_security_group_ingress_rule" "allow_back_lb_sg" {
  security_group_id = aws_security_group.front_lb_sg.id
  referenced_security_group_id = aws_security_group.back_lb_sg.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}*/


resource "aws_security_group" "data_base" {
  name        = "data_base"
  description = "data_base"
  vpc_id      = aws_vpc.production.id

  tags = {
    Name = "data_base"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_prod_app_back" {
  security_group_id = aws_security_group.data_base.id
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
  //cidr_ipv4         = "0.0.0.0/0"
  referenced_security_group_id = aws_security_group.prod_app_back_sg.id
}

resource "aws_security_group" "endpoint" {
  name        = "endpoint"
  description = "endpoint"
  vpc_id      = aws_vpc.production.id

}


resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "allow_all"
  vpc_id      = aws_vpc.production.id

  tags = {
    Name = "Allow all"
  }
}
resource "aws_vpc_security_group_ingress_rule" "allow_all" {
  security_group_id = aws_security_group.allow_all.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}
resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.allow_all.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}