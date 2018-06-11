variable "access_key" {}
variable "secret_key" {}
variable "region" {
    description = "EC2 Region for the VPC"
    default = "eu-central-1"
}
variable "ami_name" {
    description = "Name of the ami to use"
    default = "packer-example*"
}
variable "ami_owner" {
    description = "Owner of the ami"
    default = "656878657103"
}
variable "api_instance_type" {
    description = "Instance type of api instances"
    default = "t2.micro"
}
variable "environment" {
    description = "Environment to deploy"
    default = "dev"
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
