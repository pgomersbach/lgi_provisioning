data "aws_availability_zones" "allzones" {}

module "vpc" {
  source                 = "terraform-aws-modules/vpc/aws"
  name                   = "akana-vpc-${var.environment}"
  cidr                   = "${var.vpc_cidr}"
  azs                    = "${var.vpc_azs}"
  private_subnets        = "${var.vpc_private_subnets}"
  public_subnets         = "${var.vpc_public_subnets}"
  enable_nat_gateway     = true
  one_nat_gateway_per_az = true
  enable_vpn_gateway     = true

  tags = {
    Terraform   = "true"
    Environment = "${var.environment}"
  }
}
