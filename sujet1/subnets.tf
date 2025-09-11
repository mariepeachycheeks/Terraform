resource "aws_subnet" "public" {
  count = length(local.subnet_public_names)

  vpc_id            = aws_vpc.production.id
  cidr_block        = local.pub_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = local.subnet_public_names[count.index]
  }
}

resource "aws_subnet" "private" {
  count = length(local.subnet_private_names)

  vpc_id            = aws_vpc.production.id
  cidr_block        = local.priv_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = local.subnet_private_names[count.index]
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = aws_subnet.private[*].id

  tags = {
    Name = "RDS Subnet Group"
  }
}