data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_default_tags" "current" {}
data "aws_ami" "ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}
/*data "aws_ami" "ami" {
  region = var.region
  most_recent = true

  filter {
    name   = "name"
    values = ["Amazon Linux 2023"]
  }
  
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}*/

/*output "ami"{
    value = data.aws_ami.ami
}*/