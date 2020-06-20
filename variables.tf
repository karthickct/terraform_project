# main creds for AWS connection
variable "aws_access_key_id" {
  description = "kp_devops_id"
}

variable "aws_secret_access_key" {
  description = "kp_devops_key"
}

variable "availability_zone" {
  description = "availability zone used for the demo, based on region"
  default = {
    us-east-1 = "us-east-1a"
    us-west-1 = "us-west-1a"
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
