data "aws_availability_zones" "allzones" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "my-vpc"
  cidr = "10.0.0.0/16"
  azs             = ["eu-central-1a", "eu-central-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.3.0/28", "10.0.3.16/28"]
  enable_nat_gateway = true
  one_nat_gateway_per_az = true
  enable_vpn_gateway = true
  tags = {
    Terraform = "true"
    Environment = "test"
  }
}

