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
  name = "sjh-test"
  source = "./vpc"
  vpc_cidr_block = "10.0.0.0/16"
  public_subnet_cidr_block = "10.0.0.0/24"
}

