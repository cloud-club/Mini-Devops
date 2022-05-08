variable "name" {
  description = "모듈에서 정의하는 모든 리소스 이름의 prefix"
  type = string
  default = "mini"
}

variable "vpc_id"{
  description = "ALB에서 이용할 VPC id"
  type = string
}

variable "ingress_cidr_blocks"{
  description = "ALB에서 이용할 cidr blocks"
  type = string
}

variable "subnet_id"{
  description = "ALB에서 이용할 Subnet들의 id"
  type = list
}
