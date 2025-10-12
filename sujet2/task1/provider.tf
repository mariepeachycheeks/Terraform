terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0"
    }

  }
}

provider "aws" {
  region = "eu-west-3"

  default_tags {
    tags = {
      Environment = "production"
      Project     = "C1"
      Terraformed = "true"
    }
  }

}