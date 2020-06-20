variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_path" {}
variable "aws_key_name" {}

variable "availability_zone" {
  description = "availability zone used for the demo, based on region"
  default = {
    us-east-1 = "eu-west-1a"
    us-west-1 = "eu-east-1a"
  }
}

########################### demo VPC Config ##################################

variable "vpc_name" {
  description = "vpc_devops"
}

variable "vpc_region" {
  description = "AWS region"
}

variable "vpc_cidr_block" {
  description = "Uber IP addressing for demo Network"
}

variable "vpc_public_subnet_1_cidr" {
  description = "sub_public_devops"
}

variable "vpc_access_from_ip_range" {
  description = "Access can be made from the following IPs"
}

variable "vpc_private_subnet_1_cidr" {
  description = "Private CIDR for internally accessible subnet"
}
