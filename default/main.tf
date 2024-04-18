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

provider "aws" {
  region = "us-east-1"
  alias = "virginia"
}

module "vpc" {
  source = "./vpc"
}

module "ec2" {
  source = "./ec2"
  public_subnet_ids	 = module.vpc.public_subnet_ids
  private_subnet_ids	 = module.vpc.private_subnet_ids
  security_group_id_bastion	 = module.sg.security_group_id_bastion
  security_group_id_private 	= module.sg.security_group_id_private
  security_group_id_web_sg	= module.sg_security_group_id_web_sg
  alb_tg_arn			= module.lb.alb_tg_arn
}

module "sg" {
  source = "./sg"
  vpc_id = module.vpc.vpc_id
}

module "lb" {
  source = "./lb"
  public_subnet_ids = module.vpc.public_subnet_ids
  security_group_id_web_sg = module.sg.security_group_id_web_sg
  vpc_id = module.vpc.vpc_id
  web_ids = module.ec2.web_ids
  acm_arn = module.route53.acm_arn
  acm_validation = module.route53.acm_validation
}

module "route53" {
  source	= "./route53"
  lb_zone_id 	= module.lb.zone_id
  name 		= var.name 
  lb_dns_name	= module.lb.lb_dns_name
}

