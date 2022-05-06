variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "region" {
  type    = string
  default = "ap-northeast-2"
}

variable "tag_name" {
  type    = string
  default = "service"
}


variable "container_port" {
  type    = number
  default = 80
}


variable "host_port" {
  type    = number
  default = 80
}

variable "bucket_name" {
  type = string
  default = "mini_dev5849"
}

variable "app_name" {
  type = string
  default = "mini_devops"
}