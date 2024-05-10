terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.27.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

module "vpc" {
  source = "./vpc"
}

module "ec2" {
  source = "./ec2"
  public_subnet_ids	 = module.vpc.public_subnet_ids
  security_group_id_bastion	 = module.sg.security_group_id_bastion
}

module "sg" {
  source = "./sg"
  vpc_id = module.vpc.vpc_id
}
