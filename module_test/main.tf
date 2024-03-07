terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region	= "ap-northeast-2"
}

module "vpc" {
  source = "./vpc"
  vpc_cidr_block = var.vpc_cidr_block
  public_subnets = var.public_subnet_ids
}

