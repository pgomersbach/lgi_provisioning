##### do not put keys in this file but use environment variables for access and secret access keys #####
variable "access_key" {}

variable "secret_key" {}

##### rapid7 scan engine settings #####
variable "rapid7_console_address" {
  description = "Rapid 7 console address"
  default     = "r7console"
}

variable "rapid7_console_port" {
  description = "Rapid 7 console port"
  default     = "40815"
}

variable "rapid7_console_secret" {
  description = "Rapid 7 console secret"
  default     = "changeme"
}

##### change these depending on environment #####
variable "environment" {
  description = "Environment to deploy"
  default     = "dev"
}

variable "region" {
  description = "EC2 Region for the VPC"
  default     = "eu-central-1"
}

variable "vpc_azs" {
  description = "Availability zones to use"
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "vpc_cidr" {
  description = "VPC cidr"
  default     = "172.19.8.0/25"
}

variable "vpc_private_subnets" {
  description = "Private subnets cidr"
  default     = ["172.19.8.0/27", "172.19.8.32/27"]
}

variable "vpc_public_subnets" {
  description = "Public subnets cidr"
  default     = ["172.19.8.64/27", "172.19.8.96/27"]
}

##### change only if using a diferent ssh key #####
variable "ssh_key_file" {
  description = "ssh key to access instances"
  default     = "~/.ssh/id_rsa.terraform"
}

##### ajust to scale the number of API servers #####
variable "api_instance_count" {
  description = "Instance count of api instances"
  default     = 2
}

##### ajust to change instance types #####
variable "api_instance_type" {
  description = "Instance type of api instances"
  default     = "m5.large"
}

variable "jump_instance_type" {
  description = "Instance type of jumpserver instances"
  default     = "t2.medium"
}

variable "rapid7_instance_type" {
  description = "Instance type of rapid7 instances"
  default     = "t2.large"
}

##### No need to change variables below this point #####
variable "hosted_zone" {
  description = "predefined hosted zone"
  default     = "api.cloud.libertyglobal.upc.biz"
}

variable "jump_username" {
  description = "Jump server user name"
  default     = "ec2-user"
}

variable "app_username" {
  description = "API server username"
  default     = "ec2-user"
}

variable "app_ami_name" {
  description = "Name of the ami to use for API servers"
  default     = "packer-app*"
}

variable "jump_ami_name" {
  description = "Name of the ami to use for jump server"
  default     = "packer-jump*"
}

variable "rapid7_ami_name" {
  description = "Name of the rapid7 ami"
  default     = "nexpose-pre-authorized-engine-*"
}

variable "ami_owner" {
  description = "Owner of the RedHat ami"
  default     = "536449617726"
}

variable "rapid7_ami_owner" {
  description = "Owner of the ami"
  default     = "679593333241"
}
