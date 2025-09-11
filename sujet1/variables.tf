variable "region" {}
variable "ami" {
  //default = data.aws_ami.ami.id
}


/*ariable "subnets_db"{
    type = list(string)
    default     = aws_subnet.private[*].id
}*/