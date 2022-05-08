variable "name"{
  description = "ec2의 이름"
  type        = string
}

variable "ami" {
  description = "ec2 생성에 사용할 AMI"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro" 
}

variable "availability_zone" {
  description = "EC2 instance availability zone"
  type        = string
}

variable "subnet_id" {
  description = "EC2 instance Subnet ID"
  type        = string
}

variable "keypair_name" {
  description = "Ec2가 사용할 keypair name"
  type        = string
}

variable "bastion_sg" {}