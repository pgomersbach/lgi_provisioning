variable "access_key" {}
variable "secret_key" {}

variable "hosted_zone" {
  description = "predefined hosted zone"
  default     = "api.cloud.libertyglobal.upc.biz"
}

variable "jump_username" {
  default = "ec2-user"
}

variable "app_username" {
  default = "ec2-user"
}

variable "ssh_key_file" {
  default = "~/.ssh/id_rsa.terraform"
}

variable "region" {
  description = "EC2 Region for the VPC"
  default     = "eu-central-1"
}

variable "app_ami_name" {
  description = "Name of the ami to use"
  default     = "packer-app*"
}

variable "jump_ami_name" {
  description = "Name of the ami to use"
  default     = "packer-jump*"
}

variable "rapid7_ami_name" {
  description = "Name of the rapid7 ami"
  default     = "nexpose-pre-authorized-engine-*"
}

variable "ami_owner" {
  description = "Owner of the ami"
  default     = "536449617726"
}

variable "rapid7_ami_owner" {
  description = "Owner of the ami"
  default     = "679593333241"
}

variable "rapid7_console_address" {
  description = "Rapid 7 console"
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

variable "api_instance_count" {
  description = "Instance count of api instances"
  default     = 1
}

variable "api_instance_type" {
  description = "Instance type of api instances"
  default     = "t2.micro"
}

variable "jump_instance_type" {
  description = "Instance type of jumpserver instances"
  default     = "t2.medium"
}

variable "rapid7_instance_type" {
  description = "Instance type of rapid7 instances"
  default     = "t2.large"
}

variable "environment" {
  description = "Environment to deploy"
  default     = "dev"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "vpc_azs" {
  default = ["eu-central-1a", "eu-central-1b"]
}

variable "vpc_private_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc_public_subnets" {
  default = ["10.0.3.0/28", "10.0.3.16/28"]
}
