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
  availability_zone = var.availability_zone
}

module "ec2"{
  source = "./modules/ec2"
  name = "bastion"
  ami = "ami-0cbec04a61be382d9"
  instance_type = "t2.micro"
  availability_zone = module.vpc.public_subnet.availability_zone
  subnet_id = module.vpc.public_subnet.id
  keypair_name = "mini-devops"
  bastion_sg = module.vpc.bastion_sg
}

module "alb"{
  source = "./modules/alb"
  load_balancer_sg = module.vpc.load_balancer_sg
  load_balancer_subnet_a = module.vpc.private_subnet_a
  load_balancer_subnet_b = module.vpc.private_subnet_b
  vpc = module.vpc.vpc
}

module "iam" {
  source = "./modules/iam"
}

module "ecr"{
  source = "./modules/ecr"
  ecr_name = "mini-ecr"
}

module "ecs"{
  source = "./modules/ecs"
  ecr = module.ecr.ecr
  iam_role_policy_attachment = module.iam.iam_role_policy_attachment
  target_group = module.alb.ecs_target_group

}

