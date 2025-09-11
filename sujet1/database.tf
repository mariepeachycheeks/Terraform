resource "aws_rds_cluster" "prod_app_db" {
  cluster_identifier   = "prod-app-db"
  engine               = "aurora-mysql"
  availability_zones   = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1], data.aws_availability_zones.available.names[2]]
  database_name        = "innovatech"
  master_username      = "admin"
  master_password      = "init1234*"
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  skip_final_snapshot  = true # Default (can omit this line)
  //final_snapshot_identifier = "prod-app-db-final-snap-${timestamp()}"
  vpc_security_group_ids = [aws_security_group.data_base.id]
  serverlessv2_scaling_configuration {
    max_capacity = 2
    min_capacity = 0
  }

}

resource "aws_rds_cluster_instance" "cluster_instances" {
  identifier         = "prod-app-1"
  cluster_identifier = aws_rds_cluster.prod_app_db.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.prod_app_db.engine
  engine_version     = aws_rds_cluster.prod_app_db.engine_version
}


/*
resource "aws_db_instance" "prod_app_db" {
  allocated_storage    = 10
  db_name              = "innovatech"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "init1234*"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.data_base.id]
  
*/

/*serverlessv2_scaling_configuration {
    min_capacity = 0.5
    max_capacity = 2
  }*/





resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = aws_subnet.private[*].id

  tags = {
    Name = "My DB subnet group"
  }
}





