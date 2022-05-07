terraform {  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}
# terraform settings, including the required providers 
# terraform will use it to provision infrastructure


provider "aws" {
  profile = "default"
  region = var.region
}