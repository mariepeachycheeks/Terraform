locals {
  subnet_public_names = ["sub_pub_1", "sub_pub_2", "sub_pub_3"]
  pub_cidrs           = ["10.0.1.0/24", "10.0.3.0/24", "10.0.5.0/24"]

  subnet_private_names = ["sub_priv_1", "sub_priv_2", "sub_priv_3"]
  priv_cidrs           = ["10.0.2.0/24", "10.0.4.0/24", "10.0.6.0/24"]

  azs = ["us-east-1a", "us-east-1b", "us-east-1c"]
}