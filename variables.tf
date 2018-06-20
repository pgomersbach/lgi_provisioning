variable "access_key" {}
variable "secret_key" {}

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

variable "ami_owner" {
  description = "Owner of the ami"
  default     = "656878657103"
}

variable "api_instance_count" {
  description = "Instance type of api instances"
  default     = 1
}

variable "api_instance_type" {
  description = "Instance type of api instances"
  default     = "t2.micro"
}

variable "jump_instance_type" {
  description = "Instance type of jumpserver instances"
  default     = "t2.micro"
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

terraform {
  backend "s3" {
    bucket = "terraform-state-backend"
    key    = "tf.tfstate"
    region = "eu-central-1"
  }
}
