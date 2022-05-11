terraform {  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
  region = var.region
}

module "iam" {
  source = "./modules/iam"
}

module "alb"{
  source = "./modules/alb"
  load_balancer_sg = module.vpc.load_balancer_sg
  load_balancer_subnet_a = module.vpc.private_subnet_1a
  load_balancer_subnet_b = module.vpc.private_subnet_1b
  vpc = module.vpc.vpc
}

module "security_group"{
  source = "./modules/security_group"
  aws_lb = module.alb.aws_lb
  aws_vpc = module.vpc.aws_vpc
  aws_security_group = module.security_group
}
module "ecs"{
  source = "./modules/ecs"

}

module "ecr"{
  source = "./modules/ecr"
  ecr_name = "mini_ecr"

}

module "auto_scaling"{
  source = "./modules/auto-scaling"
  ecs_cluster = module.ecs.ecs_cluster
  ecs_service = module.ecs.ecs_service
}

module "ec2"{
  source = "./modules/ec2"
  name = "bastion"
  ami = "ami-0cbec04a61be382d9"
  instance_type = "t2.micro"
  availability_zone = "ap-northeast-2a"
  subnet_id = module.vpc.pub_subnet
  keypair_name = aws_key_pair.mini_key_pair
  bastion_sg = module.vpc.mini_bastion_sg
}
